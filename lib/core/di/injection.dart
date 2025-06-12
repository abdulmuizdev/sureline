import 'package:dio/dio.dart';
import 'package:flutter_app_icon_changer/flutter_app_icon_changer.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/domain/use_cases/convert_widget_to_png_use_case.dart';
import 'package:sureline/common/domain/use_cases/own_quotes/get_own_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/own_quotes/record/remove_own_quote_use_case.dart';
import 'package:sureline/common/domain/use_cases/own_quotes/record/save_own_quote_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_liked_quotes_count_use_case.dart';
import 'package:sureline/common/domain/use_cases/get_voice_use_case.dart';
import 'package:sureline/common/domain/use_cases/is_onboarding_completed_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_search_results_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_random_quotes_use_case.dart';
import 'package:sureline/common/domain/use_cases/schedule_up_to_sixty_notifications_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/clear_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_all_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_check_in_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_last_seven_days_streak_data_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/get_total_streak_score_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/is_streak_broken_use_case.dart';
import 'package:sureline/common/domain/use_cases/streak/log_streak_entry_use_case.dart';
import 'package:sureline/core/constants/sureline_icons.dart';
import 'package:sureline/core/network/network_info.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/data_source/create_and_edit_theme_data_source.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/repository/create_and_edit_theme_repository_impl.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/repository/create_and_edit_theme_repository.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/domain/use_case/download_photo_use_case.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_bloc.dart';
import 'package:sureline/features/favourites/presentation/bloc/favourites_bloc.dart';
import 'package:sureline/features/general_settings/content_preferences/data/data_source/content_prefs_data_source.dart';
import 'package:sureline/features/general_settings/content_preferences/data/repository/content_pref_repository_impl.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/repository/content_pref_repository.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/use_case/get_content_prefs_use_case.dart';
import 'package:sureline/features/general_settings/content_preferences/domain/use_case/update_content_prefs_use_case.dart';
import 'package:sureline/features/general_settings/content_preferences/presentation/bloc/content_pref_bloc.dart';
import 'package:sureline/features/general_settings/gender_identity/data/data_source/gender_identity_data_source.dart';
import 'package:sureline/features/general_settings/gender_identity/data/repository/gender_identity_repository_impl.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/repository/gender_identity_repository.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/use_case/get_gender_identities_use_case.dart';
import 'package:sureline/features/general_settings/gender_identity/domain/use_case/update_gender_identities_use_case.dart';
import 'package:sureline/features/general_settings/gender_identity/presentation/bloc/gender_identity_bloc.dart';
import 'package:sureline/features/general_settings/name/presentation/bloc/name_bloc.dart';
import 'package:sureline/features/general_settings/sound/data/data_source/sound_data_source.dart';
import 'package:sureline/features/general_settings/sound/data/repository/sound_repository_impl.dart';
import 'package:sureline/features/general_settings/sound/domain/repository/sound_repository.dart';
import 'package:sureline/features/general_settings/sound/domain/use_cases/get_volume_use_case.dart';
import 'package:sureline/features/general_settings/sound/domain/use_cases/set_volume_use_case.dart';
import 'package:sureline/features/general_settings/sound/presentation/bloc/sound_bloc.dart';
import 'package:sureline/features/general_settings/streak/bloc/streak_bloc.dart';
import 'package:sureline/features/general_settings/voice/data/data_source/voice_data_source.dart';
import 'package:sureline/features/general_settings/voice/data/repository/voice_repository_impl.dart';
import 'package:sureline/features/general_settings/voice/domain/repository/voice_repository.dart';
import 'package:sureline/features/general_settings/voice/domain/use_cases/change_voice_use_case.dart';
import 'package:sureline/features/general_settings/voice/domain/use_cases/get_voices_use_case.dart';
import 'package:sureline/features/general_settings/voice/presentation/bloc/voice_bloc.dart';
import 'package:sureline/features/home/data/data_source/quote_data_source.dart';
import 'package:sureline/features/home/data/repository/quote_repository_impl.dart';
import 'package:sureline/features/home/domain/repository/quote_repository.dart';
import 'package:sureline/features/home/domain/use_cases/like/decrement_like_count_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/get_like_count_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/increment_like_count_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/feed/is_feed_setup_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/is_like_guide_shown_use_case.dart';
import 'package:sureline/common/domain/use_cases/quote/get_liked_quotes_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/record/remove_liked_quote_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/record/save_liked_quote_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/is_share_guide_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/is_swipe_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/save_all_quotes_to_app_group_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/feed/set_feed_setup_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/like/guide/set_like_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/set_onboarding_to_completed_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/share/set_share_guide_to_shown_use_case.dart';
import 'package:sureline/features/home/domain/use_cases/swipe/set_swipe_to_completed_use_case.dart';
import 'package:sureline/features/home/presentation/bloc/home_bloc.dart';
import 'package:sureline/features/notifications_settings/data/data_source/notification_settings_data_source.dart';
import 'package:sureline/features/notifications_settings/data/repository/notification_setting_repository_impl.dart';
import 'package:sureline/features/notifications_settings/domain/repository/notification_setting_repository.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/add_notification_preset_use_case';
import 'package:sureline/features/notifications_settings/domain/use_cases/cancel_notification_preset_case_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/edit_notification_preset_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/enable_notification_preset_case_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/get_notification_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/domain/use_cases/initialize_notifications_presets_use_case.dart';
import 'package:sureline/features/notifications_settings/presentation/bloc/notification_setting_bloc.dart';
import 'package:sureline/features/onboarding/icon_selection/presentation/bloc/icon_bloc.dart';
import 'package:sureline/features/onboarding/interested_catag/presentation/bloc/category_bloc.dart';
import 'package:sureline/features/onboarding/name/presentation/bloc/onboarding_name_bloc.dart';
import 'package:sureline/features/onboarding/theme_selection/presentation/bloc/theme_bloc.dart';
import 'package:sureline/features/own_quotes/presentation/bloc/own_quotes_bloc.dart';
import 'package:sureline/features/preferenecs/presentation/bloc/preferences_bloc.dart';
import 'package:sureline/features/remote_config/data/data_source/remote_config_data_source.dart';
import 'package:sureline/features/remote_config/data/repository/remote_config_repository.dart';
import 'package:sureline/features/remote_config/domain/repositories/remote_config_repository.dart';
import 'package:sureline/features/remote_config/domain/use_cases/prepare_remote_config_use_case.dart';
import 'package:sureline/features/search/presentation/bloc/search_bloc.dart';
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
import 'package:sureline/common/domain/use_cases/streak/can_log_streak_entry_use_case.dart';
import 'package:sureline/features/streak/presentation/share_streak_render_widget.dart';
import 'package:sureline/features/theme_selection/data/data_source/theme_data_source.dart';
import 'package:sureline/features/theme_selection/data/repository/theme_selector_repository_impl.dart';
import 'package:sureline/features/theme_selection/domain/repository/theme_selector_repository.dart';
import 'package:sureline/common/domain/use_cases/change_theme_use_case.dart';
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
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerFactory(() => Dio());
  locator.registerFactory<NetworkInfo>(() => NetworkInfoImpl());

  locator.registerFactory(() => http.Client());
  locator.registerSingletonAsync<SharedPreferences>(() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs;
  });

  await locator.allReady();

  locator.registerFactory<RemoteConfigDataSource>(
    () => RemoteConfigDataSourceImpl(locator(), locator()),
  );
  locator.registerFactory<RemoteConfigRepository>(
    () => RemoteConfigRepositoryImpl(locator()),
  );
  locator.registerFactory(() => PrepareRemoteConfigUseCase(locator()));

  locator.registerFactory(
    () => IconBloc(FlutterAppIconChangerPlugin(iconsSet: SurelineIcons.values)),
  );

  locator.registerFactory(() => ThemeBloc());

  locator.registerFactory(() => CategoryBloc());

  locator.registerFactory<QuoteDataSource>(
    () => QuoteDataSourceImpl(locator()),
  );
  locator.registerFactory<QuoteRepository>(
    () => QuoteRepositoryImpl(locator()),
  );
  locator.registerFactory(() => IsOnboardingCompletedUseCase(locator()));
  locator.registerFactory(() => SetOnboardingToCompletedUseCase(locator()));
  locator.registerFactory(() => IsSwipeCompletedUseCase(locator()));
  locator.registerFactory(() => IsFeedSetupShownUseCase(locator()));
  locator.registerFactory(() => IsLikeGuideShownUseCase(locator()));
  locator.registerFactory(() => IsShareGuideShownUseCase(locator()));
  locator.registerFactory(() => SetSwipeToCompletedUseCase(locator()));
  locator.registerFactory(() => SetFeedSetupToShownUseCase(locator()));
  locator.registerFactory(() => SetLikeGuideToShownUseCase(locator()));
  locator.registerFactory(() => SetShareGuideToShownUseCase(locator()));
  locator.registerFactory(() => GetQuotesUseCase(locator()));
  locator.registerFactory(() => GetQuotesSearchResultsUseCase(locator()));
  locator.registerFactory(() => SaveAllQuotesToAppGroupUseCase(locator()));
  locator.registerFactory(() => GetLikeCountUseCase(locator()));
  locator.registerFactory(() => IncrementLikeCountUseCase(locator()));
  locator.registerFactory(() => DecrementLikeCountUseCase(locator()));
  locator.registerFactory(() => SaveLikedQuoteUseCase(locator()));
  locator.registerFactory(() => RemoveLikedQuoteUseCase(locator()));
  locator.registerFactory(() => GetLikedQuotesUseCase(locator()));

  locator.registerFactory(() => GetOwnQuotesUseCase(locator()));
  locator.registerFactory(() => SaveOwnQuoteUseCase(locator()));
  locator.registerFactory(() => RemoveOwnQuoteUseCase(locator()));

  locator.registerFactory(() => GetLikedQuotesCountUseCase(locator()));
  locator.registerFactory(() => GetRandomQuotesUseCase(locator()));
  locator.registerFactory(
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
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(() => OwnQuotesBloc(locator(), locator(), locator()));

  locator.registerFactory<VoiceDataSource>(() => VoiceDataSourceImpl());
  locator.registerFactory<VoiceRepository>(
    () => VoiceRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetVoicesUseCase(locator()));
  locator.registerFactory(() => GetVoiceUseCase(locator()));
  locator.registerFactory(() => ChangeVoiceUseCase(locator()));
  locator.registerFactory(() => VoiceBloc(locator(), locator(), locator()));

  locator.registerFactory<ShareDataSource>(() => ShareDataSourceImpl());
  locator.registerFactory<ShareRepository>(
    () => ShareRepositoryImpl(locator()),
  );
  locator.registerFactory(() => RenderVideoPostUseCase(locator()));
  locator.registerFactory(() => GetRenderResultsStreamUseCase(locator()));
  locator.registerFactory(() => ShareOnSocialUseCase(locator()));
  locator.registerFactory(() => ShareOnMessageUseCase(locator()));
  locator.registerFactory(() => ShareOnDefaultUseCase(locator()));
  locator.registerFactory(() => SavePostUseCase(locator()));
  locator.registerFactory(() => RenderImagePostUseCase(locator()));
  locator.registerFactory(() => DisposeStreamUseCase(locator()));
  locator.registerFactory(
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
  );

  locator.registerFactory<ThemeDataSource>(
    () => ThemeDataSourceImpl(locator()),
  );
  locator.registerFactory<ThemeSelectorRepository>(
    () => ThemeSelectorRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetThemesUseCase(locator()));
  locator.registerFactory(() => GetThemeMixesUseCase(locator()));
  locator.registerFactory(() => ChangeThemeUseCase(locator()));
  locator.registerFactory(() => SetThemeUseCase(locator()));
  locator.registerFactory(
    () => ThemeSelectorBloc(locator(), locator(), locator()),
  );

  locator.registerFactory<PhotoDataSource>(
    () => PhotoDataSourceImpl(locator()),
  );
  locator.registerFactory<PhotoRepository>(
    () => PhotoRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetPhotosUseCase(locator()));
  locator.registerFactory(() => GetPhotosSearchResultsUseCase(locator()));
  locator.registerFactory(() => PhotoBloc(locator(), locator()));

  locator.registerFactory<CreateThemeDataSource>(
    () => CreateThemeDataSourceImpl(locator()),
  );
  locator.registerFactory<CreateThemeRepository>(
    () => CreateThemeRepositoryImpl(locator()),
  );
  locator.registerFactory(() => DownloadPhotoUseCase(locator()));
  locator.registerFactory(() => CreateThemeBloc(locator(), locator()));

  locator.registerFactory<SoundDataSource>(() => SoundDataSourceImpl());
  locator.registerFactory<SoundRepository>(
    () => SoundRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetVolumeUseCase(locator()));
  locator.registerFactory(() => SetVolumeUseCase(locator()));
  locator.registerFactory(() => SoundBloc(locator(), locator()));

  locator.registerFactory<NotificationSettingsDataSource>(
    () => NotificationSettingsDataSourceImpl(locator(), locator()),
  );
  locator.registerFactory<NotificationSettingRepository>(
    () => NotificationSettingRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetNotificationPresetsUseCase(locator()));
  locator.registerFactory(() => AddNotificationPresetUseCase(locator()));
  locator.registerFactory(() => CancelNotificationPresetCaseCase(locator()));
  locator.registerFactory(() => EnableNotificationPresetCaseCase(locator()));
  locator.registerFactory(() => EditNotificationPresetUseCase(locator()));
  locator.registerFactory(
    () => InitializeNotificationsPresetsUseCase(locator()),
  );
  locator.registerFactory(
    () => ScheduleUpToSixtyNotificationsUseCase(locator()),
  );
  locator.registerFactory(
    () => NotificationSettingBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory<StreakDataSource>(
    () => StreakDataSourceImpl(locator()),
  );
  locator.registerFactory<StreakRepository>(
    () => StreakRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetLastSevenDaysStreakDataUseCase(locator()));
  locator.registerFactory(() => CanLogStreakEntryUseCase());
  locator.registerFactory(() => GetLastCheckInUseCase(locator()));
  locator.registerFactory(() => LogStreakEntryUseCase(locator()));
  locator.registerFactory(() => IsStreakBrokenUseCase(locator()));
  locator.registerFactory(() => ClearStreakDataUseCase(locator()));
  locator.registerFactory(() => GetAllStreakDataUseCase(locator()));
  locator.registerFactory(() => ConvertWidgetToPngUseCase(locator()));
  locator.registerFactory(() => GetTotalStreakScoreUseCase(locator()));

  locator.registerFactory<ContentPrefsDataSource>(
    () => ContentPrefsDataSourceImpl(locator()),
  );
  locator.registerFactory<ContentPrefRepository>(
    () => ContentPrefRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetContentPrefsUseCase(locator()));
  locator.registerFactory(() => UpdateContentPrefsUseCase(locator()));
  locator.registerFactory(() => ContentPrefBloc(locator(), locator()));

  locator.registerFactory<GenderIdentityDataSource>(
    () => GenderIdentityDataSourceImpl(locator()),
  );
  locator.registerFactory<GenderIdentityRepository>(
    () => GenderIdentityRepositoryImpl(locator()),
  );
  locator.registerFactory(() => GetGenderIdentitiesUseCase(locator()));
  locator.registerFactory(() => UpdateGenderIdentitiesUseCase(locator()));
  locator.registerFactory(() => GenderIdentityBloc(locator(), locator()));

  // locator.registerFactory<GenderIdentityDataSource>(() => GenderIdentityDataSourceImpl(locator()));
  // locator.registerFactory<GenderIdentityRepository>(() => GenderIdentityRepositoryImpl(locator()));
  // locator.registerFactory(() => GetGenderIdentitiesUseCase(locator()));
  // locator.registerFactory(() => UpdateGenderIdentitiesUseCase(locator()));
  locator.registerFactory(() => NameBloc(locator()));

  locator.registerFactory(() => OnboardingNameBloc(locator()));

  locator.registerFactory(() => StreakBloc(locator()));

  locator.registerFactory(() => FavouritesBloc(locator(), locator()));

  locator.registerFactory(
    () => SearchBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      // locator(),
    ),
  );

  locator.registerFactory(
    () => PreferencesBloc(
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
      locator(),
    ),
  );
}
