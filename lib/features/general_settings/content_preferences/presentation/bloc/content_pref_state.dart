import 'package:sureline/features/general_settings/content_preferences/domain/entity/content_pref_entity.dart';

abstract class ContentPrefState {
  const ContentPrefState();
}

class Initial extends ContentPrefState {
  const Initial();
}

class GettingContentPrefOptions extends ContentPrefState {
  const GettingContentPrefOptions();
}

class GotContentPrefOptions extends ContentPrefState {
  final List<ContentPrefEntity> result;
  const GotContentPrefOptions(this.result);
}

class ContentPrefError extends ContentPrefState {
  final String message;
  const ContentPrefError(this.message);
}