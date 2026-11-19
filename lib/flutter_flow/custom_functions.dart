import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

int doubleToInt(double input) {
  return input.toInt();
}

DateTime? getStartofWeek() {
  DateTime now = DateTime.now();
  int weekday = now.weekday; // 1=Mon … 6=Sat, 7=Sun
  DateTime startOfWeek = DateTime(now.year, now.month, now.day)
      .subtract(Duration(days: weekday % 7)); // 7%7=0, 1%7=1, 6%7=6
  return startOfWeek;
}

String formatDuration(
  DateTime startTime,
  DateTime endTime,
) {
  Duration duration = endTime.difference(startTime);
  int hours = duration.inHours;
  int minutes = duration.inMinutes % 60;

  return '${hours}h ${minutes}m';
}

DateTime getWeekStartDate(DateTime referenceDate) {
  final int daysToSubtract = referenceDate.weekday % 7;
  return DateTime(
    referenceDate.year,
    referenceDate.month,
    referenceDate.day - daysToSubtract,
  );
}

DateTime getWeekEndDate(DateTime referenceDate) {
  final int daysToAdd = 6 - (referenceDate.weekday % 7);
  return DateTime(
    referenceDate.year,
    referenceDate.month,
    referenceDate.day + daysToAdd,
  );
}

List<DateTime> shiftWeekDates(
  DateTime start,
  DateTime end,
  int daysToAdd,
) {
  final newStart = start.add(Duration(days: daysToAdd));
  final newEnd = end.add(Duration(days: daysToAdd));
  return [newStart, newEnd];
}

int countHeadachesInRange(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  return headaches.where((h) {
    final startTime = h.startTime;
    return startTime != null && startTime.isBefore(weekEnd);
  }).length;
}

double averageSeverityInRange(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final filtered = headaches.where((h) {
    final startTime = h.startTime;
    return startTime != null && startTime.isBefore(weekEnd);
  }).toList();

  if (filtered.isEmpty) return 0.0;

  final totalSeverity =
      filtered.map((h) => h.greatestSeverity ?? 0.0).fold(0.0, (a, b) => a + b);

  final average = totalSeverity / filtered.length;

  return double.parse(average.toStringAsFixed(1));
}

String formattedTotalHeadacheDurationInRange(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final filtered = headaches.where((h) {
    final start = h.startTime;
    return start != null && start.isBefore(weekEnd);
  });

  int totalMinutes = 0;

  for (final h in filtered) {
    final start = h.startTime;
    final end = h.endTime;

    if (start != null && end != null && end.isAfter(start)) {
      final duration = end.difference(start).inMinutes;
      totalMinutes += duration;
    }
  }

  final hours = totalMinutes ~/ 60;
  final minutes = totalMinutes % 60;

  return '${hours}h ${minutes}m';
}

List<double> averageSeverityPerWeekday(
  List<HeadachesRecord> headaches,
  DateTime weekStart,
  DateTime weekEnd,
) {
  final totals = List<double>.filled(7, 0.0);
  final counts = List<int>.filled(7, 0);

  for (final h in headaches) {
    final time = h.startTime;
    if (time != null &&
        time.isAfter(weekStart.subtract(const Duration(seconds: 1))) &&
        time.isBefore(weekEnd)) {
      final weekday = time.weekday % 7; // Makes Sunday index 0, Monday 1, etc.
      totals[weekday] += h.greatestSeverity ?? 0.0;
      counts[weekday] += 1;
    }
  }

  return List<double>.generate(7, (i) {
    return counts[i] == 0 ? 0.0 : totals[i] / counts[i];
  });
}

List<String> weekdayLabels() {
  return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
}

String generateWeeklyAIPrompt(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final filtered = headaches.where((h) {
    final start = h.startTime;
    return start != null && start.isBefore(weekEnd);
  }).toList();

  final count = filtered.length;
  if (count == 0) {
    return 'No headaches were recorded this week.';
  }

  final buffer = StringBuffer();

  buffer.writeln(
    'The user logged $count headaches this week. Analyze the following data to identify patterns and return 3 short bullet-point health tips (1–2 sentences each). Be specific, no intro, no formatting, no special characters. Just 3 clear insights with one return between each.\n',
  );

  buffer.writeln('Headache entries:\n');

  for (int i = 0; i < count; i++) {
    final h = filtered[i];
    final start = h.startTime?.toIso8601String() ?? 'unknown';
    final end = h.endTime?.toIso8601String() ?? 'unknown';
    final severity = h.greatestSeverity?.toStringAsFixed(1) ?? 'unknown';
    final symptoms = h.symptoms?.join(', ') ?? 'none';
    final triggers = h.triggers?.join(', ') ?? 'none';
    final location = h.painLocation ?? 'unknown';
    final notes = h.notes ?? '';
    final medications = h.medications != null && h.medications!.isNotEmpty
        ? h.medications!
            .map((m) => m.name ?? '')
            .where((name) => name.isNotEmpty)
            .join(', ')
        : 'none';

    buffer.writeln(
        '${i + 1}. $start to $end, severity: $severity, symptoms: $symptoms, triggers: $triggers, location: $location, medications: $medications, notes: $notes');
  }

  buffer.writeln(
    '\nFocus on helpful tips regarding symptoms, triggers, timing, medication patterns, or lifestyle. Keep each tip short and meaningful.',
  );

  return buffer.toString();
}

List<String> countWeeklySymptoms(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final Map<String, int> symptomCount = {};

  for (final h in headaches) {
    final start = h.startTime;
    if (start != null && start.isBefore(weekEnd)) {
      final symptoms = h.symptoms ?? [];
      for (final symptom in symptoms) {
        symptomCount[symptom] = (symptomCount[symptom] ?? 0) + 1;
      }
    }
  }

  return symptomCount.entries
      .map((entry) => '${entry.key} (${entry.value})')
      .toList();
}

List<String> countWeeklyTriggers(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final Map<String, int> triggerCount = {};

  for (final h in headaches) {
    final start = h.startTime;
    if (start != null && start.isBefore(weekEnd)) {
      final triggers = h.triggers ?? [];
      for (final trigger in triggers) {
        triggerCount[trigger] = (triggerCount[trigger] ?? 0) + 1;
      }
    }
  }

  return triggerCount.entries
      .map((entry) => '${entry.key} (${entry.value})')
      .toList();
}

List<String> formattedMedicationList(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final Set<String> meds = {};

  for (final h in headaches) {
    final start = h.startTime;
    if (start != null && start.isBefore(weekEnd)) {
      final medEntries = h.medications ?? [];
      for (final med in medEntries) {
        final name = med.name ?? '';
        final dosage = med.dosage ?? '';
        if (name.isNotEmpty || dosage.isNotEmpty) {
          meds.add('$name $dosage'.trim());
        }
      }
    }
  }

  return meds.toList();
}

List<String> formattedLocationList(
  List<HeadachesRecord> headaches,
  DateTime weekEnd,
) {
  final Map<String, int> locationCount = {};

  for (final h in headaches) {
    final start = h.startTime;
    if (start != null && start.isBefore(weekEnd)) {
      final location = h.painLocation?.trim();
      if (location != null && location.isNotEmpty) {
        locationCount[location] = (locationCount[location] ?? 0) + 1;
      }
    }
  }

  return locationCount.entries
      .map((entry) => '${entry.key} (${entry.value})')
      .toList();
}

List<DateTime> getHeadacheDates(List<HeadachesRecord> headaches) {
  final dates = <DateTime>[];

  for (final headache in headaches) {
    final date = headache.startTime;
    if (date != null) {
      // Normalize to just the date (remove time part)
      final normalized = DateTime(date.year, date.month, date.day);
      if (!dates.contains(normalized)) {
        dates.add(normalized);
      }
    }
  }

  return dates;
}

DateTime getStartOfDay(DateTime inputDate) {
  return DateTime(inputDate.year, inputDate.month, inputDate.day);
}

List<HeadachesRecord> filterHeadachesByDay(
  List<HeadachesRecord> headaches,
  DateTime selectedDate,
) {
  final endOfDay =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day)
          .add(const Duration(days: 1))
          .subtract(const Duration(milliseconds: 1));

  return headaches.where((h) {
    final startTime = h.startTime;
    if (startTime == null) return false;
    return startTime.isBefore(endOfDay.add(const Duration(milliseconds: 1)));
  }).toList();
}

List<HeadachesRecord> filterHeadachesForDay(
  List<HeadachesRecord> headaches,
  DateTime selectedDate,
) {
  final startOfDay =
      DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
  final endOfDay = startOfDay
      .add(const Duration(days: 1))
      .subtract(const Duration(milliseconds: 1));

  return headaches.where((h) {
    final startTime = h.startTime;
    if (startTime == null) return false;
    return startTime
            .isAfter(startOfDay.subtract(const Duration(milliseconds: 1))) &&
        startTime.isBefore(endOfDay.add(const Duration(milliseconds: 1)));
  }).toList();
}

String formatMedicationEntry(MedicationEntryStruct medication) {
  final name = medication.name ?? 'Unknown';
  final dosage = medication.dosage ?? '';
  return '$name $dosage'.trim();
}

String severityLabel(double severity) {
  if (severity <= 2) {
    return 'MINIMAL SEVERITY';
  } else if (severity <= 4) {
    return 'MILD SEVERITY';
  } else if (severity <= 6) {
    return 'MODERATE SEVERITY';
  } else if (severity <= 8) {
    return 'HIGH SEVERITY';
  } else {
    return 'SEVERE';
  }
}

String? generateTrendsPrompt(
  List<HeadachesRecord> headaches,
  bool userSex,
  DateTime userBirthday,
) {
  if (headaches.isEmpty) {
    return 'No headache data is available to analyze.';
  }

  // ── Patient info ────────────────────────────────────────
  final sex = userSex == true ? 'Male' : 'Female';
  int age = 0;
  final now = DateTime.now();
  age = now.year - userBirthday.year;
  if (now.month < userBirthday.month ||
      (now.month == userBirthday.month && now.day < userBirthday.day)) {
    age--;
  }

  final completed =
      headaches.where((h) => !h.ongoing && h.endTime != null).toList();

  // ── Trigger frequency ───────────────────────────────────
  final triggerMap = <String, int>{};
  for (final h in headaches) {
    for (final t in h.triggers) {
      triggerMap[t] = (triggerMap[t] ?? 0) + 1;
    }
  }
  final sortedTriggers = triggerMap.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // ── Symptom frequency ───────────────────────────────────
  final symptomMap = <String, int>{};
  for (final h in headaches) {
    for (final s in h.symptoms) {
      symptomMap[s] = (symptomMap[s] ?? 0) + 1;
    }
  }
  final sortedSymptoms = symptomMap.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // ── Avg severity ────────────────────────────────────────
  final avgSeverity =
      headaches.fold<double>(0, (s, h) => s + (h.greatestSeverity ?? 0)) /
          headaches.length;

  // ── Avg duration ────────────────────────────────────────
  final avgDurationMin = completed.isEmpty
      ? 0.0
      : completed.fold<double>(
              0, (s, h) => s + h.endTime!.difference(h.startTime!).inMinutes) /
          completed.length;

  // ── Medication effectiveness ────────────────────────────
  final medMap = <String, List<double>>{};
  final noMedDurations = <double>[];
  for (final h in completed) {
    final durMin = h.endTime!.difference(h.startTime!).inMinutes.toDouble();
    if (h.medications.isEmpty) {
      noMedDurations.add(durMin);
    } else {
      for (final m in h.medications) {
        medMap.putIfAbsent(m.name, () => []).add(durMin);
      }
    }
  }
  final avgNoMed = noMedDurations.isEmpty
      ? null
      : noMedDurations.reduce((a, b) => a + b) / noMedDurations.length;

  // ── Time-of-day distribution ────────────────────────────
  int morning = 0, afternoon = 0, evening = 0, night = 0;
  for (final h in headaches) {
    if (h.startTime == null) continue;
    final hour = h.startTime!.hour;
    if (hour >= 5 && hour < 12)
      morning++;
    else if (hour >= 12 && hour < 17)
      afternoon++;
    else if (hour >= 17 && hour < 21)
      evening++;
    else
      night++;
  }

  // ── Day-of-week distribution ────────────────────────────
  final dowMap = <int, int>{};
  for (final h in headaches) {
    if (h.startTime == null) continue;
    final dow = h.startTime!.weekday;
    dowMap[dow] = (dowMap[dow] ?? 0) + 1;
  }
  final dowNames = {
    1: 'Mon',
    2: 'Tue',
    3: 'Wed',
    4: 'Thu',
    5: 'Fri',
    6: 'Sat',
    7: 'Sun'
  };
  final sortedDow = dowMap.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));

  // ── Duration formatter ──────────────────────────────────
  String fmtDur(double minutes) {
    final h = (minutes / 60).floor();
    final m = (minutes % 60).round();
    return h > 0 ? '${h}h ${m}m' : '${m}m';
  }

  // ── Build prompt ────────────────────────────────────────
  final buf = StringBuffer();

  buf.writeln('PATIENT PROFILE');
  buf.writeln(
      'Age: $age | Sex: $sex | Total episodes: ${headaches.length} | Completed episodes: ${completed.length}');
  buf.writeln('Average severity: ${avgSeverity.toStringAsFixed(1)}/10');
  if (avgDurationMin > 0) {
    buf.writeln('Average duration: ${fmtDur(avgDurationMin)}');
  }
  buf.writeln();

  if (sortedTriggers.isNotEmpty) {
    buf.writeln('TRIGGER FREQUENCY (out of ${headaches.length} episodes)');
    for (final e in sortedTriggers.take(8)) {
      final pct = (e.value / headaches.length * 100).round();
      buf.writeln('- ${e.key}: ${e.value}x ($pct%)');
    }
    buf.writeln();
  }

  if (sortedSymptoms.isNotEmpty) {
    buf.writeln('SYMPTOM FREQUENCY');
    for (final e in sortedSymptoms.take(8)) {
      final pct = (e.value / headaches.length * 100).round();
      buf.writeln('- ${e.key}: ${e.value}x ($pct%)');
    }
    buf.writeln();
  }

  if (medMap.isNotEmpty) {
    buf.writeln('MEDICATION DATA (avg episode duration with that med)');
    for (final e in medMap.entries) {
      final avg = e.value.reduce((a, b) => a + b) / e.value.length;
      buf.writeln('- ${e.key} (${e.value.length} uses): avg ${fmtDur(avg)}');
    }
    if (avgNoMed != null) {
      buf.writeln(
          '- No medication (${noMedDurations.length} episodes): avg ${fmtDur(avgNoMed)}');
    }
    buf.writeln();
  }

  buf.writeln('TIMING PATTERNS');
  buf.writeln(
      'Time of day: Morning $morning, Afternoon $afternoon, Evening $evening, Night $night');
  if (sortedDow.isNotEmpty) {
    final topDow = sortedDow
        .take(3)
        .map((e) => '${dowNames[e.key]} (${e.value})')
        .join(', ');
    buf.writeln('Most frequent days: $topDow');
  }
  buf.writeln();

  buf.writeln('RAW EPISODE LOG');
  for (int i = 0; i < headaches.length; i++) {
    final h = headaches[i];
    final start = h.startTime != null
        ? '${h.startTime!.month}/${h.startTime!.day} ${h.startTime!.hour}:${h.startTime!.minute.toString().padLeft(2, '0')}'
        : 'unknown';
    final dur = (h.endTime != null && h.startTime != null)
        ? '${h.endTime!.difference(h.startTime!).inMinutes}min'
        : h.ongoing
            ? 'ongoing'
            : 'unknown';
    final sev = h.greatestSeverity?.toStringAsFixed(0) ?? '?';
    final trigs = h.triggers.isEmpty ? 'none' : h.triggers.join(', ');
    final syms = h.symptoms.isEmpty ? 'none' : h.symptoms.join(', ');
    final meds = h.medications.isEmpty
        ? 'none'
        : h.medications.map((m) => '${m.name} ${m.dosage}').join(', ');
    final loc = h.painLocation ?? 'unknown';
    buf.writeln(
        '${i + 1}. $start | sev:$sev | dur:$dur | loc:$loc | triggers:[$trigs] | symptoms:[$syms] | meds:[$meds]');
  }

  buf.writeln();
  buf.writeln('INSTRUCTIONS');
  buf.writeln(
      'You are analyzing clinical headache data for a $age-year-old $sex patient. Based on all data above, return exactly 3 bullet-point insights. Each bullet must:');
  buf.writeln(
      '- Start with a bold clinical finding (e.g. a specific trigger correlation, medication pattern, or timing cluster)');
  buf.writeln(
      '- Include the specific number or percentage that supports the finding');
  buf.writeln('- End with a practical, actionable implication for the patient');
  buf.writeln('- Be separated by a single blank line');
  buf.writeln(
      'No headings, no preamble, no conclusion. Just the 3 bullets. Be bold and specific — avoid generic observations. Do not use any markdown formatting. No asterisks, no bold, no bullet symbols. Plain text only.');

  return buf.toString();
}
