import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class FireworkWidget extends StatefulWidget {
  const FireworkWidget({super.key});

  @override
  State<FireworkWidget> createState() => _FireworkWidgetState();
}

class _FireworkWidgetState extends State<FireworkWidget> {

  late ConfettiController _topLeftController;
  late ConfettiController _topRightController;
  late ConfettiController _bottomLeftController;
  late ConfettiController _bottomRightController;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    _topLeftController =
        ConfettiController(duration: const Duration(seconds: 1));
    _topRightController =
        ConfettiController(duration: const Duration(seconds: 2));
    _bottomLeftController =
        ConfettiController(duration: const Duration(seconds: 3));
    _bottomRightController =
        ConfettiController(duration: const Duration(seconds: 4));
    _centerController = ConfettiController(
        duration: const Duration(seconds: 1)); // Longer burst
  }

  @override
  void dispose() {
    _topLeftController.dispose();
    _topRightController.dispose();
    _bottomLeftController.dispose();
    _bottomRightController.dispose();
    _centerController.dispose();
    super.dispose();
  }

  void _playFireworkEffect() {
    // Trigger fireworks in sequence
    _topLeftController.play();
    Future.delayed(
        const Duration(milliseconds: 200), () => _topRightController.play());
    Future.delayed(
        const Duration(milliseconds: 400), () => _bottomLeftController.play());
    Future.delayed(
        const Duration(milliseconds: 600), () => _bottomRightController.play());
    Future.delayed(
        const Duration(milliseconds: 800), () => _centerController.play());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 400,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: [
            // Background image
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top:  Radius.circular(5), bottom: Radius.circular(5)),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.asset(
                  'assets/img.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, url, error) =>
                      const Icon(Icons.error, size: 50),
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
              ),
            ),
            // Title and subtitle
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.title, color: Colors.white, size: 16),
                              SizedBox(width: 5),
                              Text(
                                'title',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.subtitles,
                                  color: Colors.white, size: 16),
                              SizedBox(width: 5),
                              Text(
                                'subtitle',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Play button with animation and fireworks
                    IconButton(
                      onPressed: () {
                        _playFireworkEffect();
                      },
                      icon: const Icon(Icons.play_circle_fill,
                          size: 50, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            // Fireworks in all corners
            Positioned(
              top: 0,
              left: 0,
              child: ConfettiWidget(
                confettiController: _topLeftController,
                blastDirection: 3.14 / 4,
                emissionFrequency: 0.1,
                numberOfParticles: 20,
                colors: const [Colors.red, Colors.yellow, Colors.blue],
                particleDrag: 0.1,
                createParticlePath: _drawStar, // Custom shape
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: _topRightController,
                blastDirection: 3 * 3.14 / 4,
                emissionFrequency: 0.1,
                numberOfParticles: 20,
                colors: const [Colors.purple, Colors.green, Colors.orange],
                createParticlePath: _drawCircle, // Circular confetti
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: ConfettiWidget(
                confettiController: _bottomLeftController,
                blastDirection: -3.14 / 4,
                emissionFrequency: 0.1,
                numberOfParticles: 20,
                colors: const [Colors.cyan, Colors.pink, Colors.lime],
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: ConfettiWidget(
                confettiController: _bottomRightController,
                blastDirection: -3 * 3.14 / 4,
                emissionFrequency: 0.1,
                numberOfParticles: 20,
                colors: [Colors.teal, Colors.indigo, Colors.amber],
              ),
            ),
            // Center firework burst
            Positioned.fill(
              child: ConfettiWidget(
                confettiController: _centerController,
                blastDirectionality: BlastDirectionality.explosive,
                emissionFrequency: 0.3,
                numberOfParticles: 50,
                colors: [Colors.white, Colors.redAccent, Colors.lightBlue],
              ),
            ),

          ],
        ),
      ),
    );
  }

  // Custom particle path for stars
  Path _drawStar(Size size) {
    // Custom star shape for particles
    final path = Path();
    path.moveTo(0, -10);
    path.lineTo(2.4, -3.1);
    path.lineTo(9.5, -3.1);
    path.lineTo(3.8, 1.2);
    path.lineTo(6.2, 8.1);
    path.lineTo(0, 4.6);
    path.lineTo(-6.2, 8.1);
    path.lineTo(-3.8, 1.2);
    path.lineTo(-9.5, -3.1);
    path.lineTo(-2.4, -3.1);
    path.close();
    return path;
  }

  Path _drawCircle(Size size) {
    return Path()..addOval(Rect.fromCircle(center: Offset.zero, radius: 5));
  }
}
