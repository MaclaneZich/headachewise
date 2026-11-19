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

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class ActiveHeadacheCard extends StatefulWidget {
  const ActiveHeadacheCard({
    Key? key,
    this.width,
    this.height,
    required this.startTime,
    required this.painLocation,
    required this.greatestSeverity,
    required this.isActive,
    required this.headacheRef,
    this.onUpdatePressed,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DateTime startTime;
  final String painLocation;
  final double greatestSeverity;
  final bool isActive;
  final DocumentReference headacheRef;
  final Future<dynamic> Function()? onUpdatePressed;

  @override
  _ActiveHeadacheCardState createState() => _ActiveHeadacheCardState();
}

class _ActiveHeadacheCardState extends State<ActiveHeadacheCard>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  Duration _elapsed = Duration.zero;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _updateElapsed();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (_) => _updateElapsed());
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  void _updateElapsed() {
    if (mounted) {
      setState(() {
        _elapsed = DateTime.now().difference(widget.startTime);
      });
    }
  }

  Future<void> _confirmAndDelete(BuildContext context) async {
    const redAccent = Color(0xFFEF4444);
    const textPrimary = Color(0xFFEFF2F7);
    const textMuted = Color(0xFF94A3B8);

    final confirmed = await showDialog<bool>(
      context: context,
      barrierColor: Colors.black.withOpacity(0.6),
      builder: (ctx) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E2E),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: redAccent.withOpacity(0.3), width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: redAccent.withOpacity(0.12),
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: redAccent.withOpacity(0.3), width: 1),
                ),
                child: const Icon(Icons.delete_outline_rounded,
                    color: redAccent, size: 24),
              ),
              const SizedBox(height: 16),
              const Text(
                'Delete Episode?',
                style: TextStyle(
                  color: textPrimary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This headache log will be permanently removed. This action cannot be undone.',
                textAlign: TextAlign.center,
                style: TextStyle(color: textMuted, fontSize: 13, height: 1.5),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.1), width: 1),
                        ),
                        child: const Text(
                          'Cancel',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: textMuted,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(ctx).pop(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: redAccent.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: redAccent.withOpacity(0.4), width: 1),
                        ),
                        child: const Text(
                          'Delete',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: redAccent,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    if (confirmed == true) {
      await widget.headacheRef.delete();
      FFAppState().ongoing = false;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  String _formatStartTime(DateTime dt) {
    final hour = dt.hour > 12
        ? dt.hour - 12
        : dt.hour == 0
            ? 12
            : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    final minute = dt.minute.toString().padLeft(2, '0');
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[dt.month - 1]} ${dt.day}, $hour:$minute $period';
  }

  String _severityLabel(double s) {
    if (s <= 2) return 'MINIMAL SEVERITY';
    if (s <= 4) return 'MILD SEVERITY';
    if (s <= 6) return 'MODERATE SEVERITY';
    if (s <= 8) return 'HIGH SEVERITY';
    return 'SEVERE';
  }

  Color _severityTextColor(double s) {
    if (s <= 2) return const Color(0xFF86EFAC);
    if (s <= 4) return const Color(0xFFBEF264);
    if (s <= 6) return const Color(0xFFFCD34D);
    if (s <= 8) return const Color(0xFFFCA5A5);
    return const Color(0xFFFECACA);
  }

  Color _severityBgColor(double s) {
    if (s <= 2) return const Color(0xFF14532D).withOpacity(0.5);
    if (s <= 4) return const Color(0xFF365314).withOpacity(0.5);
    if (s <= 6) return const Color(0xFF78350F).withOpacity(0.5);
    if (s <= 8) return const Color(0xFF7F1D1D).withOpacity(0.5);
    return const Color(0xFF450A0A).withOpacity(0.5);
  }

  Color _severityBorderColor(double s) {
    if (s <= 2) return const Color(0xFF22C55E).withOpacity(0.3);
    if (s <= 4) return const Color(0xFF84CC16).withOpacity(0.3);
    if (s <= 6) return const Color(0xFFF59E0B).withOpacity(0.3);
    if (s <= 8) return const Color(0xFFEF4444).withOpacity(0.3);
    return const Color(0xFFEF4444).withOpacity(0.4);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) return const SizedBox.shrink();

    const cardBg = Color(0xFF1A0F0F);
    const redAccent = Color(0xFFEF4444);
    const textPrimary = Color(0xFFEFF2F7);
    const textMuted = Color(0xFF64748B);
    const surfaceCard = Color(0x0AFFFFFF);
    const tealDuration = Color(0xFF34D399);

    return Container(
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: redAccent, width: 4)),
        boxShadow: [
          BoxShadow(
            color: redAccent.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header row ──────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left: pulsing dot + label
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 16 * _pulseAnimation.value,
                            height: 16 * _pulseAnimation.value,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: redAccent
                                  .withOpacity(0.3 / _pulseAnimation.value),
                            ),
                          ),
                          Container(
                            width: 9,
                            height: 9,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: redAccent,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'ACTIVE EPISODE',
                    style: TextStyle(
                      color: redAccent,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.08,
                    ),
                  ),
                ],
              ),
              // Right: IN PROGRESS label + trash icon
              Row(
                children: [
                  const Text(
                    'IN PROGRESS',
                    style: TextStyle(
                      color: textMuted,
                      fontSize: 10,
                      letterSpacing: 0.06,
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => _confirmAndDelete(context),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: redAccent.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: redAccent.withOpacity(0.2), width: 1),
                      ),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Color(0xFFFCA5A5),
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Severity badge + Location ────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: _severityBgColor(widget.greatestSeverity),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _severityBorderColor(widget.greatestSeverity),
                    width: 1,
                  ),
                ),
                child: Text(
                  _severityLabel(widget.greatestSeverity),
                  style: TextStyle(
                    color: _severityTextColor(widget.greatestSeverity),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.04,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 13, color: textMuted),
                  const SizedBox(width: 4),
                  Text(
                    widget.painLocation,
                    style: const TextStyle(color: textMuted, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Started / Duration cards ─────────────────────
          Row(
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: surfaceCard,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'STARTED',
                        style: TextStyle(
                          color: textMuted,
                          fontSize: 9,
                          letterSpacing: 0.07,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatStartTime(widget.startTime),
                        style: const TextStyle(
                          color: textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: surfaceCard,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'DURATION',
                        style: TextStyle(
                          color: textMuted,
                          fontSize: 9,
                          letterSpacing: 0.07,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDuration(_elapsed),
                        style: const TextStyle(
                          color: tealDuration,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // ── Update button (display only, no action) ──────
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: redAccent.withOpacity(0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: redAccent.withOpacity(0.25), width: 1),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_outlined, size: 14, color: Color(0xFFFCA5A5)),
                SizedBox(width: 7),
                Text(
                  'Update Episode Details',
                  style: TextStyle(
                    color: Color(0xFFFCA5A5),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
