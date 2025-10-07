import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DualRadioList<T> extends StatefulWidget {
  const DualRadioList({
    super.key,
    required this.onChanged,
    required this.value1,
    required this.value2,
    required this.isValue1,
    required this.labelBuilder,
  });

  final Function(T) onChanged;
  final T value1;
  final T value2;
  final bool isValue1;
  final String Function(T) labelBuilder;

  @override
  State<DualRadioList<T>> createState() => _DualRadioListState<T>();
}

class _DualRadioListState<T> extends State<DualRadioList<T>> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border(
                  top: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                color: widget.isValue1
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => widget.onChanged(widget.value1),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.labelBuilder(widget.value1),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      FaIcon(
                        widget.isValue1
                            ? FontAwesomeIcons.solidCircleCheck
                            : Icons.radio_button_unchecked,
                        color: widget.isValue1
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                  right: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
                color: !widget.isValue1
                    ? Theme.of(context).colorScheme.surface
                    : Theme.of(context).colorScheme.surfaceContainerLowest,
              ),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => widget.onChanged(widget.value2),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.labelBuilder(widget.value2),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      FaIcon(
                        !widget.isValue1
                            ? FontAwesomeIcons.solidCircleCheck
                            : Icons.radio_button_unchecked,
                        color: !widget.isValue1
                            ? Theme.of(context).colorScheme.tertiary
                            : Theme.of(context).colorScheme.outline,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Divider(
          color: Theme.of(context).colorScheme.primaryContainer,
          thickness: 1,
          height: 1,
          indent: 1,
          endIndent: 1,
        ),
      ],
    );
  }
}
