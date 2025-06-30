import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sureline/common/domain/entities/create_theme_entity.dart';
import 'package:sureline/common/presentation/widgets/background.dart';
import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/core/di/injection.dart';
import 'package:sureline/core/theme/app_colors.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/data/model/create_and_edit_theme_model.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_bloc.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_event.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bloc/create_and_edit_theme_state.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/bottom_sheets/confirmation_bottom_sheet/confirmation_bottom_sheet.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/back_button.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/background_actions_bar.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/bg_text_switcher.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/color_selector.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/done_button_widget.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/font_family_selector.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/gradient_widget.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/text_action_bar/text_actions_bar.dart';
import 'package:sureline/features/create_and_edit_theme_bottom_sheet/presentation/widgets/text_size_slider.dart';
import 'package:sureline/features/home/presentation/pages/home_screen.dart';
import 'package:sureline/features/unsplash_screen/domain/entity/photo_entity.dart';
import 'package:sureline/features/unsplash_screen/presentation/pages/unsplash_screen.dart';

class CreateAndEditThemeBottomSheet extends StatefulWidget {
  final ThemeEntity entity;

  const CreateAndEditThemeBottomSheet({super.key, required this.entity});

  @override
  State<CreateAndEditThemeBottomSheet> createState() =>
      _CreateAndEditThemeBottomSheetState();
}

class _CreateAndEditThemeBottomSheetState
    extends State<CreateAndEditThemeBottomSheet> {
  final Duration _animationDuration = Duration(milliseconds: 550);
  int _selectedIndex = 0;
  double _sliderValue = 0.5;

  late double _textPadding;
  late TextStyle _finalTextStyle;
  late CrossAxisAlignment _iconAlignment;
  late String? _backgroundAsset;
  late bool _isNetworkImage;
  late bool _isLiveBackground;
  late bool _isImageLocallyStored;
  late TextAlign _textAlignment;
  late Color? _backgroundColor;
  String? _previewUrl;
  late Color _textColor;
  late String _fontFamily;
  late int _outlineState;

  bool _showBackgroundColorPicker = false;
  bool _showTextColorPicker = false;
  bool _showFontFamilySelector = false;
  bool _showBackgroundActions = true;
  bool _showTextActions = false;

  bool _isChanged = false;

  CreateThemeBloc bloc = locator<CreateThemeBloc>();

  @override
  void initState() {
    final bg = widget.entity.backgroundEntity;
    final textDecor = widget.entity.textDecorEntity;

    _backgroundAsset = bg.path;
    _textAlignment = textDecor.textAlign;
    _textColor = textDecor.textColor;
    _fontFamily = textDecor.fontFamily;
    _backgroundColor = bg.solidColor;
    _isNetworkImage = bg.isNetwork;
    _isLiveBackground = bg.isLiveBackground;
    _isImageLocallyStored = bg.isLocallyStored;
    _outlineState = textDecor.outlineState;
    _textPadding = textDecor.textPadding;

    _initializeBloc(textDecor);

    _finalTextStyle = bloc.getTextStyle();
    _iconAlignment = bloc.getIconAlignment();
    super.initState();
  }

  void _initializeBloc(ThemeTextDecorEntity textDecor) {
    bloc.initialize(
      fontFamily: textDecor.fontFamily,
      fontSize: textDecor.fontSize,
      fontWeight: textDecor.fontWeight,
      textColor: textDecor.textColor,
      outlineState: textDecor.outlineState,
      textAlign: textDecor.textAlign,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => bloc..add(GetTextStyle()))],
      child: BlocListener<CreateThemeBloc, CreateThemeState>(
        listener: (context, state) {
          if (state is GotTextPadding) {
            _textPadding = state.padding;
            _isChanged = _checkDifference();
          }
          if (state is UpdateTextAlignment) {
            _textAlignment = state.textAlign;
            _iconAlignment = state.iconAlignment;
            _isChanged = _checkDifference();
          }
          if (state is UpdateTextStyle) {
            _finalTextStyle = state.textStyle;
            _textColor = state.textColor;
            _fontFamily = state.fontFamily;
            _isChanged = _checkDifference();
            _outlineState = state.outlineState;
          }
          if (state is UpdateSliderValue) {
            _sliderValue = state.value;
            _isChanged = _checkDifference();
          }
          if (state is UpdateBackground) {
            debugPrint('background is updated');

            _backgroundAsset = state.path ?? Constants.defaultBackground;
            _isNetworkImage = state.isNetwork ?? false;
            _isImageLocallyStored = state.isImageLocallyStored ?? false;
            _backgroundColor = state.color;
            _previewUrl = state.previewUrl;

            _isChanged = _checkDifference();
          }
          if (state is ThemeChanged) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(isThemeChanged: true),
              ),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: BlocBuilder<CreateThemeBloc, CreateThemeState>(
          builder: (context, state) {
            debugPrint('rebuilding $_isImageLocallyStored');
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Background(
                      entity: ThemeBackgroundEntity(
                        isLiveBackground: _isLiveBackground,
                        isNetwork: _isNetworkImage,
                        isLocallyStored: _isImageLocallyStored,
                        path: _backgroundAsset,
                        solidColor: _backgroundColor,
                      ),
                    ),
                  ),
                  GradientWidget(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: GradientWidget(reverse: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 40,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButtonWidget(isChanged: _isChanged),
                        DoneButtonWidget(
                          isChanged: _isChanged,
                          animationDuration: _animationDuration,
                          onPressed: () {
                            context.read<CreateThemeBloc>().add(
                              OnDonePressed(
                                entity: ThemeEntity(
                                  lastAccessed: DateTime.now(),
                                  textDecorEntity: ThemeTextDecorEntity(
                                    fontSize: _finalTextStyle.fontSize!,
                                    fontWeight: _finalTextStyle.fontWeight!,
                                    fontFamily: _fontFamily,
                                    textAlign: _textAlignment,
                                    textColor: _textColor,
                                    outlineState: _outlineState,
                                    textPadding: _textPadding,
                                  ),
                                  backgroundEntity: ThemeBackgroundEntity(
                                    path: _backgroundAsset,
                                    isNetwork: _isNetworkImage,
                                    solidColor: _backgroundColor,
                                    isLiveBackground:
                                        widget
                                            .entity
                                            .backgroundEntity
                                            .isLiveBackground,
                                    isLocallyStored: _isImageLocallyStored,
                                    previewImage: _previewUrl,
                                  ),
                                  previewQuote: widget.entity.previewQuote,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.all(_textPadding),
                      child: Text(
                        widget.entity.previewQuote!,
                        textAlign: _textAlignment,
                        style: _finalTextStyle,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: TextSizeSlider(
                        value: _sliderValue,
                        onSliderValueChange: (value) {
                          context.read<CreateThemeBloc>().add(
                            OnSliderValueChanged(value),
                          );
                        },
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 24),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                IgnorePointer(
                                  ignoring: !_showBackgroundActions,
                                  child: AnimatedOpacity(
                                    opacity: (_showBackgroundActions) ? 1 : 0,
                                    duration: _animationDuration,
                                    child: BackgroundActionsBar(
                                      onCameraPressed: () {
                                        context.read<CreateThemeBloc>().add(
                                          OnCameraIconPressed(),
                                        );
                                      },
                                      onUnsplashPressed: () async {
                                        final PhotoEntity? selectedPhoto =
                                            await Navigator.of(
                                              context,
                                            ).push<PhotoEntity?>(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        UnsplashScreen(),
                                              ),
                                            );
                                        if (!context.mounted) return;
                                        if (selectedPhoto?.url != null) {
                                          debugPrint(
                                            'unsplash photo selected with preview',
                                          );
                                          debugPrint(selectedPhoto?.previewUrl);
                                          context.read<CreateThemeBloc>().add(
                                            OnUnsplashPhotoSelected(
                                              path: selectedPhoto!.url,
                                              previewPath:
                                                  selectedPhoto.previewUrl,
                                            ),
                                          );
                                        }
                                      },
                                      onSwatchPressed: () {
                                        setState(() {
                                          _showTextActions = false;
                                          _showBackgroundActions = false;
                                          _showFontFamilySelector = false;
                                          _showBackgroundColorPicker = true;
                                          _showTextColorPicker = false;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                IgnorePointer(
                                  ignoring: !_showTextActions,
                                  child: AnimatedOpacity(
                                    opacity: _showTextActions ? 1 : 0,
                                    duration: _animationDuration,
                                    child: TextActionsBar(
                                      onFontFamilyPressed: () {
                                        setState(() {
                                          _showTextActions = false;
                                          _showBackgroundActions = false;
                                          _showFontFamilySelector = true;
                                          _showBackgroundColorPicker = false;
                                          _showTextColorPicker = false;
                                        });
                                      },
                                      onAlignmentPressed: () {
                                        context.read<CreateThemeBloc>().add(
                                          OnTextAlignmentChange(_iconAlignment),
                                        );
                                      },
                                      onSwatchPressed: () {
                                        setState(() {
                                          _showTextActions = false;
                                          _showBackgroundActions = false;
                                          _showFontFamilySelector = false;
                                          _showBackgroundColorPicker = false;
                                          _showTextColorPicker = true;
                                        });
                                      },
                                      onOutlineTextPressed: (stateVal) {
                                        context.read<CreateThemeBloc>().add(
                                          OnOutlineStateChange(stateVal),
                                        );
                                      },
                                      outlineState: _outlineState,
                                      alignment: _iconAlignment,
                                    ),
                                  ),
                                ),

                                // Background
                                IgnorePointer(
                                  ignoring:
                                      !(_showBackgroundColorPicker &&
                                          _selectedIndex == 0),
                                  child: AnimatedOpacity(
                                    opacity:
                                        (_showBackgroundColorPicker &&
                                                _selectedIndex == 0)
                                            ? 1
                                            : 0,
                                    duration: _animationDuration,
                                    child: ColorSelector(
                                      onBackPressed: () {
                                        setState(() {
                                          _showTextActions = false;
                                          _showBackgroundActions = true;
                                          _showFontFamilySelector = false;
                                          _showBackgroundColorPicker = false;
                                          _showTextColorPicker = false;
                                        });
                                      },
                                      initialColor: _backgroundColor,
                                      onColorSelected: (color) {
                                        context.read<CreateThemeBloc>().add(
                                          OnBackgroundColorSelected(color),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Text
                                IgnorePointer(
                                  ignoring:
                                      !(_selectedIndex == 1 &&
                                          _showTextColorPicker),
                                  child: AnimatedOpacity(
                                    opacity:
                                        (_selectedIndex == 1 &&
                                                _showTextColorPicker)
                                            ? 1
                                            : 0,
                                    duration: _animationDuration,
                                    child: ColorSelector(
                                      onBackPressed: () {
                                        setState(() {
                                          _showTextActions = true;
                                          _showBackgroundActions = false;
                                          _showFontFamilySelector = false;
                                          _showBackgroundColorPicker = false;
                                          _showTextColorPicker = false;
                                        });
                                      },
                                      initialColor: _textColor,
                                      onColorSelected: (color) {
                                        context.read<CreateThemeBloc>().add(
                                          OnTextColorSelected(color),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                // Font Family
                                IgnorePointer(
                                  ignoring: !_showFontFamilySelector,
                                  child: AnimatedOpacity(
                                    opacity: _showFontFamilySelector ? 1 : 0,
                                    duration: _animationDuration,
                                    child: FontFamilySelector(
                                      onBackPressed: () {
                                        setState(() {
                                          _showTextActions = true;
                                          _showBackgroundActions = false;
                                          _showFontFamilySelector = false;
                                          _showBackgroundColorPicker = false;
                                          _showTextColorPicker = false;
                                        });
                                      },
                                      onFontFamilySelected: (fontFamily) {
                                        context.read<CreateThemeBloc>().add(
                                          OnFontFamilySelected(fontFamily),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 24),
                            child: BgTextSwitcher(
                              onSelectionChanged: (index) {
                                setState(() {
                                  _selectedIndex = index;
                                  if (index == 0) {
                                    _showTextActions = false;
                                    _showBackgroundActions = true;
                                    _showFontFamilySelector = false;
                                    _showBackgroundColorPicker = false;
                                    _showTextColorPicker = false;
                                  } else {
                                    _showTextActions = true;
                                    _showBackgroundActions = false;
                                    _showFontFamilySelector = false;
                                    _showBackgroundColorPicker = false;
                                    _showTextColorPicker = false;
                                  }
                                });
                              },
                              selectedIndex: _selectedIndex,
                            ),
                          ),
                          SizedBox(height: 15),
                          SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  bool _checkDifference() {
    {
      final newEntity = ThemeEntity(
        lastAccessed: DateTime.now(),
        textDecorEntity: ThemeTextDecorEntity(
          fontSize: _finalTextStyle.fontSize!,
          fontWeight: _finalTextStyle.fontWeight!,
          fontFamily: _fontFamily,
          textAlign: _textAlignment,
          textColor: _textColor,
          outlineState: _outlineState,
          textPadding: _textPadding,
        ),
        backgroundEntity: ThemeBackgroundEntity(
          path: _backgroundAsset,
          previewImage: _previewUrl,
          isNetwork: _isNetworkImage,
          solidColor: _backgroundColor,
          isLiveBackground: _isLiveBackground,
          isLocallyStored: _isImageLocallyStored,
        ),
        previewQuote: widget.entity.previewQuote,
      );

      if (newEntity == widget.entity) {
        return false;
      } else {
        // printPropsDiff(newEntity, widget.entity);
        return true;
      }
    }
  }

  void printPropsDiff(Equatable a, Equatable b) {
    final aProps = a.props;
    final bProps = b.props;
    for (var i = 0; i < aProps.length; i++) {
      if (aProps[i] != bProps[i]) {
        debugPrint('Prop #$i differs: ${aProps[i]} vs ${bProps[i]}');
      }
    }
  }
}
