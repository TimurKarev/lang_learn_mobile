import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/memory_card_answer_body.dart';
import 'package:lang_learn_mobile/ui_kit/cards/memory_card/widgets/memory_card_question_body.dart';

class MemoryCardWidget extends StatefulWidget {
  const MemoryCardWidget({
    super.key,
    required this.onPressAudio,
    required this.card,
    this.onPressedAfterFlipped,
    this.onCardFlipped,
    this.padding = EdgeInsets.zero,
  });

  final Flashcard card;
  final VoidCallback? onCardFlipped;
  final VoidCallback? onPressedAfterFlipped;
  final void Function(String literalId) onPressAudio;

  final EdgeInsets padding;

  @override
  State<MemoryCardWidget> createState() => _MemoryCardWidgetState();
}

class _MemoryCardWidgetState extends State<MemoryCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        setState(() {
          _isFlipped = !_isFlipped;
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant MemoryCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.card != oldWidget.card) {
      setState(() {
        _isFlipped = false;
      });
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: GestureDetector(
        onTap: () {
          if (_isFlipped) {
            widget.onPressedAfterFlipped?.call();
          } else {
            _controller.forward();
          }
          widget.onCardFlipped?.call();
        },
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final isShowingBack = _animation.value > pi / 2;
            return Transform(
              transform: Matrix4.rotationY(_animation.value),
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: isShowingBack ? 0 : 4,
                    shape: isShowingBack
                        ? RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          )
                        : null,
                    color: isShowingBack
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerLowest,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..scale(isShowingBack ? -1.0 : 1.0, 1.0, 1.0),
                      alignment: Alignment.center,
                      child: !isShowingBack
                          ? MemoryCardQuestionBody(
                              question: widget.card.fWord.word,
                              lang: widget.card.fWord.lang,
                              transcript: widget.card.fWord.transcript,
                              stringHint: widget.card.sWord.stringHint,
                              imageHintPath: widget.card.sWord.imagePath,
                            )
                          : MemoryCardAnswerBody(
                              question: widget.card.fWord,
                              answer: widget.card.sWord,
                              onPressAudio: widget.onPressAudio,
                              literaId: widget.card.sWord.id,
                            ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
