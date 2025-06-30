import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/presentation/widgets/bottom_sheet_app_bar.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/collections/domain/entity/collection_entity.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/features/collections/presentation/bloc/collections_state.dart';
import 'package:sureline/features/collections/presentation/pages/default/sub_pages/collection_list_page.dart';
import 'package:sureline/features/collections/presentation/pages/default/sub_pages/create_collection_page.dart';

class CollectionsBottomSheet extends StatefulWidget {
  const CollectionsBottomSheet({super.key});

  @override
  State<CollectionsBottomSheet> createState() => _CollectionsBottomSheetState();
}

class _CollectionsBottomSheetState extends State<CollectionsBottomSheet> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  String _appBarTitle = 'Sureline';
  bool _isAddNewVisible = true;
  bool _shouldRefreshCollections = false;
  @override
  void initState() {
    super.initState();
    _navigatorKey.currentState?.setState(() {});
  }

  void _handleBack() {
    if (_navigatorKey.currentState?.canPop() ?? false) {
      setState(() {
        _appBarTitle = 'Sureline';
      });
      _navigatorKey.currentState?.pop();
    } else {
      Navigator.of(context).pop();
    }
  }

  void _handleAddNew() async {
    setState(() {
      _appBarTitle = 'Close';
      _isAddNewVisible = false;
    });

    final updatedCollections = await _navigatorKey.currentState?.push<
      List<CollectionEntity>?
    >(CupertinoPageRoute(builder: (context) => const CreateCollectionPage()));

    if (mounted) {
      setState(() {
        _isAddNewVisible = true;
        _shouldRefreshCollections = true;
      });
    }
  }

  void _updateAppBarTitle(String title) {
    if (mounted) {
      setState(() {
        _appBarTitle = title;
        _isAddNewVisible = (title != 'My collections');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CollectionsBloc>(
          create:
              (context) => locator<CollectionsBloc>()..add(GetCollections()),
        ),
      ],
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        child: Container(
          color: AppColors.white,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: AppColors.white,
                      child: BottomSheetAppBar(
                        title: _appBarTitle,
                        onBack: _handleBack,
                      ),
                    ),
                    if (_isAddNewVisible)
                      GestureDetector(
                        onTap: _handleAddNew,
                        child: const Text(
                          'Add new',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (settings) {
                    return CupertinoPageRoute(
                      builder:
                          (context) => CollectionListPage(
                            onDetail:
                                () => _updateAppBarTitle('My collections'),
                            onNext: () => _updateAppBarTitle('Back'),
                            shouldRefreshCollections: _shouldRefreshCollections,
                          ),
                      settings: settings,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
