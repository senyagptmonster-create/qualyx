import 'package:flutter/material.dart';
import '../state/qualyx_game_state.dart';
import '../theme/qualyx_theme.dart';

class PuzzleCompletedScreen extends StatelessWidget {
  const PuzzleCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = QualyxScope.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Puzzle Solved!'), automaticallyImplyLeading: false),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.verified_rounded, color: QualyxTheme.violet, size: 76),
              const SizedBox(height: 16),
              const Text(
                'BINARY GRID SOLVED',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  color: QualyxTheme.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: QualyxTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: QualyxTheme.violet.withValues(alpha: 0.3)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Moves', style: TextStyle(color: QualyxTheme.textSecondary)),
                        Text('${game.movesCount}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: QualyxTheme.cyan)),
                      ],
                    ),
                    const Divider(color: Colors.white10, height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Cognitive Score', style: TextStyle(color: QualyxTheme.textSecondary)),
                        Text('980 XP', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: QualyxTheme.purple)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: QualyxTheme.violet,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: () {
                    game.resetPuzzle();
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  child: const Text('RETURN TO ARENA HUB', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
