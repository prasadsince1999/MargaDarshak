import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/providers/user_provider.dart';
import '../../../core/theme/theme.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({
    super.key,
    this.delay = const Duration(milliseconds: 1800),
  });

  final Duration delay;

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.delay, _finishSplash);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _finishSplash() {
    if (!mounted) return;
    final isOnboarded = ref.read(isOnboardedProvider);
    context.go(isOnboarded ? '/' : '/onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      child: const Scaffold(body: _SplashScene()),
    );
  }
}

class _SplashScene extends StatelessWidget {
  const _SplashScene();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final scale = (width / 390).clamp(0.86, 1.18);
        final graphicShadow = AppShape.graphicShadowDistance * scale;
        final heroShadow = AppShape.heroShadowDistance * scale;
        final cardLeft = 28.0 * scale;
        final cardTop = math.max(height * 0.21, 158.0 * scale);
        final cardWidth = width - (cardLeft * 2);
        final cardHeight = math.min(math.max(height * 0.36, 470.0), 660.0);
        final blueBlockWidth = width * 0.38;
        final blueBlockHeight = 118.0 * scale;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            const _ArchitecturalGrid(),
            Positioned(
              left: 34 * scale,
              top: 50 * scale,
              child: _ShadowedBlock(
                width: 112 * scale,
                height: 112 * scale,
                color: AppColors.secondary,
                radius: 18 * scale,
                shadowOffset: Offset(graphicShadow, graphicShadow),
              ),
            ),
            Positioned(
              right: 28 * scale,
              top: -14 * scale,
              child: _ShadowedBlock(
                width: 172 * scale,
                height: 172 * scale,
                color: AppColors.primaryContainer,
                angle: 0.18,
                shadowOffset: Offset(graphicShadow, graphicShadow),
              ),
            ),
            _HeroCard(
              left: cardLeft,
              top: cardTop,
              width: cardWidth,
              height: cardHeight,
              scale: scale,
              graphicShadow: graphicShadow,
              heroShadow: heroShadow,
            ),
            Positioned(
              left: 64 * scale,
              bottom: 86 * scale,
              child: Transform.rotate(
                angle: -0.18,
                child: _PlainShadowBlock(
                  width: 76 * scale,
                  height: 76 * scale,
                  color: AppColors.surfaceDim,
                  shadowOffset: Offset(graphicShadow, graphicShadow),
                ),
              ),
            ),
            Positioned(
              right: 38 * scale,
              bottom: 66 * scale,
              child: _PlainShadowBlock(
                width: blueBlockWidth,
                height: blueBlockHeight,
                color: AppColors.tertiary,
                shadowOffset: Offset(graphicShadow, graphicShadow),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ArchitecturalGrid extends StatelessWidget {
  const _ArchitecturalGrid();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.outline.withValues(alpha: 0.1);

    return IgnorePointer(
      child: CustomPaint(
        size: Size.infinite,
        painter: _GridPainter(color: color),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1;

    for (final fraction in const [0.25, 0.75]) {
      final dx = size.width * fraction;
      final dy = size.height * fraction;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({
    required this.left,
    required this.top,
    required this.width,
    required this.height,
    required this.scale,
    required this.graphicShadow,
    required this.heroShadow,
  });

  final double left;
  final double top;
  final double width;
  final double height;
  final double scale;
  final double graphicShadow;
  final double heroShadow;

  @override
  Widget build(BuildContext context) {
    final headlineStyle = Theme.of(context).textTheme.displayLarge?.copyWith(
      fontSize: 44 * scale,
      height: 0.92,
      fontWeight: FontWeight.w700,
      letterSpacing: 0,
      color: AppColors.textPrimary,
    );
    final tagStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
      fontSize: 14.5 * scale,
      height: 1.5,
      letterSpacing: 0,
      fontWeight: FontWeight.w700,
      color: AppColors.textPrimary,
    );

    return Positioned(
      left: left,
      top: top,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: heroShadow,
            top: heroShadow,
            child: Container(
              width: width,
              height: height,
              color: AppColors.outline,
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.surface,
              border: Border.all(
                color: AppColors.outline,
                width: AppShape.borderWidthThick,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                48 * scale,
                42 * scale,
                42 * scale,
                36 * scale,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          _WindowDot(color: AppColors.secondary, scale: scale),
                          SizedBox(width: 10 * scale),
                          _WindowDot(
                            color: AppColors.primaryContainer,
                            scale: scale,
                          ),
                          SizedBox(width: 10 * scale),
                          _WindowDot(color: AppColors.tertiary, scale: scale),
                        ],
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.only(bottom: 4 * scale),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: AppColors.outline,
                              width: 2 * scale,
                            ),
                          ),
                        ),
                        child: Text(
                          'V_1.0',
                          style: Theme.of(context).textTheme.labelLarge
                              ?.copyWith(
                                fontSize: 18 * scale,
                                letterSpacing: 0,
                                color: AppColors.textPrimary,
                              ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 36 * scale),
                  Text(
                    'MARGA\nDARSHAK',
                    key: const Key('splash_wordmark'),
                    style: headlineStyle,
                  ),
                  SizedBox(height: 36 * scale),
                  _MiniYellowBar(scale: scale),
                  SizedBox(height: 28 * scale),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: width * 0.82),
                    child: Text(
                      'YOUR PATH TO A\nPURPOSEFUL CAREER.',
                      key: const Key('splash_tagline'),
                      style: tagStyle,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -(98 * scale),
            top: -(14 * scale),
            child: _BlueTab(scale: scale),
          ),
          Positioned(
            right: -(50 * scale),
            top: 152 * scale,
            child: _PlainShadowBlock(
              width: 74 * scale,
              height: 20 * scale,
              color: AppColors.primaryContainer,
              shadowOffset: Offset(graphicShadow, graphicShadow),
            ),
          ),
          Positioned(
            right: -(24 * scale),
            bottom: -(24 * scale),
            child: _ShadowedBlock(
              width: 70 * scale,
              height: 70 * scale,
              color: AppColors.secondary,
              radius: 16 * scale,
              shadowOffset: Offset(graphicShadow, graphicShadow),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniYellowBar extends StatelessWidget {
  const _MiniYellowBar({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 138 * scale + (AppShape.graphicShadowDistance * scale),
      height: 22 * scale + (AppShape.graphicShadowDistance * scale),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: AppShape.graphicShadowDistance * scale,
            top: AppShape.graphicShadowDistance * scale,
            child: Container(
              width: 138 * scale,
              height: 22 * scale,
              color: AppColors.outline,
            ),
          ),
          Container(
            width: 138 * scale,
            height: 22 * scale,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer,
              border: Border.all(
                color: AppColors.outline,
                width: AppShape.borderWidthThick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BlueTab extends StatelessWidget {
  const _BlueTab({required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 94 * scale + (AppShape.graphicShadowDistance * scale),
      height: 42 * scale + (AppShape.graphicShadowDistance * scale),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: AppShape.graphicShadowDistance * scale,
            top: AppShape.graphicShadowDistance * scale,
            child: Container(
              width: 94 * scale,
              height: 42 * scale,
              color: AppColors.outline,
            ),
          ),
          Container(
            width: 94 * scale,
            height: 42 * scale,
            decoration: BoxDecoration(
              color: AppColors.tertiary,
              border: Border.all(
                color: AppColors.outline,
                width: AppShape.borderWidthThick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShadowedBlock extends StatelessWidget {
  const _ShadowedBlock({
    required this.width,
    required this.height,
    required this.color,
    this.radius = 0,
    this.angle = 0,
    required this.shadowOffset,
  });

  final double width;
  final double height;
  final Color color;
  final double radius;
  final double angle;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: SizedBox(
        width: width + shadowOffset.dx,
        height: height + shadowOffset.dy,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: shadowOffset.dx,
              top: shadowOffset.dy,
              child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.outline,
                  borderRadius: BorderRadius.circular(radius),
                ),
              ),
            ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(
                  color: AppColors.outline,
                  width: AppShape.borderWidthThick,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlainShadowBlock extends StatelessWidget {
  const _PlainShadowBlock({
    required this.width,
    required this.height,
    required this.color,
    required this.shadowOffset,
  });

  final double width;
  final double height;
  final Color color;
  final Offset shadowOffset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width + shadowOffset.dx,
      height: height + shadowOffset.dy,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: shadowOffset.dx,
            top: shadowOffset.dy,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: AppColors.outline),
            ),
          ),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: AppColors.outline,
                width: AppShape.borderWidthThick,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WindowDot extends StatelessWidget {
  const _WindowDot({required this.color, required this.scale});

  final Color color;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18 * scale,
      height: 18 * scale,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.outline,
          width: AppShape.borderWidthThick,
        ),
      ),
    );
  }
}
