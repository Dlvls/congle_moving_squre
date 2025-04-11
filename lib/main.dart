import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  Alignment _squareAlignment = Alignment.center;
  bool _animating = false;

  static const Alignment _leftPosition = Alignment.centerLeft;
  static const Alignment _centerPosition = Alignment.center;
  static const Alignment _rightPosition = Alignment.centerRight;

  bool get _isAtLeftEdge => _squareAlignment == _leftPosition;

  bool get _isAtRightEdge => _squareAlignment == _rightPosition;

  void _toLeft() {
    if (_animating || _isAtLeftEdge) return;

    setState(() {
      _animating = true;
      _squareAlignment = _leftPosition;
    });
  }

  void _toRight() {
    if (_animating || _isAtRightEdge) return;

    setState(() {
      _animating = true;
      _squareAlignment = _rightPosition;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AnimatedAlign(
          alignment: _squareAlignment,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOut,
          onEnd: () {
            setState(() {
              _animating = false;
            });
          },
          child: Container(
            width: _squareSize,
            height: _squareSize,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: (_animating || _isAtLeftEdge) ? null : _toLeft,
              child: const Text('Left'),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: (_animating || _isAtRightEdge) ? null : _toRight,
              child: const Text('Right'),
            ),
          ],
        ),
      ],
    );
  }
}
