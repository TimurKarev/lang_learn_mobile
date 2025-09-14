import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lang_learn_mobile/features/memory_cards/domain/entities/flashcard.dart';

class MemoryCardWidget extends StatefulWidget {
  const MemoryCardWidget({
    super.key,
    required this.card,
    this.onPressedAfterFlipped,
    this.onCardFlipped,
    this.padding = EdgeInsets.zero,
  });

  final Flashcard card;
  final VoidCallback? onCardFlipped;
  final VoidCallback? onPressedAfterFlipped;

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
                    color: isShowingBack
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.secondaryContainer,
                    child: Transform(
                      transform: Matrix4.identity()
                        ..scale(isShowingBack ? -1.0 : 1.0, 1.0, 1.0),
                      alignment: Alignment.center,
                      child: !isShowingBack
                          ? _QuestionBody(
                              question: widget.card.fWord.word,
                              lang: widget.card.fWord.lang,
                              transcript: widget.card.fWord.transcript,
                            )
                          : _AnswerBody(
                              question: widget.card.fWord.word,
                              questionlang: widget.card.fWord.lang,
                              answerTranscript: widget.card.sWord.transcript,
                              answer: widget.card.sWord.word,
                              answerLang: widget.card.sWord.lang,
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

class _QuestionBody extends StatelessWidget {
  const _QuestionBody({
    required this.question,
    required this.lang,
    required this.transcript,
  });

  final String question;
  final String lang;
  final String transcript;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          lang,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          question,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '/$transcript/',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 2),
      ],
    );
  }
}

class _AnswerBody extends StatelessWidget {
  const _AnswerBody({
    required this.question,
    required this.questionlang,
    required this.answerTranscript,
    required this.answer,
    required this.answerLang,
  });

  final String question;
  final String questionlang;
  final String answerTranscript;
  final String answer;
  final String answerLang;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Text(
          answerLang,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          answer,
          style: Theme.of(context).textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          '/$answerTranscript/',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
          height: 64,
          indent: 32,
          endIndent: 32,
        ),
        Text(
          questionlang,
          style: Theme.of(context).textTheme.titleSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          question,
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const Spacer(flex: 3),
      ],
    );
  }
}
