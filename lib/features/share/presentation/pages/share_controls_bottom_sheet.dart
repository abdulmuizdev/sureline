import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sureline/common/presentation/widgets/share_item.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/libraries/direct_social_share/direct_social_share_schemas.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/core/utils/utils.dart';
import 'package:sureline/features/preferenecs/collections/presentation/pages/selection/collection_selection_bottom_sheet.dart';
import 'package:sureline/features/share/domain/entity/render_entity.dart';
import 'package:sureline/features/share/domain/entity/share_entity.dart';
import 'package:sureline/features/share/presentation/bloc/share_bloc.dart';
import 'package:sureline/features/share/presentation/bloc/share_event.dart';
import 'package:sureline/features/share/presentation/bloc/share_state.dart';
import 'package:sureline/features/share/presentation/snackbars/disliked_snackbar.dart';
import 'package:sureline/features/share/presentation/snackbars/reported_snackbar.dart';
import 'package:sureline/features/share/presentation/widget/share_control_list_item.dart';
import 'package:sureline/features/share/presentation/widget/tag_dialog.dart';
import 'package:sureline/features/share/presentation/widget/times_widget.dart';

class ShareControlsBottomSheet extends StatefulWidget {
  final int quoteId;
  final String quote;
  final VoidCallback onPop;
  final GlobalKey exportKey;
  final GlobalKey quoteKey;
  final bool isLiveBackground;
  final bool isWaterMarkShowing;
  final VoidCallback onHideWaterMarkPressed;

  const ShareControlsBottomSheet({
    super.key,
    required this.quoteId,
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
  List<DateTime> _accessedTimes = List.generate(10, (index) => DateTime.now());
  List<TimesWidget>? _sortedTimesWidgets; // Cache the sorted widgets

  @override
  void initState() {
    super.initState();
    _isWaterMarkShowing = widget.isWaterMarkShowing;
    _loadLastAccessedTimes();
  }

  Future<void> _loadLastAccessedTimes() async {
    final prefs = await SharedPreferences.getInstance();
    final List<DateTime> loadedTimes = [];

    for (int i = 0; i < 10; i++) {
      final timestamp = prefs.getInt('share_option_${i + 1}_last_accessed');
      if (timestamp != null) {
        loadedTimes.add(DateTime.fromMillisecondsSinceEpoch(timestamp));
      } else {
        // If no timestamp found, use current time minus some offset to prioritize new options
        loadedTimes.add(DateTime.now().subtract(Duration(days: i)));
      }
    }

    setState(() {
      _accessedTimes = loadedTimes;
      _sortedTimesWidgets = null; // Reset cache to rebuild with new times
    });
  }

  Future<void> _updateLastAccessedTime(int optionId) async {
    final prefs = await SharedPreferences.getInstance();
    final currentTime = DateTime.now();

    // Update the timestamp in memory (but don't rebuild the sorted list)
    _accessedTimes[optionId - 1] = currentTime;

    // Save to SharedPreferences
    await prefs.setInt(
      'share_option_${optionId}_last_accessed',
      currentTime.millisecondsSinceEpoch,
    );

    // Don't trigger rebuild - order stays the same for current session
  }

  List<TimesWidget> _buildSortedTimesWidgets(BuildContext context) {
    // Return cached widgets if available
    if (_sortedTimesWidgets != null) {
      return _sortedTimesWidgets!;
    }

    // Create a list of data with ID and timestamp for sorting
    final List<Map<String, dynamic>> timesData = [
      {'id': 1, 'timestamp': _accessedTimes[0]},
      {'id': 2, 'timestamp': _accessedTimes[1]},
      if (widget.isLiveBackground) {'id': 3, 'timestamp': _accessedTimes[2]},
      {'id': 4, 'timestamp': _accessedTimes[3]},
      {'id': 5, 'timestamp': _accessedTimes[4]},
      {'id': 6, 'timestamp': _accessedTimes[5]},
      {'id': 7, 'timestamp': _accessedTimes[6]},
      {'id': 8, 'timestamp': _accessedTimes[7]},
      {'id': 9, 'timestamp': _accessedTimes[8]},
      {'id': 10, 'timestamp': _accessedTimes[9]},
    ];

    // Sort by timestamp in descending order (most recent first)
    timesData.sort((a, b) => b['timestamp'].compareTo(a['timestamp']));

    // Build TimesWidget list from sorted data
    _sortedTimesWidgets =
        timesData.map((data) {
          final int id = data['id'] as int;
          final DateTime timestamp = data['timestamp'] as DateTime;

          switch (id) {
            case 1:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/instagram.png',
                  label: 'Instagram',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = true;
                    });
                    context.read<ShareBloc>().add(
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
              );
            case 2:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/ig_stories.png',
                  label: 'Instagram\nStories',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = true;
                    });
                    context.read<ShareBloc>().add(
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
              );
            case 3:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/ig_reel.png',
                  label: 'Instagram\nReels',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = true;
                    });
                    context.read<ShareBloc>().add(
                      ShareOnSocial(
                        ShareEntity(
                          schema: SocialShareSchema.instagramReel,
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
              );
            case 4:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/facebook.png',
                  label: 'Facebook',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
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
              );
            case 5:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/fb_reel.png',
                  label: 'Facebook\nReels',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
                      ShareOnSocial(
                        ShareEntity(
                          schema: SocialShareSchema.facebookReel,
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
              );
            case 6:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/fb_stories.png',
                  label: 'Facebook\nStories',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
                      ShareOnSocial(
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
              );
            case 7:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/tiktok.png',
                  label: 'TikTok',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
                      OpenTikTok(
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
              );
            case 8:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/whatsapp.png',
                  label: 'WhatsApp',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
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
              );
            case 9:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  imageAsset: 'assets/images/messages.png',
                  label: 'Messages',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
                      OpenMessages(
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
              );
            case 10:
              return TimesWidget(
                id: id,
                lastAccessedAt: timestamp,
                child: ShareItem(
                  icon: Icons.ios_share,
                  label: 'Share to...',
                  onPressed: () async {
                    await _updateLastAccessedTime(id);
                    setState(() {
                      _isInstagramShare = false;
                    });
                    context.read<ShareBloc>().add(
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
              );
            default:
              throw Exception('Unknown ID: $id');
          }
        }).toList();

    return _sortedTimesWidgets!;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => locator<ShareBloc>(),
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
            } else {
              state.proceed();
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
                              children: _buildSortedTimesWidgets(context),
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
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context:
                                          Navigator.of(
                                            context,
                                            rootNavigator: true,
                                          ).context,
                                      builder:
                                          (ctx) =>
                                              CollectionSelectionBottomSheet(
                                                quoteId: widget.quoteId,

                                                onHistoryUpdated: (
                                                  _,
                                                  collectionsOfHistory,
                                                ) {
                                                  Navigator.of(ctx).pop();
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                      isScrollControlled: true,
                                      useSafeArea: true,
                                    );
                                  },
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
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Utils.showCustomSnackBar(
                                      context,
                                      DislikedSnackbar(),
                                    );
                                  },
                                ),
                                ShareControlListItem(
                                  icon: Icons.flag_outlined,
                                  label: 'Report',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Utils.showCustomSnackBar(
                                      context,
                                      ReportedSnackbar(),
                                    );
                                  },
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
