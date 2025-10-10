import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/share_item.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/presentation/bloc/share_bloc.dart';
import 'package:sureline/features/share/presentation/bloc/share_event.dart';
import 'package:sureline/features/share/presentation/bloc/share_state.dart';
import 'package:sureline/features/share/presentation/widget/tag_dialog.dart';

class ThemeChangedSnackBar extends StatefulWidget {
  final String quote;
  final GlobalKey exportKey;
  final GlobalKey quoteKey;
  final bool isLiveBackground;
  final ShareBloc shareBloc;
  final Function(bool isInstagram) onShareItemPressed;

  const ThemeChangedSnackBar({
    super.key,
    required this.quote,
    required this.exportKey,
    required this.quoteKey,
    required this.isLiveBackground,
    required this.onShareItemPressed,
    required this.shareBloc,
  });

  @override
  State<ThemeChangedSnackBar> createState() => _ThemeChangedSnackBarState();
}

class _ThemeChangedSnackBarState extends State<ThemeChangedSnackBar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShareBloc, ShareState>(
      bloc: widget.shareBloc,
      builder: (context, state) {
        return Container(
          height: 135,
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              const Text(
                'Theme changed! Want to share this quote?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.primaryColor,
                  decoration: TextDecoration.none,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShareItem(
                      imageAsset: 'assets/images/instagram.png',
                      label: 'Instagram',
                      onPressed: () {
                        widget.onShareItemPressed(true);

                        widget.shareBloc.add(
                          OpenInstagram(
                            ShareEntity(
                              schema: SocialShareSchema.instagramStory,
                              renderEntity: RenderEntity(
                                quote: widget.quote,
                                isLiveBackground: widget.isLiveBackground,
                                quoteKey: widget.quoteKey,
                                rootKey: widget.exportKey,
                                path: App.themeEntity.backgroundEntity.path ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ShareItem(
                      imageAsset: 'assets/images/instagram.png',
                      label: 'Instagram\nStories',
                      onPressed: () {
                        widget.onShareItemPressed(true);
                        widget.shareBloc.add(
                          ShareOnSocial(
                            ShareEntity(
                              schema: SocialShareSchema.instagramStory,
                              renderEntity: RenderEntity(
                                quote: widget.quote,
                                isLiveBackground: widget.isLiveBackground,
                                quoteKey: widget.quoteKey,
                                rootKey: widget.exportKey,
                                path: App.themeEntity.backgroundEntity.path ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ShareItem(
                      imageAsset: 'assets/images/facebook.png',
                      label: 'Facebook',
                      onPressed: () {
                        widget.onShareItemPressed(false);
                        widget.shareBloc.add(
                          OpenFacebook(
                            ShareEntity(
                              schema: SocialShareSchema.instagramStory,
                              renderEntity: RenderEntity(
                                quote: widget.quote,
                                isLiveBackground: widget.isLiveBackground,
                                quoteKey: widget.quoteKey,
                                rootKey: widget.exportKey,
                                path: App.themeEntity.backgroundEntity.path ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ShareItem(
                      imageAsset: 'assets/images/share_via.png',
                      label: 'Share to...',
                      onPressed: () {
                        widget.onShareItemPressed(false);
                        widget.shareBloc.add(
                          OpenDefaultShare(
                            ShareEntity(
                              schema: SocialShareSchema.facebookStory,
                              renderEntity: RenderEntity(
                                quote: widget.quote,
                                isLiveBackground: widget.isLiveBackground,
                                quoteKey: widget.quoteKey,
                                rootKey: widget.exportKey,
                                path: App.themeEntity.backgroundEntity.path ?? '',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
