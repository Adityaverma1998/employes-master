import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({
    super.key,
    required this.controller,
    this.textInputAction,
    this.keyboardType,
    this.onChanged,
    this.validation,
    this.maxLength,
    this.maxLines,
    this.minLines,
    this.autoFocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.focusNode,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.decoration,
    this.readOnly = false,
    this.autofillHints,
    this.obscureText = false,
    this.ontap,
    this.onFieldSubmitted,
    this.textStyle,
    this.textInputFormatter,
  });

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final String? Function(String?)? validation;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool autoFocus;
  final TextCapitalization textCapitalization;
  final FocusNode? focusNode;
  final bool readOnly;
  final AutovalidateMode? autoValidateMode;
  final InputDecoration? decoration;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final VoidCallback? ontap;
  final Function(String)? onFieldSubmitted;
  final TextStyle? textStyle;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: textStyle,
      onTap: ontap,
      onFieldSubmitted: onFieldSubmitted,
      onTapOutside: (PointerDownEvent event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      enableInteractiveSelection: true,
      obscureText: obscureText,
      obscuringCharacter: '*',
      autofillHints: autofillHints,
      autovalidateMode: autoValidateMode,
      readOnly: readOnly,
      focusNode: focusNode,
      textCapitalization: textCapitalization,
      controller: controller,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      validator: validation,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      autofocus: autoFocus,
      onChanged: onChanged,
      inputFormatters:
          textInputFormatter ??
          <TextInputFormatter>[
            // if (keyboardType == TextInputType.text)
            //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.@_ -]')),
            // if (keyboardType == TextInputType.name)
            //   FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
            if (keyboardType == TextInputType.text ||
                keyboardType == TextInputType.name)
              // FilteringTextInputFormatter.allow(
              //   RegExp(r'[\p{L}\p{N}\s.@_-]', unicode: true),
              // ),
              if (keyboardType == TextInputType.streetAddress)
                FilteringTextInputFormatter.deny(RegExp(r'[.]')),
            if (keyboardType == TextInputType.number)
              FilteringTextInputFormatter.digitsOnly,
            if (keyboardType ==
                const TextInputType.numberWithOptions(decimal: true))
              // FilteringTextInputFormatter.allow(
              //   RegExp(
              //     '(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])',
              //   ),
              // ),
              if (keyboardType == TextInputType.url)
                FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9.]')),
          ],

      // inputFormatters: _formattersForKeyboardType(),
      decoration: decoration,
    );
  }
}
