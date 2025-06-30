import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/sureline_button.dart';
import 'package:sureline/common/presentation/widgets/sureline_text_field.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/own_quotes/domain/entity/own_quote_entity.dart';

import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_state.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({super.key});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final _quoteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<OwnQuotesBloc>())],
      child: BlocListener<OwnQuotesBloc, OwnQuotesState>(
        listener: (context, state) {
          if (state is SavedOwnQuote) {
            Navigator.of(context).pop(state.ownQuotes);
          }
        },
        child: BlocBuilder<OwnQuotesBloc, OwnQuotesState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                // mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add new',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Add your own quote. It will only be visible to you',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  SizedBox(height: 20),
                  SurelineTextField(
                    controller: _quoteController,
                    showCharLimit: false,
                    hint: 'Type your quote',
                    disableCenterAlignment: true,
                    isNameInput: false,
                  ),
                  Spacer(),
                  SurelineButton(
                    text: 'Save',
                    onPressed: () {
                      context.read<OwnQuotesBloc>().add(
                        SaveOwnQuote(
                          OwnQuoteEntity(
                            id: 0,
                            createdAt: DateTime.now().toIso8601String(),
                            quoteText: _quoteController.text,
                            collections: [],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
