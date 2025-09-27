import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/core/theme/tili_palette.dart';

class TiliTextField extends StatefulWidget {
  const TiliTextField({
    super.key,
    this.controller,
    this.hintText,
    this.enabled = true,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixIconTap,
  });

  final TextEditingController? controller;
  final String? hintText;
  final bool enabled;
  final bool obscureText;
  final IconData? suffixIcon;
  final Function()? onSuffixIconTap;

  @override
  State<TiliTextField> createState() => _TiliTextFieldState();
}

class _TiliTextFieldState extends State<TiliTextField> {
  TextEditingController _controller = TextEditingController();
  bool _obscureText = false;
  bool _showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    }
    _obscureText = widget.obscureText;
    _showSuffixIcon = widget.suffixIcon != null;
  }

  @override
  void didUpdateWidget(covariant TiliTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needSetState = false;
    if (widget.obscureText != oldWidget.obscureText) {
      _obscureText = widget.obscureText;
      needSetState = true;
    }
    if (widget.suffixIcon != oldWidget.suffixIcon) {
      _showSuffixIcon = widget.suffixIcon != null;
      needSetState = true;
    }
    if (needSetState) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      autocorrect: false,
      cursorColor: TiliPalette.mutedTeal,
      controller: _controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        suffixIcon: _showSuffixIcon
            ? GestureDetector(
                onTap: widget.onSuffixIconTap,
                child: Icon(widget.suffixIcon),
              )
            : null,
        suffixIconColor: TiliPalette.veryLightGrayMedium,
        hintText: widget.hintText,
        filled: true,
        fillColor: widget.enabled
            ? TiliPalette.grayLight
            : TiliPalette.veryLightGrayMedium,
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: widget.enabled
              ? TiliPalette.veryLightGrayMedium
              : TiliPalette.grayishBlue,
        ),
      ),
      enabled: widget.enabled,
    );
  }
}
