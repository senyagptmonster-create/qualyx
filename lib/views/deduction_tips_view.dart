import 'package:flutter/material.dart';
import '../ui/puzzle_styles.dart';

class DeductionTipsView extends StatelessWidget {
  const DeductionTipsView({super.key});

  @override
  Widget build(BuildContext context) {
    final tips = [
      {
        'title': 'Rule of Trios',
        'desc': 'No three consecutive identical numbers (0-0-0 or 1-1-1) are allowed in any row or column. If you see 0-0-_, the next must be 1.',
        'icon': Icons.block,
      },
      {
        'title': 'Equal Parity',
        'desc': 'Each row and column must contain an equal number of 0s and 1s. In a 4x4 grid, exactly two 0s and two 1s appear per line.',
        'icon': Icons.balance,
      },
      {
        'title': 'The Sandwich Trap',
        'desc': 'If two identical numbers are separated by an empty space (0-_-0), the space in the middle must be the opposite number (1).',
        'icon': Icons.swap_horiz,
      },
      {
        'title': 'Line Uniqueness',
        'desc': 'No two completed rows or columns can be identical. Use already completed lines to eliminate identical possibilities.',
        'icon': Icons.fingerprint,
      },
    ];

    return Scaffold(
      backgroundColor: QualyxPalette.background,
      appBar: AppBar(
        title: const Text('Deduction Handbook', style: QualyxTypography.heading),
        backgroundColor: QualyxPalette.surface,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: tips.length,
        itemBuilder: (context, index) {
          final t = tips[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: QualyxPalette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: QualyxPalette.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: QualyxPalette.cyan.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(t['icon'] as IconData, color: QualyxPalette.cyan, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(t['title'] as String, style: QualyxTypography.subhead),
                      const SizedBox(height: 6),
                      Text(t['desc'] as String, style: QualyxTypography.body),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
