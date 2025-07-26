/// Bottom sheet wrapper for collections list.
///
/// Provides a modal presentation of the collection list page.
/// This widget serves as a container for the collections list page,
/// presenting it as a bottom sheet modal. It provides a clean interface
/// for displaying collections in a modal context.

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/collection_list_page.dart';

/// Bottom sheet container for collections list.
///
/// This widget provides a modal presentation of the collections list page.
/// It wraps the collection list page in a bottom sheet container with
/// proper styling and navigation callbacks. The bottom sheet provides
/// a clean, focused interface for collections management.
///
/// Key features:
/// - Modal presentation with proper styling
/// - Navigation callbacks for detail and next actions
/// - Integration with collections bloc for state management
/// - Clean separation between container and content
class CollectionsBottomSheet extends StatelessWidget {
  /// Creates a new collections bottom sheet.
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
