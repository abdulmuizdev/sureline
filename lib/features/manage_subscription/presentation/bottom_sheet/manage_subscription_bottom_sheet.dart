import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/heading.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/common/presentation/dialog/streak/widget/sureline_back_button.dart';
import 'package:sureline/features/manage_subscription/presentation/bloc/subscription_record_bloc.dart';
import 'package:sureline/features/manage_subscription/presentation/bloc/subscription_record_event.dart';
import 'package:sureline/features/manage_subscription/presentation/bloc/subscription_record_state.dart';
import 'package:sureline/features/manage_subscription/presentation/widgets/subscription_record_list_item.dart';
import 'package:sureline/features/manage_subscription/domain/entity/subscription_record_entity.dart';

class ManageSubscriptionBottomSheet extends StatefulWidget {
  const ManageSubscriptionBottomSheet({super.key});

  @override
  State<ManageSubscriptionBottomSheet> createState() =>
      _ManageSubscriptionBottomSheetState();
}

class _ManageSubscriptionBottomSheetState
    extends State<ManageSubscriptionBottomSheet> {
  List<SubscriptionRecordEntity> _subscriptionRecords = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              locator<SubscriptionRecordBloc>()
                ..add(GetSubscriptionRecordsEvent()),
      child: BlocListener<SubscriptionRecordBloc, SubscriptionRecordState>(
        listener: (context, state) {
          if (state is SubscriptionRecordLoaded) {
            _subscriptionRecords = state.subscriptionRecords;
          }
        },
        child: BlocBuilder<SubscriptionRecordBloc, SubscriptionRecordState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, top: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SurelineBackButton(title: 'Sureline'),
                  const SizedBox(height: 27),
                  Text(
                    'Manage Subscription',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 22),
                  Text(
                    'You are not subscribed to:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(
                              CupertinoIcons.creditcard,
                              color: AppColors.primaryColor,
                              size: 24,
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'Sureline free Premium trial',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 22),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _subscriptionRecords.length,
                            itemBuilder: (context, index) {
                              final record = _subscriptionRecords[index];
                              return SubscriptionRecordListItem(
                                showLine: index > 0,
                                title: record.title,
                                date: record.date,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
