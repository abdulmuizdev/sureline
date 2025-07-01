import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';

abstract class MutedContentState {
  const MutedContentState();
}

class Initial extends MutedContentState {
  const Initial();
}

class GettingMutedContentOptions extends MutedContentState {
  const GettingMutedContentOptions();
}

class GotMutedContentOptions extends MutedContentState {
  final MutedContentEntity result;
  const GotMutedContentOptions(this.result);
}

class MutedContentError extends MutedContentState {
  final String message;
  const MutedContentError(this.message);
}
