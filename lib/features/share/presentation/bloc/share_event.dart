import 'package:flutter/cupertino.dart';
import 'package:sureline/features/share/domain/entity/render_result_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';

abstract class ShareEvent {
  const ShareEvent();
}

class OpenInstagram extends ShareEvent {
  final ShareEntity entity;
  const OpenInstagram(this.entity);
}

class OpenFacebook extends ShareEvent {
  final ShareEntity entity;
  const OpenFacebook(this.entity);
}

class OpenTikTok extends ShareEvent {
  final ShareEntity entity;
  const OpenTikTok(this.entity);
}

class ShareOnSocial extends ShareEvent {
  final ShareEntity entity;
  const ShareOnSocial(this.entity);
}

class OpenMessages extends ShareEvent {
  final ShareEntity entity;
  const OpenMessages(this.entity);
}

class OpenDefaultShare extends ShareEvent {
  final ShareEntity entity;
  const OpenDefaultShare(this.entity);
}

class SavePost extends ShareEvent {
  final ShareEntity entity;
  const SavePost(this.entity);
}

class RenderResultReceived extends ShareEvent {
  final RenderResultEntity result;
  const RenderResultReceived(this.result);
}

class RenderCompleted extends ShareEvent {
  final VoidCallback proceed;
  const RenderCompleted({required this.proceed});
}

class RenderingInProgress extends ShareEvent {
  const RenderingInProgress();
}
