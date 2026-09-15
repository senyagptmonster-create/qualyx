import 'package:flutter/material.dart';
import '../painters/binary_grid_painter.dart';
import '../state/qualyx_game_state.dart';
import '../theme/qualyx_theme.dart';
import 'puzzle_completed_screen.dart';

class GridPuzzleScreen extends StatelessWidget {
  const GridPuzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = QualyxScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('4x4 Binary Deduction'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: game.resetPuzzle,
            tooltip: 'Reset Grid',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: QualyxTheme.surface, borderRadius: BorderRadius.circular(8)),
                    child: Text('Moves: ${game.movesCount}', style: const TextStyle(color: QualyxTheme.textSecondary, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: QualyxTheme.surface, borderRadius: BorderRadius.circular(8)),
                    child: const Text('Equal 0s & 1s', style: TextStyle(color: QualyxTheme.purple, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const Spacer(),

              // Touchable Grid
              Center(
                child: SizedBox(
                  width: 280,
                  height: 280,
                  child: GestureDetector(
                    onTapUp: (details) {
                      final localPos = details.localPosition;
                      final cellSize = 280 / game.gridSize;
                      final c = (localPos.dx / cellSize).floor();
                      final r = (localPos.dy / cellSize).floor();
                      game.toggleCell(r, c);

                      if (game.isCompleted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => QualyxScope(notifier: game, child: const PuzzleCompletedScreen()),
                          ),
                        );
                      }
                    },
                    child: CustomPaint(
                      size: const Size(280, 280),
                      painter: BinaryGridPainter(
                        grid: game.grid,
                        gridSize: game.gridSize,
                      ),
                    ),
                  ),
                ),
              ),

              const Spacer(),
              const Text(
                'Tap any cell to cycle: Empty -> 0 -> 1',
                style: TextStyle(fontSize: 13, color: QualyxTheme.textSecondary),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
