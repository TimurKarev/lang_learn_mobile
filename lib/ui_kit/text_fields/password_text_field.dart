import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/ui_kit/text_fields/tili_text_field.dart'
    show TiliTextField;

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({super.key});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TiliTextField(
      hintText: 'Enter your password',
      obscureText: _obscureText,
      suffixIcon: _obscureText ? Icons.visibility_off : Icons.visibility,
      onSuffixIconTap: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }
}
