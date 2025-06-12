import 'package:flutter/material.dart';
import 'package:sureline/core/theme/app_colors.dart';

class SurelineTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final bool? disableCenterAlignment;
  final bool? isTextArea;
  final bool? showCharLimit;
  final bool? isNameInput;

  const SurelineTextField({
    super.key,
    required this.controller,
    this.disableCenterAlignment,
    this.isTextArea,
    this.hint,
    this.showCharLimit,
    this.isNameInput,
  });

  @override
  State<SurelineTextField> createState() => _SurelineTextFieldState();
}

class _SurelineTextFieldState extends State<SurelineTextField> {
  int _inputLength = 0;
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 250), (){
        _focusNode.requestFocus();
      });
      widget.controller.addListener((){
        setState(() {
          _inputLength = widget.controller.text.length;
        });
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          // width: 342,
          height: (widget.isTextArea ?? false) ? 54 * 3 : 54,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.pureWhite, width: 1.5),
            borderRadius: BorderRadius.circular(10),
            color: AppColors.pureWhite.withValues(alpha: 0.53),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              focusNode: _focusNode,
              controller: widget.controller,
              textAlign:
                  (widget.disableCenterAlignment ?? false)
                      ? TextAlign.start
                      : TextAlign.center,
              // keyboardType: (widget.isNameInput ?? false) ? TextInputType.name : null,
              textCapitalization: (widget.isNameInput ?? false) ? TextCapitalization.words : TextCapitalization.none,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hint,
              ),
              maxLength: (widget.showCharLimit ?? false) ? 250 : null,
              maxLines: (widget.isTextArea ?? false) ? null : 1,
              buildCounter: (
                BuildContext context, {
                required int currentLength,
                required bool isFocused,
                required int? maxLength,
              }) {
                return null;
              },
            ),
          ),
        ),
        if (widget.showCharLimit ?? false) ...[
          SizedBox(height: 15),
          Text('$_inputLength/250'),
        ]
      ],
    );
  }
}
