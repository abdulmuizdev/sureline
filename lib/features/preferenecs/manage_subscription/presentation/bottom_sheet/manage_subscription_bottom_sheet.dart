import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/entity/subscription_record_entity.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_bloc.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_event.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_state.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/widgets/subscription_record_list_item.dart';

/// Bottom sheet widget for managing subscription details.
///
/// This widget provides a comprehensive interface for users to view
/// and manage their subscription status. It includes features like:
/// - Displaying current subscription status
/// - Showing subscription history and records
/// - Premium trial information
/// - Subscription management options
/// - Clear visual indicators for subscription state
///
/// The widget follows the Clean Architecture pattern by using BlocProvider
/// for state management and delegating business logic to the SubscriptionRecordBloc.
class ManageSubscriptionBottomSheet extends StatefulWidget {
  /// Creates a new ManageSubscriptionBottomSheet instance.
  const ManageSubscriptionBottomSheet({super.key});

  @override
  State<ManageSubscriptionBottomSheet> createState() => _ManageSubscriptionBottomSheetState();
}

class _ManageSubscriptionBottomSheetState extends State<ManageSubscriptionBottomSheet> {
  /// List of subscription record entities currently displayed
  List<SubscriptionRecordEntity> _subscriptionRecords = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the SubscriptionRecordBloc and trigger initial data loading
      create:
          (context) => locator<SubscriptionRecordBloc>()..add(const GetSubscriptionRecordsEvent()),
      child: BlocListener<SubscriptionRecordBloc, SubscriptionRecordState>(
        listener: (context, state) {
          // Update local state when subscription records are loaded
          if (state is SubscriptionRecordLoaded) {
            _subscriptionRecords = state.subscriptionRecords;
          }
        },
        child: BlocBuilder<SubscriptionRecordBloc, SubscriptionRecordState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.only(left: 18, right: 18),
              decoration: Utils.bottomSheetDecoration(ignoreCorners: true),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with title
                  const Text(
                    'Manage Subscription',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 22),
                  // Subscription status description
                  if (_subscriptionRecords.isEmpty) ...[
                    const Text(
                      'You are not subscribed to premium',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ] else ...[
                    Expanded(
                      child: Column(
                        children: [
                          // Premium trial information
                          Row(
                            children: [
                              const Icon(
                                CupertinoIcons.creditcard,
                                color: AppColors.primaryColor,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Sureline Premium',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 22),
                          // Subscription records list
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
                  const SizedBox(height: 10),

                  // Subscription content area
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
