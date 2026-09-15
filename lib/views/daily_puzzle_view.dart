import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/puzzle_styles.dart';
import '../viewmodels/logic_puzzle_viewmodel.dart';

class DailyPuzzleView extends StatelessWidget {
  const DailyPuzzleView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LogicPuzzleViewModel>();

    return Scaffold(
      backgroundColor: QualyxPalette.background,
      appBar: AppBar(
        title: const Text('Daily Binary Logic', style: QualyxTypography.heading),
        backgroundColor: QualyxPalette.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: QualyxPalette.purpleLight),
            onPressed: () => vm.generatePuzzle(vm.gridSize),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: QualyxPalette.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: QualyxPalette.border),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: QualyxPalette.cyan, size: 20),
                      const SizedBox(width: 8),
                      Text('${vm.secondsElapsed}s', style: QualyxTypography.subhead),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.grid_3x3, color: QualyxPalette.purple, size: 20),
                      const SizedBox(width: 8),
                      Text('${vm.gridSize}x${vm.gridSize} Grid', style: QualyxTypography.subhead),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (vm.statusMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: vm.isCompleted
                      ? QualyxPalette.successGreen.withValues(alpha: 0.2)
                      : QualyxPalette.errorRed.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  vm.statusMessage!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: vm.isCompleted ? QualyxPalette.successGreen : QualyxPalette.errorRed,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: QualyxPalette.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: QualyxPalette.border, width: 2),
                    ),
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: vm.gridSize,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: vm.cells.length,
                      itemBuilder: (context, index) {
                        final cell = vm.cells[index];
                        final valText = cell.value == null ? '' : cell.value.toString();
                        final isZero = cell.value == 0;

                        return InkWell(
                          onTap: () => vm.toggleCell(index),
                          borderRadius: BorderRadius.circular(8),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 150),
                            decoration: BoxDecoration(
                              color: cell.isLocked
                                  ? QualyxPalette.card
                                  : (cell.value == null
                                      ? QualyxPalette.background
                                      : (isZero
                                          ? QualyxPalette.purple.withValues(alpha: 0.25)
                                          : QualyxPalette.cyan.withValues(alpha: 0.25))),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: cell.isLocked
                                    ? QualyxPalette.border
                                    : (cell.value == null
                                        ? QualyxPalette.border
                                        : (isZero ? QualyxPalette.purple : QualyxPalette.cyan)),
                                width: cell.isLocked ? 1.0 : 1.8,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                valText,
                                style: QualyxTypography.cellText.copyWith(
                                  color: cell.isLocked
                                      ? QualyxPalette.textMuted
                                      : (isZero ? QualyxPalette.purpleLight : QualyxPalette.cyan),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: QualyxPalette.surface,
                      foregroundColor: QualyxPalette.textMain,
                      side: const BorderSide(color: QualyxPalette.border),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: vm.clearUnclued,
                    icon: const Icon(Icons.clear_all, size: 18),
                    label: const Text('Reset'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: QualyxPalette.purple,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () => vm.generatePuzzle(vm.gridSize),
                    icon: const Icon(Icons.casino_outlined, size: 18),
                    label: const Text('New Puzzle'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
