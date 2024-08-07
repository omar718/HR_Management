import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

// Animation properties enumeration
enum AniProps { opacity, translateY }

// FadeAnimation widget class
class FadeAnimation extends StatelessWidget {
  final double delay;  // Delay before animation starts
  final Widget child;  // Child widget to animate

  // Constructor with required parameters
  FadeAnimation({required this.delay, required this.child});

  @override
  Widget build(BuildContext context) {
    // Create a MultiTween for animating opacity and translateY
    final tween = MovieTween()
      ..scene(
              begin: Duration.zero,
              end: const Duration(milliseconds: 500))
          .tween(AniProps.opacity, 0.0.tweenTo(1.0))
          .tween(AniProps.translateY, (-30.0).tweenTo(0.0),
              curve: Curves.easeOut);

    // Use PlayAnimationBuilder to animate the child widget
    return PlayAnimationBuilder<Movie>(
      tween: tween, // Set the tween
      duration: tween.duration, // Set the duration of the animation
      delay: Duration(milliseconds: (500 * delay).round()), // Set the delay
      builder: (context, value, child) {
        // Build the widget with opacity and transform
        return Opacity(
          opacity: value.get(AniProps.opacity),
          child: Transform.translate(
            offset: Offset(0, value.get(AniProps.translateY)),
            child: child,
          ),
        );
      },
      child: child, // The child widget to animate
    );
  }
}
