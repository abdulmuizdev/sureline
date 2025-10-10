/// Bottom sheet container for preferences management.
///
/// Provides a comprehensive preferences interface with navigation to various
/// settings and features. This widget serves as the main entry point for
/// all preferences and settings functionality, including general settings,
/// collections, own quotes, and other app features.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/preferenecs/app_icon_selection/presentation/bottom_sheet/app_icon_setting_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/collections_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/collection_detail_page.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/default/sub_pages/create_collection_page.dart';
import 'package:sureline/features/preferenecs/default/presentation/bottom_sheet/sub_pages/preferences_main_page.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/pages/favourites_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/pages/author_pref_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/general_settings/default/presentation/pages/general_settings_bottom_sheet.dart';
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
import 'package:sureline/features/notifications_settings/presentation/bottom_sheet/notification_detail_bottom_sheet/notification_detail_bottom_sheet.dart';
import 'package:sureline/features/notifications_settings/domain/entity/notification_preset_entity.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_bloc.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_event.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_state.dart';
import 'package:sureline/core/constants/sureline_default_notification_days.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/pages/own_quotes_bottom_sheet.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/pages/sub_pages/create_own_quote_page.dart';
import 'package:sureline/features/preferenecs/search/presentation/pages/search_bottom_sheet.dart';
import 'package:collection/collection.dart';

/// Configuration for route definitions.
///
/// This class encapsulates route configuration including the path,
/// builder function, and optional custom app bar for each route.
/// It provides a clean way to define routes with their associated
/// UI components and navigation behavior.
class RouteConfig {
  /// The route path.
  final String path;

  /// The widget builder function for the route.
  final Widget Function(BuildContext, GoRouterState) builder;

  /// Optional custom app bar for the route.
  final Widget Function(BuildContext, GoRouterState)? customAppBar;

  /// Creates a new route configuration.
  RouteConfig({required this.path, required this.builder, this.customAppBar});
}

/// Main preferences bottom sheet container.
///
/// This widget provides a comprehensive preferences interface with navigation
/// to various settings and features. It uses GoRouter for navigation and
/// includes bloc providers for state management. The bottom sheet serves as
/// the central hub for all app preferences and settings.
///
/// Key features:
/// - Centralized navigation to all preferences sections
/// - Bloc providers for state management
/// - Custom app bars for different sections
/// - Shell route with consistent layout
/// - Integration with collections and own quotes features
class PreferencesBottomSheet extends StatefulWidget {
  /// Creates a new preferences bottom sheet.
  const PreferencesBottomSheet({super.key});

  @override
  State<PreferencesBottomSheet> createState() => _PreferencesBottomSheetState();
}

class _PreferencesBottomSheetState extends State<PreferencesBottomSheet> {
  /// Navigator key for GoRouter.
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// GoRouter instance for navigation.
  late final GoRouter _router;

  /// List of route configurations.
  late final List<RouteConfig> _routeConfigs;

  @override
  void initState() {
    super.initState();
    _initializeRouteConfigs();
    _initializeRouter();
  }

  /// Initializes the route configurations for all preferences sections.
  ///
  /// Sets up routes for general settings, collections, own quotes,
  /// notifications, and other app features. Each route includes
  /// appropriate builders and custom app bars where needed.
  void _initializeRouteConfigs() {
    _routeConfigs = [
      RouteConfig(path: '/', builder: (context, state) => const PreferencesMainPage()),
      RouteConfig(
        path: '/general-settings',
        builder: (context, state) => const GeneralSettingsBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/manage-subscription',
        builder: (context, state) => const ManageSubscriptionBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/voice',
        builder: (context, state) => const VoiceBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/author-preferences',
        builder: (context, state) => const AuthorPrefBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/muted-content',
        builder: (context, state) => const MutedContentBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/name',
        builder: (context, state) => const NameBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/sound',
        builder: (context, state) => const SoundBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/streak',
        builder: (context, state) => const StreakSettingBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/more-apps',
        builder: (context, state) => const MoreAppsBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/vote-on-next-feature',
        builder: (context, state) => const VoteOnNextFeatureBottomSheet(),
      ),
      RouteConfig(
        path: '/general-settings/help',
        builder: (context, state) => const HelpBottomSheet(),
      ),
      RouteConfig(
        path: '/collections',
        builder: (context, state) => const CollectionsBottomSheet(),
        customAppBar: _buildCollectionsAppBar,
      ),
      RouteConfig(
        path: '/collections/create',
        builder: (context, state) => const CreateCollectionPage(),
        customAppBar: _buildCollectionsAppBar,
      ),
      RouteConfig(
        path: '/collections/detail/:collectionId/:name',
        builder: (context, state) {
          final collectionId = int.parse(state.pathParameters['collectionId'] ?? '0');
          final name = state.pathParameters['name'] ?? '';
          return CollectionDetailPage(
            collectionId: collectionId,
            name: name,
            onFavouritesUpdated: () {},
          );
        },
        customAppBar: _buildCollectionsAppBar,
      ),
      RouteConfig(
        path: '/app-icon',
        builder: (context, state) => const AppIconSettingBottomSheet(),
      ),
      RouteConfig(
        path: '/notifications',
        builder: (context, state) => const NotificationsSettingsBottomSheet(),
      ),
      RouteConfig(
        path: '/notifications/detail/:presetId',
        builder: (context, state) {
          final presetId = int.tryParse(state.pathParameters['presetId'] ?? '0') ?? 0;
          // Get the actual NotificationPresetEntity from the bloc
          return BlocProvider(
            create: (context) => locator<NotificationSettingBloc>()..add(GetNotificationPresets()),
            child: BlocBuilder<NotificationSettingBloc, NotificationSettingState>(
              builder: (context, state) {
                if (state is GotNotificationPresets) {
                  try {
                    final presetEntity = state.result.firstWhere((preset) => preset.id == presetId);
                    return NotificationDetailBottomSheet(presetEntity: presetEntity);
                  } catch (e) {
                    // Preset not found, go back
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (context.mounted) {
                        context.pop();
                      }
                    });
                    return const SizedBox.shrink();
                  }
                }
                // Show loading or fallback
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
        customAppBar: _buildNotificationDetailAppBar,
      ),
      RouteConfig(path: '/home-widget', builder: (context, state) => const HomeWidgetBottomSheet()),
      RouteConfig(
        path: '/own-quotes',
        builder: (context, state) => const OwnQuotesBottomSheet(),
        customAppBar: _buildOwnQuotesAppBar,
      ),
      RouteConfig(
        path: '/own-quotes/create',
        builder: (context, state) => const CreateOwnQuotePage(),
        customAppBar: _buildOwnQuotesAppBar,
      ),
      RouteConfig(
        path: '/search',
        builder: (context, state) => const SearchBottomSheet(),
        customAppBar: _buildSearchAppBar,
      ),
      RouteConfig(path: '/history', builder: (context, state) => const HistoryBottomSheet()),
      RouteConfig(
        path: '/favourites',
        builder: (context, state) => const FavouritesBottomSheet(),
        customAppBar: _buildFavouritesAppBar,
      ),
    ];
  }

  /// Initializes the GoRouter with all route configurations.
  ///
  /// Sets up the router with shell route for consistent layout,
  /// bloc providers for state management, and proper navigation
  /// structure for all preferences sections.
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
                    children: [_buildAppBar(context, state), const SizedBox(height: 27)],
                  ),
                ),
                Expanded(child: child),
              ],
            );

            // Wrap collections routes with CollectionsBloc
            // if (isCollectionsRoute) {
            content = MultiBlocProvider(
              providers: [
                BlocProvider<OwnQuotesBloc>(create: (context) => locator<OwnQuotesBloc>()),
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
                  .map((config) => GoRoute(path: config.path, builder: config.builder))
                  .toList(),
        ),
      ],
    );
  }

  /// Builds the app bar for the current route.
  ///
  /// Determines the appropriate app bar based on the current route
  /// and whether a custom app bar is defined for that route.
  ///
  /// [context]: The build context
  /// [state]: The current router state
  /// Returns: The appropriate app bar widget
  Widget _buildAppBar(BuildContext context, GoRouterState state) {
    final routeConfig = _getRouteConfig(state.uri.path);

    if (routeConfig?.customAppBar != null) {
      return routeConfig!.customAppBar!(context, state);
    }

    // Default back button behavior
    if (state.uri.path != '/') {
      return GestureDetector(
        onTap: _handleBack,
        child: Row(
          children: [
            const Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor, size: 20),
            Text(
              _getAppBarTitle(state.uri.path),
              style: const TextStyle(
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
      child: const Text(
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
          onTap: _handleBack,
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                title,
                style: const TextStyle(
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
            child: const Text(
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
          onTap: _handleBack,
          child: Row(
            children: [
              const Icon(
                Icons.keyboard_arrow_left_rounded,
                color: AppColors.primaryColor,
                size: 20,
              ),
              Text(
                title,
                style: const TextStyle(
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
            child: const Text(
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
          onTap: _handleBack,
          child: const Row(
            children: [
              Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor, size: 20),
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
          child: const Text(
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
          onTap: _handleBack,
          child: const Row(
            children: [
              Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor, size: 20),
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
          child: const Text(
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

  Widget _buildNotificationDetailAppBar(BuildContext context, GoRouterState state) {
    return GestureDetector(
      onTap: _handleBack,
      child: Row(
        children: [
          const Icon(Icons.keyboard_arrow_left_rounded, color: AppColors.primaryColor, size: 20),
          const Text(
            'Done',
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

  RouteConfig? _getRouteConfig(String path) {
    // First try exact match
    final exact = _routeConfigs.firstWhereOrNull((config) => config.path == path);
    if (exact != null) return exact;
    // If no exact match, try to match parameterized routes
    for (final config in _routeConfigs) {
      if (_matchesParameterizedRoute(config.path, path)) {
        return config;
      }
    }
    return RouteConfig(path: '', builder: (context, state) => const SizedBox());
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
      case '/notifications/detail':
        return 'Done';
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
      decoration: const BoxDecoration(
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
