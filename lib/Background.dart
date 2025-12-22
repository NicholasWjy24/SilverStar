import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      body: SilkyMetallicBackground(
        child: Center(
          child: Text(
            "METALLIC\nDREAMS",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white54,
                letterSpacing: 2.0,
                shadows: [
                  Shadow(blurRadius: 10, color: Colors.black26, offset: Offset(2, 2))
                ]
            ),
          ),
        ),
      ),
    ),
  ));
}

class SilkyMetallicBackground extends StatefulWidget {
  final Widget child;

  const SilkyMetallicBackground({Key? key, required this.child})
      : super(key: key);

  @override
  State<SilkyMetallicBackground> createState() =>
      _SilkyMetallicBackgroundState();
}

class _SilkyMetallicBackgroundState extends State<SilkyMetallicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // A long duration makes the transitions feel luxurious and smooth
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return CustomPaint(
            painter: SilkyPainter(_controller.value),
            child: widget.child,
          );
        },
      ),
    );
  }
}

class SilkyPainter extends CustomPainter {
  final double animationValue;

  SilkyPainter(this.animationValue);

  // Helper function to create a star shape with rotation
  Path _createStarPath(Offset center, double outerRadius, int points, {double rotation = 0}) {
    final innerRadius = outerRadius * 0.4;
    final path = Path();
    final double step = math.pi / points;

    // Apply rotation here. Start at -pi/2 to point up, then add rotation angle.
    var angle = -math.pi / 2 + rotation;

    path.moveTo(
        center.dx + outerRadius * math.cos(angle),
        center.dy + outerRadius * math.sin(angle)
    );

    for (int i = 1; i <= points * 2; i++) {
      final radius = i.isEven ? outerRadius : innerRadius;
      angle += step;
      path.lineTo(
          center.dx + radius * math.cos(angle),
          center.dy + radius * math.sin(angle)
      );
    }
    path.close();
    return path;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    // The fundamental looping phase (0 to 2*PI)
    final basePhase = animationValue * 2 * math.pi;

    // --- 1. Draw Metallic Background ---
    final bgGradient = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: const [
        Color(0xFFD4D4D4),
        Color(0xFFE8E8E8),
        Color(0xFFC0C0C0),
        Color(0xFFD8D8D8),
      ],
    );
    canvas.drawRect(rect, Paint()..shader = bgGradient.createShader(rect));


    // --- 1.5 Draw Looping, Twinkling Stars ---
    final starPaint = Paint()
      ..style = PaintingStyle.fill
    // A slight blur makes them look shiny and distant
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2.0);

    const int numStars = 8;

    for (int i = 0; i < numStars; i++) {
      // Static base position
      final baseX = size.width * ((i + 0.5) / numStars);
      final baseY = size.height * (0.15 + (i % 3) * 0.25) + (i.isEven ? 20 : -20);

      // A. Movement Drift
      // Use integer multipliers of basePhase (e.g., *1, *2) to ensure perfect looping
      final driftX = math.sin(basePhase + i) * 20.0;
      final driftY = math.cos(basePhase + i * 2) * 15.0;
      final center = Offset(baseX + driftX, baseY + driftY);

      // B. Twinkle (Opacity Transition)
      // Creates a value oscillating between ~0.2 and ~0.7 smoothly
      final twinkleOpacity = 0.2 + (math.sin(basePhase * 2 + i) + 1.0) / 2.0 * 0.5;
      starPaint.color = Colors.white.withOpacity(twinkleOpacity);

      // C. Pulse (Scale Transition)
      final baseRadius = 10.0 + (i % 3) * 5.0;
      // Scales subtly between 90% and 110% size
      final scale = 0.9 + (math.cos(basePhase + i) + 1.0) / 2.0 * 0.2;
      final currentRadius = baseRadius * scale;

      // D. Rotation Transition
      // Slow rotation. Even indexes rotate one way, odd the other.
      final rotationDirection = i.isEven ? 1 : -1;
      final currentRotation = basePhase * 0.1 * rotationDirection + i;

      final starPath = _createStarPath(center, currentRadius, 5, rotation: currentRotation);
      canvas.drawPath(starPath, starPaint);
    }


    // --- 2. Configure Silk Paint ---
    // Overlay mode is crucial here. It makes the silk layers interact
    // visually with the stars and background beneath them.
    final silkPaint = Paint()
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.overlay;

    // --- 3. Draw flowing silk waves ---
    for (int layer = 0; layer < 5; layer++) {
      final path = Path();
      final layerOffset = layer * math.pi / 3;

      path.moveTo(0, size.height * 0.3);

      // Increased step size slightly for performance, still looks smooth
      for (double x = 0; x <= size.width; x += 3) {
        final y1 = math.sin(x / 80 + basePhase + layerOffset) * 40;
        // Ensure integer multipliers on basePhase for loops
        final y2 = math.cos(x / 120 - basePhase * 1 - layerOffset) * 60;
        final y3 = math.sin(x / 200 + basePhase * 2 + layerOffset) * 80;
        final y = size.height * (0.3 + layer * 0.15) + y1 + y2 + y3;
        path.lineTo(x, y);
      }

      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white.withOpacity(0.3 - layer * 0.05),
          Colors.grey.withOpacity(0.15 - layer * 0.02),
        ],
      );

      silkPaint.shader = gradient.createShader(rect);
      canvas.drawPath(path, silkPaint);
    }

    // --- 4. Draw Highlights ---
    final highlightPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..blendMode = BlendMode.screen;

    for (int i = 0; i < 3; i++) {
      final highlightPath = Path();
      final highlightOffset = i * math.pi / 2;

      highlightPath.moveTo(0, size.height * (0.2 + i * 0.25));

      for (double x = 0; x <= size.width; x += 5) {
        final y1 = math.sin(x / 100 + basePhase + highlightOffset) * 50;
        final y2 = math.cos(x / 150 - basePhase - highlightOffset) * 30;
        final y = size.height * (0.2 + i * 0.25) + y1 + y2;
        highlightPath.lineTo(x, y);
      }

      highlightPaint.color = Colors.white.withOpacity(0.4 - i * 0.1);
      canvas.drawPath(highlightPath, highlightPaint);
    }
  }

  @override
  bool shouldRepaint(SilkyPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}