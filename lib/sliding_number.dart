library sliding_number;

import 'package:flutter/material.dart';

/// A widget that contains a number whose digits slide when it changes.
class SlidingNumber extends StatelessWidget {
  /// Creates a number whose digits slide when it changes.
  const SlidingNumber({
    required this.number,
    this.style = const TextStyle(),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.linear,
  });

  /// The number this widget represents.
  final int number;

  /// The text style to use for this number.
  final TextStyle style;

  /// The duration of the slide animation.
  final Duration duration;

  /// The curve of the slide animation.
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final numberString = number.abs().toString();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (number.isNegative) Text('-', style: style),
        for (int i = 0; i < numberString.length; i++)
          _SlidingDigit(
            digit: int.parse(numberString[i]),
            style: style,
            duration: duration,
            curve: curve,
          ),
      ],
    );
  }
}

class _SlidingDigit extends StatefulWidget {
  const _SlidingDigit({
    required this.digit,
    required this.style,
    required this.duration,
    required this.curve,
  }) : assert(digit >= 0 && digit <= 9);

  final int digit;
  final TextStyle style;
  final Duration duration;
  final Curve curve;

  @override
  _SlidingDigitState createState() => _SlidingDigitState();
}

class _SlidingDigitState extends State<_SlidingDigit> {
  final _scrollController = ScrollController();
  double _digitHeight = 0.0;

  @override
  void initState() {
    super.initState();
    _slide(initialization: true);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _SlidingDigit oldWidget) {
    super.didUpdateWidget(oldWidget);    
    _slide();
  }

  void _slide({bool initialization = false}) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      final divider = initialization ? 10 : 9;
      if(!mounted){
        return;
      }
      setState(() {
        _digitHeight = _scrollController.position.maxScrollExtent / divider;
      });
      _scrollController.animateTo(
        _digitHeight * widget.digit,
        duration: widget.duration,
        curve: widget.curve,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: _digitHeight),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(10, (digit) {
              return Text('$digit', style: widget.style);
            }),
          ),
        ),
      ),
    );
  }
}
