import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:sureline/common/presentation/widgets/share_item.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/presentation/bloc/share_bloc.dart';
import 'package:sureline/features/share/presentation/bloc/share_event.dart';
import 'package:sureline/features/share/presentation/bloc/share_state.dart';
import 'package:sureline/features/share/presentation/widget/share_control_list_item.dart';
import 'package:sureline/features/share/presentation/widget/tag_dialog.dart';

class ShareControlsBottomSheet extends StatefulWidget {
  final String quote;
  final VoidCallback onPop;
  final GlobalKey exportKey;
  final GlobalKey quoteKey;
  final bool isLiveBackground;
  final bool isWaterMarkShowing;
  final VoidCallback onHideWaterMarkPressed;

  const ShareControlsBottomSheet({
    super.key,
    required this.quote,
    required this.onPop,
    required this.exportKey,
    required this.quoteKey,
    required this.isLiveBackground,
    required this.onHideWaterMarkPressed,
    required this.isWaterMarkShowing,
  });

  @override
  State<ShareControlsBottomSheet> createState() =>
      _ShareControlsBottomSheetState();
}

class _ShareControlsBottomSheetState extends State<ShareControlsBottomSheet> {
  String _renderProgress = '0';
  late bool _isWaterMarkShowing;
  bool _isInstagramShare = false;

  @override
  void initState() {
    super.initState();
    _isWaterMarkShowing = widget.isWaterMarkShowing;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => locator<ShareBloc>())],
      child: BlocListener<ShareBloc, ShareState>(
        listener: (context, state) async {
          if (state is Rendering) {
            if (state.progress != null) {
              _renderProgress =
                  '${(state.progress! * 100).toStringAsFixed(0)}%';
            }
          }
          if (state is Rendered) {
            if (_isInstagramShare) {
              await showGeneralDialog(
                context: context,
                barrierDismissible: true,
                barrierLabel: '',
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder:
                    (context, animation, secondaryAnimation) => Center(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: CupertinoActionSheet(
                          actions: [
                            CupertinoActionSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                                state.proceed();
                              },
                              child: TagDialog(
                                onDonePressed: () {
                                  Navigator.of(context).pop();
                                  state.proceed();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                transitionBuilder: Utils.dialogTransitionBuilder,
              );
            }
          }
        },
        child: BlocBuilder<ShareBloc, ShareState>(
          builder: (context, state) {
            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFAFA9A4).withValues(alpha: 0),
                          Color(0xFFAFA9A4),
                          Color(0xFFAFA9A4),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () {
                                widget.onPop();
                                Navigator.of(context).pop();
                              },
                              icon: Icon(
                                Icons.cancel_rounded,
                                color: AppColors.pureWhite,
                                size: 28,
                              ),
                            ),
                          ),
                          SizedBox(height: 27),
                          SizedBox(
                            height: 90,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ShareItem(
                                  imageAsset: 'assets/images/instagram.png',
                                  label: 'Instagram',
                                  onPressed: () {
                                    setState(() {
                                      _isInstagramShare = true;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenInstagram(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.instagramStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/ig_stories.png',
                                  label: 'Instagram\nStories',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = true;
                                    });
                                    context.read<ShareBloc>().add(
                                      ShareOnSocial(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.instagramStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                if (true) ...[
                                  ShareItem(
                                    imageAsset: 'assets/images/ig_reel.png',
                                    label: 'Instagram\nReels',
                                    onPressed: () async {
                                      setState(() {
                                        _isInstagramShare = true;
                                      });
                                      context.read<ShareBloc>().add(
                                        ShareOnSocial(
                                          ShareEntity(
                                            schema:
                                                SocialShareSchema.instagramReel,
                                            renderEntity: RenderEntity(
                                              quote: widget.quote,
                                              isLiveBackground:
                                                  widget.isLiveBackground,
                                              quoteKey: widget.quoteKey,
                                              rootKey: widget.exportKey,
                                              path:
                                                  App
                                                      .themeEntity
                                                      .backgroundEntity
                                                      .path ??
                                                  '',
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                                ShareItem(
                                  imageAsset: 'assets/images/facebook.png',
                                  label: 'Facebook',
                                  onPressed: () {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenFacebook(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.instagramStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/fb_reel.png',
                                  label: 'Facebook\nReels',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      ShareOnSocial(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookReel,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/fb_stories.png',
                                  label: 'Facebook\nStories',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      ShareOnSocial(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/tiktok.png',
                                  label: 'TikTok',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenTikTok(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.instagramStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/whatsapp.png',
                                  label: 'WhatsApp',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenDefaultShare(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  imageAsset: 'assets/images/messages.png',
                                  label: 'Messages',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenMessages(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareItem(
                                  icon: Icons.ios_share,
                                  label: 'Share to...',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      OpenDefaultShare(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 27),
                          SizedBox(
                            height: 90,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                ShareControlListItem(
                                  icon: Icons.save_alt_rounded,
                                  label:
                                      (widget.isLiveBackground)
                                          ? 'Save Video'
                                          : 'Save Image',
                                  onPressed: () async {
                                    setState(() {
                                      _isInstagramShare = false;
                                    });
                                    context.read<ShareBloc>().add(
                                      SavePost(
                                        ShareEntity(
                                          schema:
                                              SocialShareSchema.facebookStory,
                                          renderEntity: RenderEntity(
                                            quote: widget.quote,
                                            isLiveBackground:
                                                widget.isLiveBackground,
                                            quoteKey: widget.quoteKey,
                                            rootKey: widget.exportKey,
                                            path:
                                                App
                                                    .themeEntity
                                                    .backgroundEntity
                                                    .path ??
                                                '',
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                ShareControlListItem(
                                  icon: Icons.copy_rounded,
                                  label: 'Copy text',
                                  onPressed: () {
                                    Clipboard.setData(
                                      ClipboardData(text: widget.quote),
                                    );
                                  },
                                ),
                                ShareControlListItem(
                                  icon: Icons.bookmark_border_outlined,
                                  label: 'Add to collection',
                                ),
                                ShareControlListItem(
                                  icon: Icons.volume_up_outlined,
                                  label: 'Read aloud',
                                  onPressed: () {
                                    final tts = FlutterTts();
                                    tts.setVolume(App.volume);
                                    if (App.voice != null) {
                                      tts.setVoice(App.voice!);
                                    }
                                    tts.speak(widget.quote);
                                  },
                                ),
                                ShareControlListItem(
                                  icon: Icons.water_drop_outlined,
                                  label:
                                      (_isWaterMarkShowing)
                                          ? 'Hide watermark'
                                          : 'Show watermark',
                                  onPressed: () {
                                    setState(() {
                                      _isWaterMarkShowing =
                                          !_isWaterMarkShowing;
                                    });
                                    widget.onHideWaterMarkPressed();
                                  },
                                ),
                                ShareControlListItem(
                                  icon: Icons.thumb_down_off_alt_rounded,
                                  label: 'Dislike',
                                ),
                                ShareControlListItem(
                                  icon: Icons.flag_outlined,
                                  label: 'Report',
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 27),
                        ],
                      ),
                    ),
                  ),
                ),

                if (state is Rendering) ...[
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 23,
                          vertical: 17,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CupertinoActivityIndicator(radius: 20),
                            if (state.progress != null) ...[
                              SizedBox(height: 18),
                              Text(_renderProgress),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
