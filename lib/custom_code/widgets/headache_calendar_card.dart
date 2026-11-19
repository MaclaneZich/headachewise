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

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'index.dart';

class HeadacheCalendarCard extends StatelessWidget {
  const HeadacheCalendarCard({
    Key? key,
    this.width,
    this.height,
    required this.headachesRecord,
  }) : super(key: key);

  final double? width;
  final double? height;
  final HeadachesRecord headachesRecord;

  static const _cardBg = Color(0xFF131929);
  static const _surfaceBg = Color(0xFF0D1128);
  static const _indigo = Color(0xFF6366F1);
  static const _textPrimary = Color(0xFFEFF2F7);
  static const _textMuted = Color(0xFF64748B);
  static const _teal = Color(0xFF34D399);

  String _severityLabel(double s) {
    if (s <= 2) return 'MINIMAL';
    if (s <= 4) return 'MILD';
    if (s <= 6) return 'MODERATE';
    if (s <= 8) return 'HIGH';
    return 'SEVERE';
  }

  Color _severityColor(double s) {
    if (s <= 2) return const Color(0xFF34D399);
    if (s <= 4) return const Color(0xFFFBBF24);
    if (s <= 6) return const Color(0xFFF97316);
    if (s <= 8) return const Color(0xFFEF4444);
    return const Color(0xFFFF0000);
  }

  Color _severityBgColor(double s) {
    if (s <= 2) return const Color(0xFF14532D).withOpacity(0.5);
    if (s <= 4) return const Color(0xFF78350F).withOpacity(0.5);
    if (s <= 6) return const Color(0xFF7C2D12).withOpacity(0.5);
    if (s <= 8) return const Color(0xFF7F1D1D).withOpacity(0.5);
    return const Color(0xFF450A0A).withOpacity(0.6);
  }

  String _formatTime(DateTime? dt) {
    if (dt == null) return 'N/A';
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

  String _formatDuration(DateTime? start, DateTime? end) {
    if (start == null) return 'N/A';
    final finish = end ?? DateTime.now();
    final diff = finish.difference(start);
    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  Widget _chip(String label) {
    return Container(
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _indigo.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _indigo.withOpacity(0.35), width: 1),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Color(0xFFB8BFFF),
          fontSize: 11,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  Widget _sectionLabel(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, color: _indigo, size: 13),
          const SizedBox(width: 5),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF818CF8),
              fontSize: 10,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final severity = headachesRecord.greatestSeverity ?? 5.0;
    final isOngoing = headachesRecord.ongoing;
    final hasTriggers = headachesRecord.triggers.isNotEmpty;
    final hasSymptoms = headachesRecord.symptoms.isNotEmpty;
    final sevColor = _severityColor(severity);

    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _indigo.withOpacity(0.15), width: 1),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Subtle top-right glow accent
            Positioned(
              top: -30,
              right: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: sevColor.withOpacity(0.06),
                ),
              ),
            ),

            // Left severity accent bar
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Container(
                width: 3,
                decoration: BoxDecoration(
                  color: sevColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
              ),
            ),

            // Card content
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Header row ──────────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Severity badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        decoration: BoxDecoration(
                          color: _severityBgColor(severity),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: sevColor.withOpacity(0.45), width: 1),
                        ),
                        child: Text(
                          _severityLabel(severity),
                          style: TextStyle(
                            color: sevColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.06,
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          // Ongoing badge
                          if (isOngoing) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color:
                                    const Color(0xFFEF4444).withOpacity(0.12),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: const Color(0xFFEF4444)
                                        .withOpacity(0.35),
                                    width: 1),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.circle,
                                      color: Color(0xFFEF4444), size: 6),
                                  SizedBox(width: 4),
                                  Text(
                                    'LIVE',
                                    style: TextStyle(
                                      color: Color(0xFFFCA5A5),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.08,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],
                          // Location
                          if (headachesRecord.painLocation?.isNotEmpty ==
                              true) ...[
                            const Icon(Icons.location_on_rounded,
                                color: Color(0xFF6366F1), size: 13),
                            const SizedBox(width: 3),
                            Text(
                              headachesRecord.painLocation!,
                              style: const TextStyle(
                                  color: Color(0xFF94A3B8), fontSize: 12),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 14),

                  // ── Time row ─────────────────────────────────
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        // Start
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: _surfaceBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04),
                                  width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Icon(Icons.play_arrow_rounded,
                                        color: Color(0xFF6366F1), size: 12),
                                    SizedBox(width: 4),
                                    Text('STARTED',
                                        style: TextStyle(
                                            color: Color(0xFF64748B),
                                            fontSize: 9,
                                            letterSpacing: 0.07,
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  _formatTime(headachesRecord.startTime),
                                  style: const TextStyle(
                                      color: _textPrimary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        // End / duration
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: _surfaceBg,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.white.withOpacity(0.04),
                                  width: 1),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      isOngoing
                                          ? Icons.timer_outlined
                                          : Icons.stop_rounded,
                                      color: isOngoing
                                          ? _teal
                                          : const Color(0xFF64748B),
                                      size: 12,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      isOngoing ? 'DURATION' : 'ENDED',
                                      style: const TextStyle(
                                          color: Color(0xFF64748B),
                                          fontSize: 9,
                                          letterSpacing: 0.07,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  isOngoing
                                      ? _formatDuration(
                                          headachesRecord.startTime, null)
                                      : _formatTime(headachesRecord.endTime),
                                  style: TextStyle(
                                    color: isOngoing ? _teal : _textPrimary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Duration pill — only when ended
                        if (!isOngoing) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                              color: _teal.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: _teal.withOpacity(0.3), width: 1),
                            ),
                            child: Text(
                              _formatDuration(headachesRecord.startTime,
                                  headachesRecord.endTime),
                              style: const TextStyle(
                                  color: _teal,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  // ── Triggers ──────────────────────────────────
                  if (hasTriggers) ...[
                    const SizedBox(height: 14),
                    _sectionLabel('TRIGGERS', Icons.bolt_rounded),
                    Wrap(
                        children: headachesRecord.triggers
                            .map((t) => _chip(t))
                            .toList()),
                  ],

                  // ── Symptoms ──────────────────────────────────
                  if (hasSymptoms) ...[
                    const SizedBox(height: 4),
                    _sectionLabel('SYMPTOMS', Icons.shield_rounded),
                    Wrap(
                        children: headachesRecord.symptoms
                            .map((s) => _chip(s))
                            .toList()),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
