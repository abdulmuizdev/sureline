import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/pages/sub_pages/own_quotes_list_page.dart';

class OwnQuotesBottomSheet extends StatelessWidget {
  const OwnQuotesBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: OwnQuotesListPage(
        onNext: () {
          // This will be handled by GoRouter navigation
        },
      ),
    );
  }
}
