import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _exitController;

  late Animation<double> _scaleIn;
  late Animation<double> _fadeIn;
  late Animation<double> _scaleOut;
  late Animation<double> _fadeOut;

  bool _hideRest = false;

  @override
  void initState() {
    super.initState();

    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeOutBack),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _entryController, curve: Curves.easeIn),
    );

    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _scaleOut = Tween<double>(begin: 1.0, end: 20.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOut),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeOut),
    );

    _entryController.forward();

    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        _hideRest = true;
      });
      _exitController.forward();
    });

    _exitController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: Listenable.merge([_scaleIn, _scaleOut, _fadeOut]),
              builder: (context, child) {
                double combinedScale = _scaleIn.value * _scaleOut.value;
                return FadeTransition(
                  opacity: _fadeOut,
                  child: Transform.scale(
                    scale: combinedScale,
                    child: FaIcon(
                      FontAwesomeIcons.brain,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              },
            ),
            if (!_hideRest) ...[
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _fadeIn,
                child: const Text(
                  'Quiz',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: const LinearProgressIndicator(),
              ),
              const SizedBox(height: 20),
              const Text(
                'Carregando...',
                style: TextStyle(fontSize: 18),
              ),
            ]
          ],
        ),
      ),
    );
  }
}