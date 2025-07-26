import 'package:dio/dio.dart';
import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sureline/common/data/database/dao/references/collections_favourites_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_history_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_own_quotes_table_dao.dart';
import 'package:sureline/common/data/database/dao/references/collections_search_dao.dart';
import 'package:sureline/common/domain/use_cases/collections/add_favourite_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_history_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_own_quote_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/add_search_to_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_favourite_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_history_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_own_quote_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/collections/remove_search_from_collection_use_case.dart';
import 'package:sureline/common/domain/use_cases/convert_widget_to_png_use_case.dart';
import 'package:sureline/common/domain/use_cases/get_voice_use_case.dart';
import 'package:sureline/common/domain/use_cases/is_onboarding_completed_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_search_results_use_case.dart';
import 'package:sureline/common/domain/use_cases/schedule_up_to_sixty_notifications_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/can_log_streak_entry_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/clear_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_all_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_check_in_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_seven_days_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_total_streak_score_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/is_streak_broken_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/log_streak_entry_use_case.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
import 'package:sureline/common/presentation/bloc/icon_bloc.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/core/db/app_database.dart';
import 'package:sureline/core/network/network_info.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/data_source/create_and_edit_theme_data_source.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/repository/create_and_edit_theme_repository_impl.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/use_case/download_photo_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_bloc.dart';
import 'package:sureline/features/home/data/data_source/quote_data_source.dart';
import 'package:sureline/features/home/data/repository/quote_repository_impl.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';
import 'package:sureline/features/home/domain/use_cases/feed/is_feed_setup_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/feed/set_feed_setup_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/is_like_guide_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/set_like_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/save_all_quotes_to_app_group_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/set_onboarding_to_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/is_share_guide_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/set_share_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/is_swipe_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/set_swipe_to_completed_use_case.dart';
import 'package:sureline/features/home/presentation/bloc/home_bloc.dart';
import 'package:sureline/features/notifications_settings/data/data_source/notification_settings_data_source.dart';
import 'package:sureline/features/notifications_settings/data/repository/notification_setting_repository_impl.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/add_notification_preset_use_case';
import 'package:sureline/features/notifications_settings/domain/use_cases/cancel_notification_preset_case_case.dart';
import 'package:sureline/common/domain/use_cases/notifications_settings/edit_notification_preset_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/enable_notification_preset_case_case.dart';
import 'package:sureline/common/domain/use_cases/notifications_settings/get_notification_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/initialize_notifications_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_bloc.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_bloc.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_bloc.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_bloc.dart';
import 'package:sureline/features/preferenecs/collections/data/data_sources/collections_data_source.dart';
import 'package:sureline/features/preferenecs/collections/data/database/dao/collections_dao.dart';
import 'package:sureline/features/preferenecs/collections/data/repository/collections_repository_impl.dart';
import 'package:sureline/features/preferenecs/collections/domain/repository/collections_repository.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_favourites_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_history_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_own_quotes_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_of_search_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_collections_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_favourites_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_history_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_own_quotes_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/get_search_of_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/remove_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/domain/use_cases/save_collection_use_case.dart';
import 'package:sureline/features/preferenecs/collections/presentation/bloc/collections_bloc.dart';
import 'package:sureline/features/preferenecs/default/presentation/bloc/preferences_bloc.dart';
import 'package:sureline/features/preferenecs/favourites/data/data_source/favourites_data_source.dart';
import 'package:sureline/features/preferenecs/favourites/data/database/dao/favourites_dao.dart';
import 'package:sureline/features/preferenecs/favourites/data/repository/favourites_repository_impl.dart';
import 'package:sureline/features/preferenecs/favourites/domain/repository/favourites_repository.dart';
import 'package:sureline/common/domain/use_cases/favourites/add_favourite_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/get_favourites_count_use_case.dart';
import 'package:sureline/features/preferenecs/favourites/domain/use_cases/get_favourites_use_case.dart';
import 'package:sureline/common/domain/use_cases/favourites/remove_favourite_use_case.dart';
import 'package:sureline/features/preferenecs/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/author_preferences/presentation/bloc/author_pref_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/data_source/gender_identity_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/data/repository/gender_identity_repository_impl.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/use_case/get_gender_identities_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/domain/use_case/update_gender_identities_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/gender_identity/presentation/bloc/gender_identity_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/muted_content/presentation/bloc/muted_content_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/name/presentation/bloc/name_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/data/data_source/sound_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/data/repository/sound_repository_impl.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/repository/sound_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/domain/use_cases/set_volume_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/sound/presentation/bloc/sound_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/streak/bloc/streak_bloc.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/data_source/voice_data_source.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/data/repository/voice_repository_impl.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/repository/voice_repository.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/use_cases/change_voice_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/domain/use_cases/get_voices_use_case.dart';
import 'package:sureline/features/preferenecs/general_settings/voice/presentation/bloc/voice_bloc.dart';
import 'package:sureline/features/preferenecs/history/data/data_source/history_data_source.dart';
import 'package:sureline/features/preferenecs/history/data/repository/history_repository_impl.dart';
import 'package:sureline/features/preferenecs/history/domain/repository/history_repository.dart';
import 'package:sureline/features/preferenecs/history/domain/use_cases/get_history_use_case.dart';
import 'package:sureline/features/preferenecs/history/presentation/bloc/history_bloc.dart';
import 'package:sureline/features/preferenecs/manage_subscription/data/data_source/manage_subscription_data_source.dart';
import 'package:sureline/features/preferenecs/manage_subscription/data/repository/subscription_record_repository_impl.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/repository/subscription_record_repository.dart';
import 'package:sureline/features/preferenecs/manage_subscription/domain/use_cases/get_subscription_records_use_case.dart';
import 'package:sureline/features/preferenecs/manage_subscription/presentation/bloc/subscription_record_bloc.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/data_source/own_quotes_data_source.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/database/dao/own_quotes_dao.dart';
import 'package:sureline/features/preferenecs/own_quotes/data/repository/own_quotes_repository.impl.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/repository/own_quotes_repository.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/add_own_quote_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/get_all_own_quotes_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/domain/use_cases/remove_own_quote_use_case.dart';
import 'package:sureline/features/preferenecs/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/search/data/data_source/search_data_source.dart';
import 'package:sureline/features/preferenecs/search/data/repository/search_repository_impl.dart';
import 'package:sureline/features/preferenecs/search/domain/repository/search_repository.dart';
import 'package:sureline/features/preferenecs/search/domain/use_cases/get_search_use_case.dart';
import 'package:sureline/features/preferenecs/search/presentation/bloc/search_bloc.dart';
import 'package:sureline/features/recommendation_algorithm/data/data_source/recommendation_algorithm_data_source.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/author_prefs_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/muted_content_table_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/database/dao/quotes_dao.dart';
import 'package:sureline/features/recommendation_algorithm/data/repository/recommendation_algorithm_repository_impl.dart';
import 'package:sureline/features/recommendation_algorithm/domain/repository/recommendation_algorithm_repository.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/author_preferences/get_author_preferences_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/author_preferences/update_author_preference_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/get_muted_content_use_case.dart';
import 'package:sureline/common/domain/use_cases/recommendation_algorithm/get_quotes_from_recommendation_algorithm.dart';
import 'package:sureline/common/domain/use_cases/recommendation_algorithm/get_shown_quotes_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/initialize_recommendation_algorithm.dart';
import 'package:sureline/common/domain/use_cases/recommendation_algorithm/mark_quote_as_shown_use_case.dart';
import 'package:sureline/features/recommendation_algorithm/domain/use_cases/update_muted_content_use_case.dart';
import 'package:sureline/features/remote_config/data/data_source/remote_config_data_source.dart';
import 'package:sureline/features/remote_config/data/repository/remote_config_repository.dart';
import 'package:sureline/features/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:sureline/features/remote_config/domain/use_cases/prepare_remote_config_use_case.dart';
import 'package:sureline/features/share/data/data_source/share_data_source.dart';
import 'package:sureline/features/share/data/repository/share_repository_impl.dart';
import 'package:sureline/features/share/domain/repository/share_repository.dart';
import 'package:sureline/features/share/domain/use_cases/dispose_stream_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/get_render_results_stream_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/render_image_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/render_video_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/save_post_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_default_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_message_use_case.dart';
import 'package:sureline/features/share/domain/use_cases/share_on_social_use_case.dart';
import 'package:sureline/features/share/presentation/bloc/share_bloc.dart';
import 'package:sureline/features/streak/data/data_source/streak_data_source.dart';
import 'package:sureline/features/streak/data/repository/streak_repository_impl.dart';
import 'package:sureline/features/streak/domain/repository/streak_repository.dart';
import 'package:sureline/features/theme_selection/data/data_source/theme_data_source.dart';
import 'package:sureline/features/theme_selection/data/repository/theme_selector_repository_impl.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_theme_mixes_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/get_themes_use_case.dart';
import 'package:sureline/features/theme_selection/domain/use_case/set_theme_use_case.dart';
import 'package:sureline/features/theme_selection/presentation/bloc/theme_selector_bloc.dart';
import 'package:sureline/features/unsplash_screen/data/data_source/photo_data_source.dart';
import 'package:sureline/features/unsplash_screen/data/repository/photo_repository_impl.dart';
import 'package:sureline/features/unsplash_screen/domain/repository/photo_repository.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_search_results_use_case.dart';
import 'package:sureline/features/unsplash_screen/domain/use_case/get_photos_use_case.dart';
import 'package:sureline/features/unsplash_screen/presentation/bloc/photo_bloc.dart';

/// Global dependency injection locator instance.
final GetIt locator = GetIt.instance;

/// Sets up the dependency injection container with all required dependencies.
Future<void> setupLocator() async {
  locator
    ..registerSingleton<AppDatabase>(AppDatabase())
    ..registerFactory(Dio.new)
    ..registerFactory<NetworkInfo>(NetworkInfoImpl.new)
    ..registerFactory(http.Client.new)
    ..registerSingletonAsync<SharedPreferences>(() async {
      final prefs = await SharedPreferences.getInstance();
      return prefs;
    })
    ..registerFactory<RemoteConfigDataSource>(
      () => RemoteConfigDataSourceImpl(locator(), locator()),
    )
    ..registerFactory<RemoteConfigRepository>(() => RemoteConfigRepositoryImpl(locator()))
    ..registerFactory(() => PrepareRemoteConfigUseCase(locator()))
    ..registerFactory(() => IconBloc(FlutterAppIconChangerPlugin(iconsSet: SurelineIcons.values)))
    ..registerFactory(() => ThemeBloc(locator(), locator()))
    ..registerFactory(CategoryBloc.new)
    ..registerFactory<QuoteDataSource>(() => QuoteDataSourceImpl(locator()))
    ..registerFactory<QuoteRepository>(() => QuoteRepositoryImpl(locator()))
    ..registerFactory(() => IsOnboardingCompletedUseCase(locator()))
    ..registerFactory(() => SetOnboardingToCompletedUseCase(locator()))
    ..registerFactory(() => IsSwipeCompletedUseCase(locator()))
    ..registerFactory(() => IsFeedSetupShownUseCase(locator()))
    ..registerFactory(() => IsLikeGuideShownUseCase(locator()))
    ..registerFactory(() => IsShareGuideShownUseCase(locator()))
    ..registerFactory(() => SetSwipeToCompletedUseCase(locator()))
    ..registerFactory(() => SetFeedSetupToShownUseCase(locator()))
    ..registerFactory(() => SetLikeGuideToShownUseCase(locator()))
    ..registerFactory(() => SetShareGuideToShownUseCase(locator()))
    ..registerFactory(() => GetQuotesSearchResultsUseCase(locator()))
    ..registerFactory(() => SaveAllQuotesToAppGroupUseCase(locator()))
    ..registerFactory(() => AddFavouriteUseCase(locator()))
    ..registerFactory(() => RemoveFavouriteUseCase(locator()))
    ..registerFactory(() => GetFavouritesCountUseCase(locator()))
    ..registerFactory(() => RemoveFavouriteFromCollectionUseCase(locator()))
    ..registerFactory(() => AddFavouriteToCollectionUseCase(locator()))
    ..registerFactory(() => OwnQuotesDao(locator()))
    ..registerFactory(() => CollectionsOwnQuotesTableDao(locator()))
    ..registerFactory<OwnQuotesDataSource>(() => OwnQuotesDataSourceImpl(locator(), locator()))
    ..registerFactory<OwnQuotesRepository>(() => OwnQuotesRepositoryImpl(locator()))
    ..registerFactory(() => GetAllOwnQuotesUseCase(locator()))
    ..registerFactory(() => AddOwnQuoteUseCase(locator()))
    ..registerFactory(() => RemoveOwnQuoteUseCase(locator()))
    ..registerFactory(
      () => HomeBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    )
    ..registerFactory(() => QuotesDao(locator()))
    ..registerFactory(() => AuthorPrefsTableDao(locator()))
    ..registerFactory(() => MutedContentTableDao(locator()))
    ..registerFactory<RecommendationAlgorithmDataSource>(
      () => RecommendationAlgorithmDataSourceImpl(locator(), locator(), locator()),
    )
    ..registerFactory<RecommendationAlgorithmRepository>(
      () => RecommendationAlgorithmRepositoryImpl(locator()),
    )
    ..registerFactory(() => GetQuotesFromRecommendationAlgorithm(locator()))
    ..registerFactory(() => InitializeRecommendationAlgorithm(locator()))
    ..registerFactory(() => MarkQuoteAsShownUseCase(locator()))
    ..registerLazySingleton(
      () => OwnQuotesBloc(locator(), locator(), locator(), locator(), locator()),
    )
    ..registerFactory<CollectionsDataSource>(
      () => CollectionsDataSourceImpl(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    )
    ..registerFactory<CollectionsDao>(() => CollectionsDao(locator()))
    ..registerFactory<CollectionsRepository>(() => CollectionsRepositoryImpl(locator()))
    ..registerFactory(() => GetCollectionsUseCase(locator()))
    ..registerFactory(() => SaveCollectionUseCase(locator()))
    ..registerFactory(() => RemoveCollectionUseCase(locator()))
    ..registerFactory(() => GetFavouritesOfCollectionUseCase(locator()))
    ..registerFactory(() => GetCollectionsOfFavouritesUseCase(locator()))
    ..registerFactory(() => AddOwnQuoteToCollectionUseCase(locator()))
    ..registerFactory(() => RemoveOwnQuoteFromCollectionUseCase(locator()))
    ..registerFactory(() => GetOwnQuotesOfCollectionUseCase(locator()))
    ..registerFactory(() => GetHistoryOfCollectionUseCase(locator()))
    ..registerFactory(() => GetCollectionsOfHistoryUseCase(locator()))
    ..registerFactory(() => CollectionsHistoryDao(locator()))
    ..registerFactory(() => CollectionsSearchDao(locator()))
    ..registerFactory(() => GetCollectionsOfOwnQuotesUseCase(locator()))
    ..registerFactory(() => AddHistoryToCollectionUseCase(locator()))
    ..registerFactory(() => RemoveHistoryFromCollectionUseCase(locator()))
    ..registerFactory(() => AddSearchToCollectionUseCase(locator()))
    ..registerFactory(() => RemoveSearchFromCollectionUseCase(locator()))
    ..registerFactory(() => GetSearchOfCollectionUseCase(locator()))
    ..registerFactory(() => GetCollectionsOfSearchUseCase(locator()))
    ..registerFactory(
      () => CollectionsBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    )
    ..registerFactory<VoiceDataSource>(VoiceDataSourceImpl.new)
    ..registerFactory<VoiceRepository>(() => VoiceRepositoryImpl(locator()))
    ..registerFactory(() => GetVoicesUseCase(locator()))
    ..registerFactory(() => GetVoiceUseCase(locator()))
    ..registerFactory(() => ChangeVoiceUseCase(locator()))
    ..registerFactory(() => VoiceBloc(getVoicesUseCase: locator(), changeVoiceUseCase: locator()))
    ..registerFactory<ShareDataSource>(ShareDataSourceImpl.new)
    ..registerFactory<ShareRepository>(() => ShareRepositoryImpl(locator()))
    ..registerFactory(() => RenderVideoPostUseCase(locator()))
    ..registerFactory(() => GetRenderResultsStreamUseCase(locator()))
    ..registerFactory(() => ShareOnSocialUseCase(locator()))
    ..registerFactory(() => ShareOnMessageUseCase(locator()))
    ..registerFactory(() => ShareOnDefaultUseCase(locator()))
    ..registerFactory(() => SavePostUseCase(locator()))
    ..registerFactory(() => RenderImagePostUseCase(locator()))
    ..registerFactory(() => DisposeStreamUseCase(locator()))
    ..registerFactory(
      () => ShareBloc(
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
        locator(),
      ),
    )
    ..registerFactory<ThemeDataSource>(() => ThemeDataSourceImpl(locator()))
    ..registerFactory<ThemeSelectorRepository>(() => ThemeSelectorRepositoryImpl(locator()))
    ..registerFactory(() => GetThemesUseCase(locator()))
    ..registerFactory(() => GetThemeMixesUseCase(locator()))
    ..registerFactory(() => ChangeThemeUseCase(locator()))
    ..registerFactory(() => SetThemeUseCase(locator()))
    ..registerFactory(() => ThemeSelectorBloc(locator(), locator(), locator()))
    ..registerFactory<PhotoDataSource>(() => PhotoDataSourceImpl(locator()))
    ..registerFactory<PhotoRepository>(() => PhotoRepositoryImpl(locator()))
    ..registerFactory(() => GetPhotosUseCase(locator()))
    ..registerFactory(() => GetPhotosSearchResultsUseCase(locator()))
    ..registerFactory(() => PhotoBloc(locator(), locator()))
    ..registerFactory<CreateThemeDataSource>(() => CreateThemeDataSourceImpl(locator()))
    ..registerFactory<CreateThemeRepository>(() => CreateThemeRepositoryImpl(locator()))
    ..registerFactory(() => DownloadPhotoUseCase(locator()))
    ..registerFactory(() => CreateThemeBloc(locator(), locator()))
    ..registerFactory<SoundDataSource>(SoundDataSourceImpl.new)
    ..registerFactory<SoundRepository>(() => SoundRepositoryImpl(locator()))
    ..registerFactory(() => GetVolumeUseCase(locator()))
    ..registerFactory(() => SetVolumeUseCase(locator()))
    ..registerFactory(() => SoundBloc(getVolumeUseCase: locator(), setVolumeUseCase: locator()))
    ..registerFactory<NotificationSettingsDataSource>(
      () => NotificationSettingsDataSourceImpl(locator(), locator()),
    )
    ..registerFactory<NotificationSettingRepository>(
      () => NotificationSettingRepositoryImpl(locator()),
    )
    ..registerFactory(() => GetNotificationPresetsUseCase(locator()))
    ..registerFactory(() => AddNotificationPresetUseCase(locator()))
    ..registerFactory(() => CancelNotificationPresetCaseCase(locator()))
    ..registerFactory(() => EnableNotificationPresetCaseCase(locator()))
    ..registerFactory(() => EditNotificationPresetUseCase(locator()))
    ..registerFactory(() => InitializeNotificationsPresetsUseCase(locator()))
    ..registerFactory(() => ScheduleUpToSixtyNotificationsUseCase(locator()))
    ..registerFactory(
      () => NotificationSettingBloc(locator(), locator(), locator(), locator(), locator()),
    )
    ..registerFactory<StreakDataSource>(() => StreakDataSourceImpl(locator()))
    ..registerFactory<StreakRepository>(() => StreakRepositoryImpl(locator()))
    ..registerFactory(() => GetLastSevenDaysStreakDataUseCase(locator()))
    ..registerFactory(CanLogStreakEntryUseCase.new)
    ..registerFactory(() => GetLastCheckInUseCase(locator()))
    ..registerFactory(() => LogStreakEntryUseCase(locator()))
    ..registerFactory(() => IsStreakBrokenUseCase(locator()))
    ..registerFactory(() => ClearStreakDataUseCase(locator()))
    ..registerFactory(() => GetAllStreakDataUseCase(locator()))
    ..registerFactory(() => ConvertWidgetToPngUseCase(locator()))
    ..registerFactory(() => GetTotalStreakScoreUseCase(locator()))
    ..registerFactory(() => GetAuthorPreferencesUseCase(locator()))
    ..registerFactory(() => UpdateAuthorPreferenceUseCase(locator()))
    ..registerFactory(() => AuthorPrefBloc(locator(), locator()))
    ..registerFactory(() => GetMutedContentUseCase(locator()))
    ..registerFactory(() => UpdateMutedContentUseCase(locator()))
    ..registerFactory(() => MutedContentBloc(locator(), locator()))
    ..registerFactory<ManageSubscriptionDataSource>(ManageSubscriptionDataSourceImpl.new)
    ..registerFactory<SubscriptionRecordRepository>(
      () => SubscriptionRecordRepositoryImpl(dataSource: locator()),
    )
    ..registerFactory(() => GetSubscriptionRecordsUseCase(repository: locator()))
    ..registerFactory(
      () => SubscriptionRecordBloc(
        getSubscriptionRecordsUseCase: GetSubscriptionRecordsUseCase(repository: locator()),
      ),
    )
    ..registerFactory<GenderIdentityDataSource>(() => GenderIdentityDataSourceImpl(locator()))
    ..registerFactory<GenderIdentityRepository>(() => GenderIdentityRepositoryImpl(locator()))
    ..registerFactory(() => GetGenderIdentitiesUseCase(locator()))
    ..registerFactory(() => UpdateGenderIdentitiesUseCase(locator()))
    ..registerFactory(
      () => GenderIdentityBloc(
        getGenderIdentitiesUseCase: locator(),
        updateGenderIdentitiesUseCase: locator(),
      ),
    )
    ..registerFactory(() => NameBloc(locator()))
    ..registerFactory(() => OnboardingNameBloc(locator()))
    ..registerFactory(() => StreakBloc(locator()))
    ..registerFactory<FavouritesDataSource>(
      () => FavouritesDataSourceImpl(
        favouritesDao: locator(),
        collectionsFavouritesDao: locator(),
        collectionsOwnQuotesTableDao: locator(),
        collectionsHistoryDao: locator(),
        collectionsSearchDao: locator(),
      ),
    )
    ..registerFactory<FavouritesRepository>(() => FavouritesRepositoryImpl(locator()))
    ..registerFactory(() => GetFavouritesUseCase(locator()))
    ..registerFactory(() => FavouritesDao(locator()))
    ..registerFactory(() => CollectionsFavouritesDao(locator()))
    ..registerFactory<SearchDataSource>(() => SearchDataSourceImpl(locator(), locator()))
    ..registerFactory<SearchRepository>(() => SearchRepositoryImpl(locator()))
    ..registerFactory(() => GetSearchUseCase(locator()))
    ..registerFactory(() => FavouritesBloc(locator(), locator(), locator(), locator()))
    ..registerFactory(() => SearchBloc(locator(), locator(), locator(), locator()))
    ..registerFactory(
      () => PreferencesBloc(
        getLastSevenDaysStreakDataUseCase: locator(),
        getTotalStreakScoreUseCase: locator(),
        convertWidgetToPngUseCase: locator(),
        getFavouritesCountUseCase: locator(),
        getQuotesFromRecommendationAlgorithm: locator(),
        prefs: locator(),
      ),
    )
    ..registerFactory(() => GetShownQuotesUseCase(locator()))
    ..registerFactory<HistoryDataSource>(() => HistoryDataSourceImpl(locator(), locator()))
    ..registerFactory<HistoryRepository>(() => HistoryRepositoryImpl(locator()))
    ..registerFactory(() => GetHistoryUseCase(locator()))
    ..registerFactory(() => HistoryBloc(locator(), locator(), locator()));
  await locator.allReady();
}
