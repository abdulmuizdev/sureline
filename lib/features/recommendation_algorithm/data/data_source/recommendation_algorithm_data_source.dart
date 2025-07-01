import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/constants/quotes_data_files.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/error/failures.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/model/quote_model.dart';

abstract class RecommendationAlgorithmDataSource {
  Future<Either<Failure, void>> initialize();
  Future<Either<Failure, List<QuoteModel>>> getQuotes(int page);
  Future<Either<Failure, void>> markQuoteAsShown(int id);
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes();
}

class RecommendationAlgorithmDataSourceImpl
    extends RecommendationAlgorithmDataSource {
  final QuotesDao quotesDao;

  RecommendationAlgorithmDataSourceImpl(this.quotesDao);

  @override
  Future<Either<Failure, void>> initialize() async {
    try {
      final existingQuotes = await quotesDao.getAllQuotes();

      if (existingQuotes.isEmpty) {
        final quotes = await _loadQuotesFromAssets();
        quotes.shuffle();
        for (final quote in quotes) {
          await quotesDao.addQuote(
            QuotesCompanion(
              quoteText: Value(quote.quoteText),
              author: Value(quote.author),
            ),
          );
        }
      }
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getQuotes(int page) async {
    try {
      print('page is this $page');
      final now = DateTime.now();
      final offset = page * Constants.quotesPageSize;
      print('offset is this $offset');
      final newQuotes = await quotesDao.getAllNewQuotes();
      print('newQuotes is this ${newQuotes.length}');
      // If we have enough new quotes for this page, return them
      if (offset <= newQuotes.length &&
          newQuotes.length >= (offset + Constants.quotesPageSize)) {
        final startIndex = offset;
        final endIndex = (offset + Constants.quotesPageSize).clamp(
          0,
          newQuotes.length,
        );
        print('startIndex is this $startIndex');
        print('endIndex is this $endIndex');
        final pageQuotes = newQuotes.sublist(startIndex, endIndex);

        final quoteModels =
            pageQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList();
        return Right(quoteModels);
      }

      // If we don't have enough new quotes, check if we have any remaining
      final remainingNewQuotes = newQuotes.length - offset;
      print('remainingNewQuotes is this $remainingNewQuotes');

      // If we don't have enough new quotes for a full page, recycle all quotes
      if (remainingNewQuotes < Constants.quotesPageSize) {
        // Store remaining new quotes in temp variable
        final remainingQuotes =
            remainingNewQuotes > 0 ? newQuotes.sublist(offset) : <Quote>[];

        // Get ALL quotes from database
        final allQuotes = await quotesDao.getAllQuotes();

        // Shuffle all quotes
        final shuffledQuotes = List<Quote>.from(allQuotes);
        shuffledQuotes.shuffle();

        // Delete all quotes from database
        await quotesDao.deleteAllQuotes();

        // Insert the newly shuffled quotes
        for (final quote in shuffledQuotes) {
          await quotesDao.addQuote(
            QuotesCompanion(
              quoteText: Value(quote.quoteText),
              author: Value(quote.author),
            ),
          );
        }

        // Calculate how many more quotes we need to reach page size
        final quotesNeeded = Constants.quotesPageSize - remainingQuotes.length;

        // Get the additional quotes needed from the newly shuffled database
        final additionalQuotes = await quotesDao.getAllNewQuotes();
        final additionalQuotesNeeded =
            additionalQuotes.take(quotesNeeded).toList();

        // Combine remaining quotes with additional quotes
        final finalQuotes = [
          ...remainingQuotes.map((quote) => QuoteModel.fromQuote(quote)),
          ...additionalQuotesNeeded.map((quote) => QuoteModel.fromQuote(quote)),
        ];

        if (finalQuotes.length != Constants.quotesPageSize) {
          print('Final quotes length is not equal to page size');
        }

        return Right(finalQuotes);
      }

      // If no new quotes remaining, return all quotes as fallback
      print('falling back');
      final fallbackQuotes = await quotesDao.getAllQuotes();
      return Right(
        fallbackQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> markQuoteAsShown(int id) async {
    try {
      await quotesDao.markQuoteAsShown(id, DateTime.now());
      return Right(unit);
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  @override
  Future<Either<Failure, List<QuoteModel>>> getShownQuotes() async {
    try {
      final shownQuotes = await quotesDao.getShownQuotes();
      return Right(
        shownQuotes.map((quote) => QuoteModel.fromQuote(quote)).toList(),
      );
    } catch (e) {
      debugPrint(e.toString());
      return Left(UnknownFailure());
    }
  }

  Future<List<QuoteModel>> _loadQuotesFromAssets() async {
    final files = QuotesDataFiles.files;

    final List<QuoteModel> allQuotes = [];

    for (final file in files) {
      final jsonStr = await rootBundle.loadString(file);
      final List<dynamic> jsonList = json.decode(jsonStr);
      allQuotes.addAll(jsonList.map((json) => QuoteModel.fromJson(json)));
    }
    return allQuotes;
  }
}
