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

class TriggerCombination {
  final List<String> triggers;
  final int episodeCount;
  final double avgSeverity;
  final double avgDurationMin;
  final double compositeScore;

  const TriggerCombination({
    required this.triggers,
    required this.episodeCount,
    required this.avgSeverity,
    required this.avgDurationMin,
    required this.compositeScore,
  });

  String get label => triggers.join(' + ');
  bool get isTriple => triggers.length == 3;
}

class HeadacheAnalysisWidget extends StatelessWidget {
  const HeadacheAnalysisWidget({
    Key? key,
    this.width,
    this.height,
    required this.headacheList,
    this.aiAnalysisResult,
    this.isLoading,
    this.researchMode,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<HeadachesRecord> headacheList;
  final String? aiAnalysisResult;
  final bool? isLoading;
  final bool? researchMode;

  // ── Design tokens ─────────────────────────────────────────
  static const _navy = Color(0xFF0D1128);
  static const _cardBg = Color(0xFF1E2440);
  static const _surface = Color(0xFF131929);
  static const _indigo = Color(0xFF6366F1);
  static const _indigoL = Color(0xFF818CF8);
  static const _teal = Color(0xFF34D399);
  static const _text = Color(0xFFEFF2F7);
  static const _muted = Color(0xFF64748B);
  static const _amber = Color(0xFFFBBF24);

  // ── Computed stats ────────────────────────────────────────

  int get _episodeCount => headacheList.length;

  // Trigger frequency map
  Map<String, int> get _triggerFrequency {
    final map = <String, int>{};
    for (final h in headacheList) {
      for (final t in h.triggers) {
        map[t] = (map[t] ?? 0) + 1;
      }
    }
    final sorted = Map.fromEntries(
      map.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
    return sorted;
  }

  // Symptom frequency map
  Map<String, int> get _symptomFrequency {
    final map = <String, int>{};
    for (final h in headacheList) {
      for (final s in h.symptoms) {
        map[s] = (map[s] ?? 0) + 1;
      }
    }
    final sorted = Map.fromEntries(
      map.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
    return sorted;
  }

  // Average severity
  double get _avgSeverity {
    if (headacheList.isEmpty) return 0;
    final total = headacheList.fold<double>(
        0, (sum, h) => sum + (h.greatestSeverity ?? 0));
    return total / headacheList.length;
  }

  // Average duration in minutes
  double get _avgDurationMinutes {
    final completed =
        headacheList.where((h) => !h.ongoing && h.endTime != null).toList();
    if (completed.isEmpty) return 0;
    final totalMin = completed.fold<double>(0, (sum, h) {
      final diff = h.endTime!.difference(h.startTime!).inMinutes;
      return sum + diff;
    });
    return totalMin / completed.length;
  }

  // Medication effectiveness: avg duration with vs without each med
  Map<String, Map<String, double>> get _medicationEffectiveness {
    final result = <String, Map<String, double>>{};
    final completed =
        headacheList.where((h) => !h.ongoing && h.endTime != null).toList();
    if (completed.isEmpty) return result;

    // Collect all unique med names
    final allMeds = <String>{};
    for (final h in completed) {
      for (final m in h.medications) {
        allMeds.add(m.name);
      }
    }

    for (final med in allMeds) {
      final withMed = completed
          .where((h) => h.medications.any((m) => m.name == med))
          .toList();
      final withoutMed = completed
          .where((h) => !h.medications.any((m) => m.name == med))
          .toList();

      if (withMed.isEmpty) continue;

      final avgWith = withMed.fold<double>(
              0, (s, h) => s + h.endTime!.difference(h.startTime!).inMinutes) /
          withMed.length;

      final avgWithout = withoutMed.isEmpty
          ? 0.0
          : withoutMed.fold<double>(0,
                  (s, h) => s + h.endTime!.difference(h.startTime!).inMinutes) /
              withoutMed.length;

      result[med] = {
        'with': avgWith,
        'without': avgWithout,
        'count': withMed.length.toDouble(),
      };
    }

    // Sort by effectiveness (biggest reduction first)
    final sorted = Map.fromEntries(
      result.entries.toList()
        ..sort((a, b) {
          final aReduction = (a.value['without'] ?? 0) - (a.value['with'] ?? 0);
          final bReduction = (b.value['without'] ?? 0) - (b.value['with'] ?? 0);
          return bReduction.compareTo(aReduction);
        }),
    );
    return sorted;
  }

  // Trigger combination correlations (pairs + triples).
  // researchMode=false → min-max composite (60% severity, 40% duration), range [0,1].
  // researchMode=true  → lift score (see inline math), range [0, ∞), typically [0.5, 2].
  List<TriggerCombination> _triggerCombinations({bool researchMode = false}) {
    if (headacheList.length < 10) return [];

    final eligible = headacheList.where((h) => h.triggers.length >= 2).toList();
    if (eligible.isEmpty) return [];

    final accumSev = <String, List<double>>{};
    final accumDur = <String, List<double>>{};
    final keyTriggers = <String, List<String>>{};

    for (final h in eligible) {
      final ts = (h.triggers.toList()..sort());
      final sev = (h.greatestSeverity ?? 0).toDouble();
      final durMin = (!h.ongoing && h.endTime != null && h.startTime != null)
          ? h.endTime!.difference(h.startTime!).inMinutes.toDouble()
          : null;

      void add(List<String> combo) {
        final key = combo.join('|');
        keyTriggers[key] = combo;
        (accumSev[key] ??= []).add(sev);
        if (durMin != null) (accumDur[key] ??= []).add(durMin);
      }

      for (int i = 0; i < ts.length; i++) {
        for (int j = i + 1; j < ts.length; j++) {
          add([ts[i], ts[j]]);
          for (int k = j + 1; k < ts.length; k++) {
            add([ts[i], ts[j], ts[k]]);
          }
        }
      }
    }

    final validKeys =
        accumSev.keys.where((k) => accumSev[k]!.length >= 2).toList();
    if (validKeys.isEmpty) return [];

    double listAvg(List<double> l) => l.fold(0.0, (a, b) => a + b) / l.length;

    final avgSevMap = {for (final k in validKeys) k: listAvg(accumSev[k]!)};
    final avgDurMap = {
      for (final k in validKeys)
        k: (accumDur[k]?.isNotEmpty == true) ? listAvg(accumDur[k]!) : 0.0,
    };

    late final List<TriggerCombination> combos;

    if (!researchMode) {
      // ── Standard: min-max composite ──────────────────────────────────────
      // Rank by weighted average of normalized severity and duration.
      //   normSev = μ_combo_sev / max(μ_combo_sev across all combos)  ∈ [0,1]
      //   normDur = μ_combo_dur / max(μ_combo_dur across all combos)  ∈ [0,1]
      //   compositeScore = 0.6·normSev + 0.4·normDur                  ∈ [0,1]
      // Limitation: scores are relative to this dataset only; a score of 0.9
      // means "worst in your history", not "clinically severe".
      final maxSev = avgSevMap.values.fold(0.0, (m, v) => v > m ? v : m);
      final maxDur = avgDurMap.values.fold(0.0, (m, v) => v > m ? v : m);

      combos = validKeys.map((key) {
        final avgSev = avgSevMap[key]!;
        final avgDur = avgDurMap[key]!;
        final normSev = maxSev > 0 ? avgSev / maxSev : 0.0;
        final normDur = maxDur > 0 ? avgDur / maxDur : 0.0;
        return TriggerCombination(
          triggers: keyTriggers[key]!,
          episodeCount: accumSev[key]!.length,
          avgSeverity: avgSev,
          avgDurationMin: avgDur,
          compositeScore: normSev * 0.6 + normDur * 0.4,
        );
      }).toList();
    } else {
      // ── Research: severity lift ───────────────────────────────────────────
      //
      // Model: treat each trigger as a multiplicative severity factor over the
      // global mean. Under independence, co-occurring triggers compound as:
      //
      //   factor(X) = μ(X) / μ_global
      //
      //   predicted_sev(A,B)   = μ_global · factor(A) · factor(B)
      //                        = (μ(A) · μ(B)) / μ_global
      //
      //   predicted_sev(A,B,C) = μ_global · factor(A) · factor(B) · factor(C)
      //                        = (μ(A) · μ(B) · μ(C)) / μ_global²
      //
      // General for n triggers:
      //   predicted = ∏ μ(Xᵢ) / μ_global^(n−1)
      //
      // Lift = observed / predicted:
      //   lift(A,B)   = (μ_combo · μ_global)   / (μ(A) · μ(B))
      //   lift(A,B,C) = (μ_combo · μ_global²)  / (μ(A) · μ(B) · μ(C))
      //
      // General: lift = μ_combo · μ_global^(n−1) / ∏ μ(Xᵢ)
      //
      // Interpretation:
      //   lift > 1 → synergistic: combo is worse than independence predicts
      //   lift = 1 → independent: individual trigger rates fully explain severity
      //   lift < 1 → antagonistic: combo is milder than independence predicts

      // μ_global: mean severity across all eligible (2+ trigger) episodes
      final globalAvgSev = listAvg(
        eligible.map((h) => (h.greatestSeverity ?? 0).toDouble()).toList(),
      );

      // μ(X): mean severity of every eligible episode that contains trigger X
      final singleAccum = <String, List<double>>{};
      for (final h in eligible) {
        final sev = (h.greatestSeverity ?? 0).toDouble();
        for (final t in h.triggers) {
          (singleAccum[t] ??= []).add(sev);
        }
      }
      final singleAvgSev = {
        for (final e in singleAccum.entries) e.key: listAvg(e.value),
      };

      combos = validKeys.map((key) {
        final triggers = keyTriggers[key]!;
        final comboAvgSev = avgSevMap[key]!;

        // ∏ μ(Xᵢ) — product of individual trigger means
        final triggerMeanProduct = triggers.fold(
          1.0,
          (prod, t) => prod * (singleAvgSev[t] ?? globalAvgSev),
        );

        // μ_global^(n−1): ¹ for pairs, ² for triples (only pairs/triples exist here)
        final globalPow =
            triggers.length == 3 ? globalAvgSev * globalAvgSev : globalAvgSev;

        // lift = μ_combo · μ_global^(n−1) / ∏ μ(Xᵢ)
        final lift = triggerMeanProduct > 0
            ? (comboAvgSev * globalPow) / triggerMeanProduct
            : 1.0;

        return TriggerCombination(
          triggers: triggers,
          episodeCount: accumSev[key]!.length,
          avgSeverity: comboAvgSev,
          avgDurationMin: avgDurMap[key]!,
          compositeScore: lift,
        );
      }).toList();
    }

    combos.sort((a, b) => b.compositeScore.compareTo(a.compositeScore));
    return combos;
  }

  // ── Helpers ───────────────────────────────────────────────

  String _formatDuration(double minutes) {
    if (minutes <= 0) return 'N/A';
    final h = (minutes / 60).floor();
    final m = (minutes % 60).round();
    if (h > 0) return '${h}h ${m}m';
    return '${m}m';
  }

  Color _severityColor(double s) {
    if (s <= 2) return _teal;
    if (s <= 4) return _amber;
    if (s <= 6) return const Color(0xFFF97316);
    if (s <= 8) return const Color(0xFFEF4444);
    return const Color(0xFFFF0000);
  }

  // ── Section header ────────────────────────────────────────
  Widget _sectionHeader(String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: _indigoL, size: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: _indigoL,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }

  // ── Card wrapper ──────────────────────────────────────────
  Widget _cardWrap({required Widget child, EdgeInsets? padding}) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _indigo.withOpacity(0.15), width: 1),
      ),
      child: child,
    );
  }

  // ── Episode progress card ─────────────────────────────────
  Widget _buildProgressCard() {
    const aiTarget = 15;
    const predictionTarget = 30;
    final count = _episodeCount;
    final aiUnlocked = count >= aiTarget;
    final predictionUnlocked = count >= predictionTarget;

    // Progress toward next milestone
    final activeTarget = aiUnlocked ? predictionTarget : aiTarget;
    final activeCount = count.clamp(0, activeTarget);
    final progress = activeCount / activeTarget;
    final remaining = (activeTarget - count).clamp(0, activeTarget);

    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Research Progress',
                style: TextStyle(
                  color: _text,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: predictionUnlocked
                      ? _teal.withOpacity(0.15)
                      : _indigo.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: predictionUnlocked
                        ? _teal.withOpacity(0.4)
                        : _indigo.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: Text(
                  '$count episodes',
                  style: TextStyle(
                    color: predictionUnlocked ? _teal : _indigoL,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // AI Insights milestone
          _milestoneRow(
            label: 'AI Insights',
            description: 'Pattern analysis & personalized insights',
            target: aiTarget,
            count: count,
            unlocked: aiUnlocked,
          ),
          const SizedBox(height: 10),

          // Research milestone
          _milestoneRow(
            label: 'Research Contribution',
            description:
                'Your data contributes to understanding migraine onset and the potential to predict episodes before they happen.',
            target: predictionTarget,
            count: count,
            unlocked: predictionUnlocked,
          ),

          if (!predictionUnlocked) ...[
            const SizedBox(height: 14),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: _navy,
                valueColor: AlwaysStoppedAnimation<Color>(
                  aiUnlocked ? _teal : _indigo,
                ),
                minHeight: 5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              aiUnlocked
                  ? 'Log $remaining more episodes to unlock prediction modeling.'
                  : 'Log $remaining more episodes to unlock AI insights.',
              style: const TextStyle(color: _muted, fontSize: 11),
            ),
          ],
        ],
      ),
    );
  }

  Widget _milestoneRow({
    required String label,
    required String description,
    required int target,
    required int count,
    required bool unlocked,
  }) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: unlocked ? _teal.withOpacity(0.15) : _navy,
            shape: BoxShape.circle,
            border: Border.all(
              color:
                  unlocked ? _teal.withOpacity(0.5) : _indigo.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Icon(
            unlocked ? Icons.check_rounded : Icons.lock_outline_rounded,
            color: unlocked ? _teal : _muted,
            size: 14,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: unlocked ? _text : _muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    unlocked
                        ? 'Unlocked'
                        : '${count.clamp(0, target)} / $target',
                    style: TextStyle(
                      color: unlocked ? _teal : _muted,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: const TextStyle(color: _muted, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ── Summary stats row ─────────────────────────────────────
  Widget _buildSummaryStats() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _indigo.withOpacity(0.12), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AVG SEVERITY',
                    style: TextStyle(
                        color: _muted,
                        fontSize: 9,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  _episodeCount == 0 ? 'N/A' : _avgSeverity.toStringAsFixed(1),
                  style: TextStyle(
                    color: _episodeCount == 0
                        ? _muted
                        : _severityColor(_avgSeverity),
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('/ 10',
                    style: TextStyle(color: _muted, fontSize: 11)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _indigo.withOpacity(0.12), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AVG DURATION',
                    style: TextStyle(
                        color: _muted,
                        fontSize: 9,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  _formatDuration(_avgDurationMinutes),
                  style: const TextStyle(
                    color: _teal,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('per episode',
                    style: TextStyle(color: _muted, fontSize: 11)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _indigo.withOpacity(0.12), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('TOTAL',
                    style: TextStyle(
                        color: _muted,
                        fontSize: 9,
                        letterSpacing: 0.07,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 6),
                Text(
                  '$_episodeCount',
                  style: const TextStyle(
                    color: _text,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text('episodes',
                    style: TextStyle(color: _muted, fontSize: 11)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ── Trigger correlations ──────────────────────────────────
  Widget _buildTriggerCorrelations() {
    final triggers = _triggerFrequency;
    if (triggers.isEmpty) {
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('TOP TRIGGERS', Icons.bolt_rounded),
            const Text(
              'No triggers logged yet. Start logging episodes with triggers to see correlations.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    final top = triggers.entries.take(5).toList();
    final maxCount = top.first.value;

    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('TOP TRIGGERS', Icons.bolt_rounded),
          ...top.map((entry) {
            final pct = _episodeCount > 0
                ? (entry.value / _episodeCount * 100).round()
                : 0;
            final barWidth = entry.value / maxCount;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        entry.key,
                        style: const TextStyle(
                          color: _text,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '$pct% of episodes',
                        style: const TextStyle(
                          color: _indigoL,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Stack(
                    children: [
                      Container(
                        height: 6,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _navy,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: barWidth,
                        child: Container(
                          height: 6,
                          decoration: BoxDecoration(
                            color: _indigo,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // ── Medication effectiveness ──────────────────────────────
  Widget _buildMedicationEffectiveness() {
    final meds = _medicationEffectiveness;
    if (meds.isEmpty) {
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader(
                'MEDICATION EFFECTIVENESS', Icons.medication_rounded),
            const Text(
              'No medications logged yet. Track medications to see effectiveness data.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('MEDICATION EFFECTIVENESS', Icons.medication_rounded),
          ...meds.entries.take(4).map((entry) {
            final withDur = entry.value['with'] ?? 0;
            final withoutDur = entry.value['without'] ?? 0;
            final count = (entry.value['count'] ?? 0).toInt();
            final reduction = withoutDur - withDur;
            final isEffective = reduction > 0;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: isEffective
                      ? _teal.withOpacity(0.25)
                      : _indigo.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          entry.key,
                          style: const TextStyle(
                            color: _text,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (isEffective && withoutDur > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: _teal.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: _teal.withOpacity(0.3), width: 1),
                          ),
                          child: Text(
                            '-${_formatDuration(reduction)}',
                            style: const TextStyle(
                              color: _teal,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statPill('With med', _formatDuration(withDur), _indigo),
                      const SizedBox(width: 8),
                      if (withoutDur > 0)
                        _statPill(
                            'Without', _formatDuration(withoutDur), _muted),
                      const SizedBox(width: 8),
                      _statPill('$count uses', '', _muted),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _statPill(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value.isEmpty ? label : '$label: $value',
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // ── Symptom frequency chips ───────────────────────────────
  Widget _buildSymptomFrequency() {
    final symptoms = _symptomFrequency;
    if (symptoms.isEmpty) {
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('SYMPTOM FREQUENCY', Icons.shield_rounded),
            const Text(
              'No symptoms logged yet.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('SYMPTOM FREQUENCY', Icons.shield_rounded),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: symptoms.entries.take(10).map((entry) {
              final pct = _episodeCount > 0
                  ? (entry.value / _episodeCount * 100).round()
                  : 0;
              final intensity = entry.value / (symptoms.values.first);
              final bgOpacity = 0.06 + (intensity * 0.12);
              return Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: _indigo.withOpacity(bgOpacity),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _indigo.withOpacity(0.2 + intensity * 0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  '${entry.key} · $pct%',
                  style: TextStyle(
                    color: Color.lerp(
                        const Color(0xFF94A3B8), _indigoL, intensity)!,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ── Trigger combination correlations ─────────────────────
  Widget _buildTriggerCombinations() {
    final isResearch = researchMode ?? false;

    if (headacheList.length < 10) {
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('TRIGGER COMBINATIONS', Icons.hub_rounded),
            const Text(
              'Log 10 or more episodes to reveal trigger combination patterns.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    final combos = _triggerCombinations(researchMode: isResearch);
    if (combos.isEmpty) {
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('TRIGGER COMBINATIONS', Icons.hub_rounded),
            const Text(
              'No recurring trigger combinations found yet. Log more episodes with multiple triggers.',
              style: TextStyle(color: _muted, fontSize: 13),
            ),
          ],
        ),
      );
    }

    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: label + optional LIFT mode badge
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                const Icon(Icons.hub_rounded, color: _indigoL, size: 14),
                const SizedBox(width: 6),
                const Text(
                  'TRIGGER COMBINATIONS',
                  style: TextStyle(
                    color: _indigoL,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.1,
                  ),
                ),
                if (isResearch) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _teal.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                      border:
                          Border.all(color: _teal.withOpacity(0.35), width: 1),
                    ),
                    child: const Text(
                      'LIFT',
                      style: TextStyle(
                        color: _teal,
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.05,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          ...combos.take(5).map((combo) {
            final accent = combo.isTriple ? _amber : _indigo;
            final accentL = combo.isTriple ? _amber : _indigoL;

            // Standard mode: compositeScore ∈ [0,1] → bar fills directly.
            // Research mode: compositeScore is lift ∈ [0,∞).
            //   Map onto [0,1] using lift/2.0 so the bar reads:
            //     0% = lift 0.0  (impossible in practice)
            //    50% = lift 1.0  (independence baseline — no synergy)
            //   100% = lift 2.0  (combo is twice as severe as predicted)
            //   Anything above 2× is clinically notable and clips to full bar.
            final barWidth = isResearch
                ? (combo.compositeScore / 2.0).clamp(0.0, 1.0)
                : combo.compositeScore.clamp(0.0, 1.0);

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _surface,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: accent.withOpacity(0.25),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          combo.label,
                          style: const TextStyle(
                            color: _text,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Lift badge — only visible in research mode
                          if (isResearch) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: _teal.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: _teal.withOpacity(0.3), width: 1),
                              ),
                              child: Text(
                                '${combo.compositeScore.toStringAsFixed(2)}×',
                                style: const TextStyle(
                                  color: _teal,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                          ],
                          // Pair / Triple type badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: accent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: accent.withOpacity(0.3), width: 1),
                            ),
                            child: Text(
                              combo.isTriple ? 'Triple' : 'Pair',
                              style: TextStyle(
                                color: accentL,
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Container(
                        height: 4,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: _navy,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: barWidth,
                        child: Container(
                          height: 4,
                          decoration: BoxDecoration(
                            color: isResearch ? _teal : accent,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _statPill('${combo.episodeCount} episodes', '', _muted),
                      const SizedBox(width: 8),
                      _statPill('Severity',
                          combo.avgSeverity.toStringAsFixed(1), accentL),
                      if (combo.avgDurationMin > 0) ...[
                        const SizedBox(width: 8),
                        _statPill('Duration',
                            _formatDuration(combo.avgDurationMin), _muted),
                      ],
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  // ── AI Analysis card ──────────────────────────────────────
  Widget _buildAIAnalysisCard() {
    // Loading state — full card shimmer/spinner
    if (isLoading == true) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: _cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _indigo.withOpacity(0.2), width: 1),
        ),
        child: Column(
          children: [
            const SizedBox(height: 8),
            SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(_indigo),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Analyzing your episode data',
              style: TextStyle(
                color: _text,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Identifying patterns across triggers, severity, and duration...',
              textAlign: TextAlign.center,
              style: TextStyle(color: _muted, fontSize: 12),
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    // Result state
    if (aiAnalysisResult != null && aiAnalysisResult!.isNotEmpty) {
      return _cardWrap(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('AI INSIGHTS', Icons.auto_awesome_rounded),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _navy,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _indigo.withOpacity(0.2), width: 1),
              ),
              child: Text(
                aiAnalysisResult!,
                style: const TextStyle(
                  color: _text,
                  fontSize: 13,
                  height: 1.65,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1200).withOpacity(0.6),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _amber.withOpacity(0.25), width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: _amber.withOpacity(0.7), size: 14),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'AI-generated insights are for informational purposes only and do not constitute medical advice. Consult a healthcare provider for clinical guidance.',
                      style: TextStyle(
                        color: Color(0xFFB45309),
                        fontSize: 10,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Insufficient data state
    if (headacheList.length < 15) {
      final remaining = 15 - headacheList.length;
      final progress = headacheList.length / 15;
      return _cardWrap(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionHeader('AI INSIGHTS', Icons.auto_awesome_rounded),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _navy,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _indigo.withOpacity(0.15), width: 1),
              ),
              child: Column(
                children: [
                  Icon(Icons.auto_awesome_outlined,
                      color: _indigo.withOpacity(0.4), size: 28),
                  const SizedBox(height: 10),
                  const Text(
                    'Not enough data yet',
                    style: TextStyle(
                      color: _text,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Log $remaining more episodes to unlock AI insights.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: _muted, fontSize: 12),
                  ),
                  const SizedBox(height: 14),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: _cardBg,
                      valueColor: AlwaysStoppedAnimation<Color>(_indigo),
                      minHeight: 5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${headacheList.length} / 15 episodes',
                    style: const TextStyle(
                      color: _indigoL,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Empty state - enough data but tab not yet visited
    return _cardWrap(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('AI INSIGHTS', Icons.auto_awesome_rounded),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _navy,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _indigo.withOpacity(0.15), width: 1),
            ),
            child: Column(
              children: [
                Icon(Icons.auto_awesome_outlined,
                    color: _indigo.withOpacity(0.4), size: 24),
                const SizedBox(height: 8),
                const Text(
                  'Switch to this tab to auto-generate your personalized insights.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: _muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard(),
            const SizedBox(height: 4),
            _buildSummaryStats(),
            const SizedBox(height: 12),
            _buildTriggerCorrelations(),
            _buildTriggerCombinations(),
            _buildMedicationEffectiveness(),
            _buildSymptomFrequency(),
            _buildAIAnalysisCard(),
          ],
        ),
      ),
    );
  }
}
