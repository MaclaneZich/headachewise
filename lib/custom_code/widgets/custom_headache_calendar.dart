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

import 'index.dart'; // Imports other custom widgets

import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class CustomHeadacheCalendar extends StatefulWidget {
  const CustomHeadacheCalendar({
    Key? key,
    this.width,
    this.height,
    required this.selectedDate,
    required this.markedDates,
    required this.headacheList,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DateTime selectedDate;
  final List<DateTime> markedDates;
  final List<HeadachesRecord> headacheList;

  @override
  _CustomHeadacheCalendarState createState() => _CustomHeadacheCalendarState();
}

class _CustomHeadacheCalendarState extends State<CustomHeadacheCalendar> {
  late DateTime _focusedMonth;

  // Colors
  static const _navyBg = Color(0xFF0D1128);
  static const _cardBg = Color(0xFF1E2440);
  static const _indigo = Color(0xFF6366F1);
  static const _textMuted = Color(0xFF64748B);
  static const _textPrimary = Color(0xFFEFF2F7);

  @override
  void initState() {
    super.initState();
    _focusedMonth =
        DateTime(widget.selectedDate.year, widget.selectedDate.month);
  }

  // Severity color — encodes clinical meaning, not decoration
  Color getSeverityColor(double severity) {
    if (severity >= 9) return const Color(0xFFEF4444); // red
    if (severity >= 6) return const Color(0xFFF97316); // orange
    if (severity >= 3) return const Color(0xFFFBBF24); // amber
    return const Color(0xFF34D399); // teal/green
  }

  List<Widget> _buildCalendarDays(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateUtils.getDaysInMonth(month.year, month.month);
    final totalCells = ((firstWeekday - 1) + daysInMonth);

    return List.generate(totalCells, (index) {
      if (index < firstWeekday - 1) {
        return const SizedBox();
      }
      final day = index - (firstWeekday - 2);
      final currentDate = DateTime(month.year, month.month, day);
      final isMarked = widget.markedDates.any((d) => isSameDay(d, currentDate));
      final isSelected = isSameDay(currentDate, widget.selectedDate);
      final isToday = isSameDay(currentDate, DateTime.now());

      final matchingHeadache = widget.headacheList.firstWhereOrNull(
        (h) => h.startTime != null && isSameDay(h.startTime!, currentDate),
      );

      Color? dotColor;
      if (matchingHeadache != null &&
          matchingHeadache.greatestSeverity != null) {
        dotColor = getSeverityColor(matchingHeadache.greatestSeverity!);
      }

      return GestureDetector(
        onTap: () async {
          FFAppState().update(() {
            FFAppState().selectedDate = currentDate;
          });
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: isSelected
                ? _indigo
                : isToday
                    ? _indigo.withOpacity(0.15)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: isToday && !isSelected
                ? Border.all(color: _indigo.withOpacity(0.4), width: 1)
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$day',
                style: TextStyle(
                  color: isSelected ? Colors.white : _textPrimary,
                  fontWeight:
                      isSelected || isToday ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 3),
              // Always reserve dot space to keep rows aligned
              SizedBox(
                height: 6,
                child: dotColor != null
                    ? Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.white.withOpacity(0.9)
                              : dotColor,
                          shape: BoxShape.circle,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double weekdayFontSize;
    if (screenWidth <= 400) {
      weekdayFontSize = 11;
    } else if (screenWidth < 768) {
      weekdayFontSize = 12;
    } else {
      weekdayFontSize = 14;
    }

    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _indigo.withOpacity(0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 8),
      child: Column(
        children: [
          // Month navigation
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedMonth =
                        DateTime(_focusedMonth.year, _focusedMonth.month - 1);
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _navyBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.chevron_left_rounded,
                    color: _indigo,
                    size: 20,
                  ),
                ),
              ),
              Text(
                DateFormat.yMMMM().format(_focusedMonth),
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: _textPrimary,
                  letterSpacing: 0.3,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _focusedMonth =
                        DateTime(_focusedMonth.year, _focusedMonth.month + 1);
                  });
                },
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: _navyBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.chevron_right_rounded,
                    color: _indigo,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Divider
          Container(
            height: 1,
            color: _indigo.withOpacity(0.1),
          ),

          const SizedBox(height: 10),

          // Weekday labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: weekdays
                .map((day) => Expanded(
                      child: Center(
                        child: Text(
                          day,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: day == 'Sat' || day == 'Sun'
                                ? _textMuted
                                : _textMuted,
                            fontSize: weekdayFontSize,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ))
                .toList(),
          ),

          const SizedBox(height: 6),

          // Calendar Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 7,
              physics: const NeverScrollableScrollPhysics(),
              children: _buildCalendarDays(_focusedMonth),
            ),
          ),

          // Severity legend
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _legendDot(const Color(0xFF34D399), 'Mild'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFFBBF24), 'Moderate'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFF97316), 'High'),
                const SizedBox(width: 12),
                _legendDot(const Color(0xFFEF4444), 'Severe'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _legendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF475569),
            fontSize: 10,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}
