import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';

abstract class ContentPrefEvent {
  const ContentPrefEvent();
}

class GetContentPrefOptions extends ContentPrefEvent {
  const GetContentPrefOptions();
}

class OnContentPrefPressed extends ContentPrefEvent {
  final List<ContentPrefEntity> contentPrefs;
  OnContentPrefPressed(this.contentPrefs);
}