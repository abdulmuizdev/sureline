import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/common/presentation/widgets/watermark.dart';

class HomeListItem extends StatefulWidget {
  final String quote;
  final bool isWelcome;
  final bool? showSwipeUp;
  final bool? showSwipeGuide;
  final bool isLiked;
  final Function(bool) onLikePressed;
  final VoidCallback onTap;
  final VoidCallback onSharePressed;
  final bool showExtras;
  final bool showWaterMark;
  final GlobalKey quoteKey;

  const HomeListItem({
    super.key,
    required this.isWelcome,
    required this.quote,
    this.showSwipeUp,
    this.showSwipeGuide,
    required this.isLiked,
    required this.onLikePressed,
    required this.onTap,
    required this.onSharePressed,
    required this.showExtras,
    required this.showWaterMark,
    required this.quoteKey,
  });

  @override
  State<HomeListItem> createState() => _HomeListItemState();
}

class _HomeListItemState extends State<HomeListItem>
    with TickerProviderStateMixin {
  late AnimationController _welcomeSwipeSlideController;
  late AnimationController _swipeSlideController;
  late AnimationController _swipeFadeController;
  late AnimationController _likeController;

  late Animation<Offset> _welcomeSwipeSlideAnimation;
  late Animation<Offset> _swipeSlideTransition;
  late Animation<double> _swipeFadeAnimation;
  late Animation<double> _likeScaleAnimation;
  late Animation<double> _likeFadeAnimation;

  bool _showLike = false;
  Size _quoteWidgetSize = Size.zero;
  final GlobalKey textKey = GlobalKey();

  // Add flag to control animation loop
  bool _isAnimationRunning = false;

  double _waterMarkHeight = 25;

  @override
  Widget build(BuildContext context) {
    final isWelcome = widget.isWelcome;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: widget.onTap,
            onDoubleTap: _triggerLike,
            behavior: HitTestBehavior.translucent,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 26),
              Expanded(
                child: SlideTransition(
                  position: _swipeSlideTransition,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        Expanded(
                          flex: 8,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              GestureDetector(
                                onTap: widget.onTap,
                                onDoubleTap: _triggerLike,
                                child: RepaintBoundary(
                                  key: widget.quoteKey,
                                  child: LayoutBuilder(
                                    builder: (context, constraints) {
                                      return Stack(
                                        children: [
                                          Center(child: quoteText(isWelcome)),
                                          AnimatedOpacity(
                                            opacity:
                                                widget.showExtras
                                                    ? 0
                                                    : (widget.showWaterMark
                                                        ? 1
                                                        : 0),
                                            duration: Duration(
                                              milliseconds: 1000,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                    top:
                                                        ((constraints
                                                                    .maxHeight /
                                                                2) -
                                                            (_waterMarkHeight /
                                                                2)) +
                                                        (_quoteWidgetSize
                                                                .height /
                                                            2) +
                                                        43,
                                                  ),
                                                  child: Watermark(
                                                    height: _waterMarkHeight,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                              FadeTransition(
                                opacity: _likeFadeAnimation,
                                child: ScaleTransition(
                                  scale: _likeScaleAnimation,
                                  child:
                                      (_showLike)
                                          ? Icon(
                                            Icons.favorite,
                                            color:
                                                App
                                                    .themeEntity
                                                    .textDecorEntity
                                                    .textColor,
                                            size: 140,
                                          )
                                          : Container(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        if (!isWelcome) ...[
                          Expanded(
                            flex: 1,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 1000),
                              opacity: (widget.showExtras) ? 1 : 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      widget.onSharePressed();
                                    },
                                    icon: Icon(
                                      Icons.ios_share_rounded,
                                      color:
                                          App
                                              .themeEntity
                                              .textDecorEntity
                                              .textColor,
                                      size: 27,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _triggerLike();
                                    },
                                    icon: Icon(
                                      (widget.isLiked)
                                          ? Icons.favorite
                                          : Icons.favorite_outline_rounded,
                                      color:
                                          App
                                              .themeEntity
                                              .textDecorEntity
                                              .textColor,
                                      size: 27,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                SlideTransition(
                                  position: _welcomeSwipeSlideAnimation,
                                  child: Image.asset(
                                    'assets/images/swipe.png',
                                    color:
                                        App
                                            .themeEntity
                                            .textDecorEntity
                                            .textColor,
                                    width: 29,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                Text(
                                  'Swipe up',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                    color:
                                        App
                                            .themeEntity
                                            .textDecorEntity
                                            .textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 26,
                child: FadeTransition(
                  opacity: _swipeFadeAnimation,
                  child: Column(
                    children: [
                      Text(
                        'Swipe up',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: App.themeEntity.textDecorEntity.textColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget quoteText(bool isWelcome) {
    return Text(
      key: textKey,
      isWelcome ? 'Welcome to Sureline' : widget.quote,
      textAlign: TextAlign.center,
      style: GoogleFonts.getFont(
        App.themeEntity.textDecorEntity.fontFamily,
        textStyle: TextStyle(
          foreground:
              (App.themeEntity.textDecorEntity.outlineState == 0)
                    ? null
                    : Paint()
                ?..style = PaintingStyle.stroke
                ..strokeWidth = double.parse(
                  App.themeEntity.textDecorEntity.outlineState.toString(),
                )
                ..color = App.themeEntity.textDecorEntity.textColor,
          color:
              (App.themeEntity.textDecorEntity.outlineState == 0)
                  ? App.themeEntity.textDecorEntity.textColor
                  : null,

          fontSize: App.themeEntity.textDecorEntity.fontSize,
          fontWeight: App.themeEntity.textDecorEntity.fontWeight,
        ),
      ),
    );
  }

  void _triggerLike() {
    widget.onLikePressed(!widget.isLiked);
    if (!widget.isLiked) {
      setState(() {
        _showLike = true;
      });
      _likeController.forward(from: 0);
    }
  }

  @override
  void initState() {
    super.initState();

    _welcomeSwipeSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);

    _welcomeSwipeSlideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -2),
    ).animate(
      CurvedAnimation(
        parent: _welcomeSwipeSlideController,
        curve: Curves.linearToEaseOut,
      ),
    );

    _swipeSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _swipeSlideTransition = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, -0.05),
    ).animate(
      CurvedAnimation(parent: _swipeSlideController, curve: Curves.linear),
    );

    _swipeFadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _swipeFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _swipeFadeController, curve: Curves.linear),
    );

    _likeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _likeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.4,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.4,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 20),
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 1.3,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
    ]).animate(_likeController);

    _likeFadeAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 80),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 20),
    ]).animate(_likeController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _quoteWidgetSize =
            (textKey.currentContext != null)
                ? (textKey.currentContext!.size != null
                    ? textKey.currentContext!.size!
                    : Size.zero)
                : Size.zero;
      });
      _likeController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _showLike = false;
          });
          _likeController.reset();
        }
      });
    });

    if (widget.showSwipeGuide ?? false) {
      _startSwipeGuideAnimationLoop();
    }
  }

  void _startSwipeGuideAnimationLoop() {
    if (widget.showSwipeUp ?? false) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          _swipeFadeController.forward();
        }
      });
    }

    if (!widget.isWelcome) {
      Future.delayed(const Duration(seconds: 3), () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _startCustomSwipeAnimation();
        });
      });
    }
  }

  void _startCustomSwipeAnimation() async {
    _isAnimationRunning = true;

    while (_isAnimationRunning && mounted) {
      try {
        await _swipeSlideController.forward();
        if (!_isAnimationRunning || !mounted) break;

        await _swipeSlideController.reverse();
        if (!_isAnimationRunning || !mounted) break;

        await Future.delayed(Duration(seconds: 1));
      } catch (e) {
        // Controller might be disposed, break the loop
        break;
      }
    }
  }

  @override
  void dispose() {
    _isAnimationRunning = false;
    _welcomeSwipeSlideController.dispose();
    _swipeSlideController.dispose();
    _swipeFadeController.dispose();
    _likeController.dispose();

    super.dispose();
  }
}
