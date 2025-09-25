import 'package:flutter/material.dart';
import 'dart:ui';


class GlassMorphism extends StatelessWidget {
  final Widget child;
  final double start;
  final double end;

  const GlassMorphism({
    super.key,
    required this.child,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    const brown1 = Color(0xFF8B5E3C);
    const brown2 = Color(0xFF3E2723);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [brown1.withOpacity(start), brown2.withOpacity(end)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 1.2,
              color: Colors.white.withOpacity(0.2),
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
