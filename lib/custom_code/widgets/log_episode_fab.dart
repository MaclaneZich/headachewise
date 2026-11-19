// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart';

class LogEpisodeFab extends StatefulWidget {
  const LogEpisodeFab({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _LogEpisodeFabState createState() => _LogEpisodeFabState();
}

class _LogEpisodeFabState extends State<LogEpisodeFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.45, end: 0.75).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const indigo = Color(0xFF6366F1);
    const white = Color(0xFFFFFFFF);

    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          width: widget.width ?? 160,
          height: widget.height ?? 52,
          decoration: BoxDecoration(
            color: indigo,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: indigo.withOpacity(_glowAnimation.value),
                blurRadius: 24,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: white, size: 18),
              SizedBox(width: 10),
              Text(
                'Log Episode',
                style: TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.02,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
