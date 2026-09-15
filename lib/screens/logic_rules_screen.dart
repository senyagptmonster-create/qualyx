import 'package:flutter/material.dart';
import '../theme/qualyx_theme.dart';

class LogicRulesScreen extends StatelessWidget {
  const LogicRulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final rules = [
      {'title': 'Rule 1: Equal Distribution', 'desc': 'Each row and column must contain an equal number of 0s and 1s.'},
      {'title': 'Rule 2: No Triples', 'desc': 'No more than two identical digits may be adjacent horizontally or vertically (e.g. 111 is illegal).'},
      {'title': 'Rule 3: Unique Rows & Cols', 'desc': 'No two rows and no two columns can be completely identical.'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Binary Deduction Rules')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: rules.length,
        separatorBuilder: (context, _) => const SizedBox(height: 12),
        itemBuilder: (ctx, i) {
          final r = rules[i];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: QualyxTheme.surface,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(r['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: QualyxTheme.purple)),
                const SizedBox(height: 6),
                Text(r['desc']!, style: const TextStyle(fontSize: 13, color: QualyxTheme.textSecondary, height: 1.3)),
              ],
            ),
          );
        },
      ),
    );
  }
}
