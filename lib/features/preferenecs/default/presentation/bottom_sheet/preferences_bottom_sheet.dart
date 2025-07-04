import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_event.dart';
import 'package:sureline/features/preferenecs/default/presentation/bottom_sheet/sub_pages/preferences_main_page.dart';
import 'package:sureline/features/preferenecs/bottom_sheet/app_icon_setting_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/collections_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/collection_detail_page.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/create_collection_page.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/pages/favourites_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/default/presentation/pages/general_settings_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/pages/author_pref_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/help/presentation/help_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/more_apps/presentation/pages/more_apps_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/presentation/bottom_sheets/muted_content_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/name_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bottom_sheet/sound_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/streak/presentation/pages/streak_setting_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/pages/voice_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/vote_on_next_feature/presentation/vote_on_next_feature_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/history/presentation/pages/history_bottom_sheet.dart';
import 'package:sureline/features/home_widget/presentation/bottom_sheet/home_widget_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bottom_sheet/manage_subscription_bottom_sheet.dart';
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notifications_settings_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/pages/own_quotes_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/pages/sub_pages/create_own_quote_page.dart';
import 'package:sureline/features/preferenecs/search/presentation/pages/search_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_event.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RouteConfig {
  final String path;
  final Widget Function(BuildContext, GoRouterState) builder;
  final Widget Function(BuildContext, GoRouterState)? customAppBar;

  RouteConfig({required this.path, required this.builder, this.customAppBar});
}

class PreferencesBottomSheet extends StatefulWidget {
  const PreferencesBottomSheet({super.key});

  @override
  State<PreferencesBottomSheet> createState() => _PreferencesBottomSheetState();
}

class _PreferencesBottomSheetState extends State<PreferencesBottomSheet> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late final GoRouter _router;
  late final List<RouteConfig> _routeConfigs;

  @override
  void initState() {
    super.initState();
    _initializeRouteConfigs();
    _initializeRouter();
  }

  void _initializeRouteConfigs() {
    _routeConfigs = [
      RouteConfig(
        path: '/',
        builder: (context, state) => PreferencesMainPage(),
      ),
      RouteConfig(
        path: '/general-settings',
        builder: (context, state) => GeneralSettingsBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/manage-subscription',
        builder: (context, state) => ManageSubscriptionBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/voice',
        builder: (context, state) => VoiceBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/author-preferences',
        builder: (context, state) => AuthorPrefBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/muted-content',
        builder: (context, state) => MutedContentBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/name',
        builder: (context, state) => NameBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/sound',
        builder: (context, state) => SoundBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/streak',
        builder: (context, state) => StreakSettingBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/more-apps',
        builder: (context, state) => MoreAppsBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/vote-on-next-feature',
        builder: (context, state) => VoteOnNextFeatureBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/help',
        builder: (context, state) => HelpBottomSheet(),
      ),
      RouteConfig(
        path: '/collections',
        builder: (context, state) => CollectionsBottomSheet(),
        customAppBar:
            (context, state) => _buildCollectionsAppBar(context, state),
      ),
      RouteConfig(
        path: '/collections/create',
        builder: (context, state) => CreateCollectionPage(),
        customAppBar:
            (context, state) => _buildCollectionsAppBar(context, state),
      ),
      RouteConfig(
        path: '/collections/detail/:collectionId/:name',
        builder: (context, state) {
          final collectionId = int.parse(
            state.pathParameters['collectionId'] ?? '0',
          );
          final name = state.pathParameters['name'] ?? '';
          return CollectionDetailPage(
            collectionId: collectionId,
            name: name,
            onFavouritesUpdated: () {},
          );
        },
        customAppBar:
            (context, state) => _buildCollectionsAppBar(context, state),
      ),
      RouteConfig(
        path: '/app-icon',
        builder: (context, state) => AppIconSettingBottomSheet(),
      ),
      RouteConfig(
        path: '/notifications',
        builder: (context, state) => NotificationsSettingsBottomSheet(),
      ),
      RouteConfig(
        path: '/home-widget',
        builder: (context, state) => HomeWidgetBottomSheet(),
      ),
      RouteConfig(
        path: '/own-quotes',
        builder: (context, state) => OwnQuotesBottomSheet(),
        customAppBar: (context, state) => _buildOwnQuotesAppBar(context, state),
      ),
      RouteConfig(
        path: '/own-quotes/create',
        builder: (context, state) => CreateOwnQuotePage(),
        customAppBar: (context, state) => _buildOwnQuotesAppBar(context, state),
      ),
      RouteConfig(
        path: '/search',
        builder: (context, state) => SearchBottomSheet(),
        customAppBar: (context, state) => _buildSearchAppBar(context, state),
      ),
      RouteConfig(
        path: '/history',
        builder: (context, state) => HistoryBottomSheet(),
      ),
      RouteConfig(
        path: '/favourites',
        builder: (context, state) => FavouritesBottomSheet(),
        customAppBar:
            (context, state) => _buildFavouritesAppBar(context, state),
      ),
    ];
  }

  void _initializeRouter() {
    _router = GoRouter(
      navigatorKey: _navigatorKey,
      initialLocation: '/',
      routes: [
        ShellRoute(
          builder: (context, state, child) {
            Widget content = Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 18, left: 18, right: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAppBar(context, state),
                      SizedBox(height: 27),
                    ],
                  ),
                ),
                Expanded(child: child),
              ],
            );

            // Wrap collections routes with CollectionsBloc
            // if (isCollectionsRoute) {
            content = MultiBlocProvider(
              providers: [
                BlocProvider<CollectionsBloc>(
                  create: (context) => locator<CollectionsBloc>(),
                ),
                BlocProvider<OwnQuotesBloc>(
                  create: (context) => locator<OwnQuotesBloc>(),
                ),
              ],
              child: content,
            );
            // }

            // if (isOwnQuotesRoute) {
            // content = BlocProvider(
            //   create:
            //       (context) => locator<OwnQuotesBloc>()..add(GetOwnQuotes()),
            //   child: content,
            // );
            // }
            return content;
          },
          routes:
              _routeConfigs
                  .map(
                    (config) =>
                        GoRoute(path: config.path, builder: config.builder),
                  )
                  .toList(),
        ),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context, GoRouterState state) {
    final routeConfig = _getRouteConfig(state.uri.path);

    if (routeConfig?.customAppBar != null) {
      return routeConfig!.customAppBar!(context, state);
    }

    // Default back button behavior
    if (state.uri.path != '/') {
      return GestureDetector(
        onTap: () {
          _handleBack();
        },
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_left_rounded,
              color: AppColors.primaryColor,
              size: 20,
            ),
            Text(
              _getAppBarTitle(state.uri.path),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      );
    }

    // Show "Done" button for root preferences page
    return GestureDetector(
      onTap: () {
        // Close the bottom sheet using root navigator
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: Text(
        'Done',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: AppColors.primaryColor,
        ),
      ),
    );
  }

  Widget _buildCollectionsAppBar(BuildContext context, GoRouterState state) {
    final title = _getCollectionsAppBarTitle(state.uri.path);
    final showAddNew = state.uri.path == '/collections';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _handleBack();
          },
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        if (showAddNew)
          GestureDetector(
            onTap: () {
              context.push('/collections/create');
            },
            child: Text(
              'Add new',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildOwnQuotesAppBar(BuildContext context, GoRouterState state) {
    final title = _getOwnQuotesAppBarTitle(state.uri.path);
    final showAddNew = state.uri.path == '/own-quotes';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _handleBack();
          },
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        if (showAddNew)
          GestureDetector(
            onTap: () {
              context.push('/own-quotes/create');
            },
            child: Text(
              'Add new',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: AppColors.primaryColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSearchAppBar(BuildContext context, GoRouterState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _handleBack();
          },
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                'Sureline',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle "View all" action
            // This could navigate to a full search results page or close the bottom sheet
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            'View all',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFavouritesAppBar(BuildContext context, GoRouterState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            _handleBack();
          },
          child: Row(
            children: [
              Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                'Sureline',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Handle "View all" action
            // This could navigate to a full favourites page or close the bottom sheet
            Navigator.of(context, rootNavigator: true).pop();
          },
          child: Text(
            'View all',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  RouteConfig? _getRouteConfig(String path) {
    // First try exact match
    try {
      return _routeConfigs.firstWhere((config) => config.path == path);
    } catch (e) {
      // If no exact match, try to match parameterized routes
      for (final config in _routeConfigs) {
        if (_matchesParameterizedRoute(config.path, path)) {
          return config;
        }
      }
      return RouteConfig(path: '', builder: (context, state) => SizedBox());
    }
  }

  bool _matchesParameterizedRoute(String routePath, String currentPath) {
    if (!routePath.contains(':')) return false;

    final routeParts = routePath.split('/');
    final currentParts = currentPath.split('/');

    if (routeParts.length != currentParts.length) return false;

    for (int i = 0; i < routeParts.length; i++) {
      if (routeParts[i].startsWith(':')) continue;
      if (routeParts[i] != currentParts[i]) return false;
    }

    return true;
  }

  String _getAppBarTitle(String location) {
    switch (location) {
      case '/':
        return 'Done';
      case '/general-settings':
        return 'Sureline';
      case '/general-settings/manage-subscription':
        return 'General';
      case '/general-settings/voice':
        return 'General';
      case '/general-settings/author-preferences':
        return 'General';
      case '/general-settings/muted-content':
        return 'General';
      case '/general-settings/name':
        return 'General';
      case '/general-settings/sound':
        return 'General';
      case '/general-settings/streak':
        return 'General';
      case '/general-settings/more-apps':
        return 'General';
      case '/general-settings/vote-on-next-feature':
        return 'General';
      case '/general-settings/help':
        return 'General';
      case '/app-icon':
        return 'Sureline';
      case '/notifications':
        return 'Sureline';
      case '/home-widget':
        return 'Sureline';
      case '/own-quotes':
        return 'Sureline';
      case '/search':
        return 'Sureline';
      case '/history':
        return 'Sureline';
      case '/favourites':
        return 'Sureline';
      default:
        return 'Back';
    }
  }

  String _getCollectionsAppBarTitle(String location) {
    if (location.startsWith('/collections/detail/')) {
      return 'My collections';
    }

    switch (location) {
      case '/collections':
        return 'Sureline';
      case '/collections/create':
        return 'Close';
      default:
        return 'Collections';
    }
  }

  String _getOwnQuotesAppBarTitle(String location) {
    switch (location) {
      case '/own-quotes':
        return 'Sureline';
      case '/own-quotes/create':
        return 'Close';
      default:
        return 'Your own quotes';
    }
  }

  void _handleBack() {
    // If we can pop within the router, do that
    if (_router.canPop()) {
      _router.pop();
    } else {
      // Otherwise close the bottom sheet
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: AppColors.white,
      ),
      child: Router(
        routerDelegate: _router.routerDelegate,
        routeInformationParser: _router.routeInformationParser,
        routeInformationProvider: _router.routeInformationProvider,
      ),
    );
  }
}
