import 'dart:math';
import 'package:flutter/material.dart';

class AnimatedStepRing extends StatelessWidget {
  final int currentSteps;
  final int goalSteps;
  final double size;

  const AnimatedStepRing({
    super.key,
    required this.currentSteps,
    required this.goalSteps,
    this.size = 220.0,
  });

  @override
  Widget build(BuildContext context) {
    final double targetProgress = goalSteps > 0 ? (currentSteps / goalSteps).clamp(0.0, 1.0) : 0.0;
    final primaryColor = Theme.of(context).colorScheme.primary;
    final secondaryColor = Theme.of(context).colorScheme.tertiary;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background track ring
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: 14,
              color: primaryColor.withOpacity(0.12),
            ),
          ),
          // Animated Fill Ring
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: targetProgress),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, value, child) {
              return SizedBox(
                width: size,
                height: size,
                child: CustomPaint(
                  painter: _GradientRingPainter(
                    progress: value,
                    startColor: primaryColor,
                    endColor: secondaryColor,
                    strokeWidth: 14,
                  ),
                ),
              );
            },
          ),
          // Central Animated Step Count Text
          TweenAnimationBuilder<int>(
            tween: IntTween(begin: 0, end: currentSteps),
            duration: const Duration(milliseconds: 1200),
            curve: Curves.easeOutCubic,
            builder: (context, animatedSteps, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.directions_walk,
                    size: 28,
                    color: primaryColor,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$animatedSteps',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                  ),
                  Text(
                    'Goal: $goalSteps',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GradientRingPainter extends CustomPainter {
  final double progress;
  final Color startColor;
  final Color endColor;
  final double strokeWidth;

  _GradientRingPainter({
    required this.progress,
    required this.startColor,
    required this.endColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final rect = Rect.fromCircle(center: center, radius: radius);
    final sweepAngle = 2 * pi * progress;

    final paint = Paint()
      ..shader = SweepGradient(
        colors: [startColor, endColor, startColor],
        transform: GradientRotation(-pi / 2),
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    canvas.drawArc(rect, -pi / 2, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(covariant _GradientRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.startColor != startColor ||
        oldDelegate.endColor != endColor;
  }
}
