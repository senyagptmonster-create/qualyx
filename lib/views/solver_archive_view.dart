import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/puzzle_styles.dart';
import '../viewmodels/logic_puzzle_viewmodel.dart';

class SolverArchiveView extends StatelessWidget {
  const SolverArchiveView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LogicPuzzleViewModel>();

    return Scaffold(
      backgroundColor: QualyxPalette.background,
      appBar: AppBar(
        title: const Text('Solver Archive', style: QualyxTypography.heading),
        backgroundColor: QualyxPalette.surface,
        elevation: 0,
      ),
      body: vm.history.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive_outlined, size: 64, color: QualyxPalette.textMuted.withValues(alpha: 0.4)),
                  const SizedBox(height: 16),
                  const Text('No Solved Puzzles Yet', style: QualyxTypography.subhead),
                  const SizedBox(height: 8),
                  const Text('Complete daily deduction grids to fill your archive.', style: QualyxTypography.body),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vm.history.length,
              itemBuilder: (context, index) {
                final item = vm.history[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: QualyxPalette.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: QualyxPalette.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: QualyxPalette.purple.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.check_circle, color: QualyxPalette.purple, size: 24),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Date: ${item.date}', style: QualyxTypography.subhead),
                            const SizedBox(height: 4),
                            Text('${item.size}x${item.size} Matrix Grid', style: QualyxTypography.body),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('${item.durationSeconds}s', style: QualyxTypography.subhead.copyWith(color: QualyxPalette.cyan)),
                          const SizedBox(height: 4),
                          const Text('Solved', style: TextStyle(color: QualyxPalette.successGreen, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
