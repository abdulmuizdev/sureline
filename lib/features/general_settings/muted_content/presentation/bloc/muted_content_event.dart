import 'package:sureline/features/general_settings/muted_content/domain/entity/muted_content_entity.dart';

abstract class MutedContentEvent {
  const MutedContentEvent();
}

class GetMutedContentOptions extends MutedContentEvent {
  const GetMutedContentOptions();
}

class OnMutedContentPressed extends MutedContentEvent {
  final List<MutedContentEntity> mutedContent;
  OnMutedContentPressed(this.mutedContent);
}
