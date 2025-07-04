import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/collection_list_page.dart';

class CollectionsBottomSheet extends StatelessWidget {
  const CollectionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: CollectionListPage(
        onDetail: () {
          // This will be handled by GoRouter navigation
        },
        onNext: () {
          // This will be handled by GoRouter navigation
        },
        shouldRefreshCollections: false,
      ),
    );
  }
}
