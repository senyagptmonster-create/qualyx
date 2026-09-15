import 'package:flutter/material.dart';
import '../painters/binary_grid_painter.dart';
import '../state/qualyx_game_state.dart';
import '../theme/qualyx_theme.dart';
import 'grid_puzzle_screen.dart';
import 'logic_rules_screen.dart';

class LogicHubScreen extends StatelessWidget {
  const LogicHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = QualyxScope.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Qualyx Logic Arena'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            tooltip: 'Rules',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LogicRulesScreen()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Preview grid display
              SizedBox(
                height: 180,
                child: CustomPaint(
                  painter: BinaryGridPainter(
                    grid: game.grid,
                    gridSize: game.gridSize,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'SELECT COGNITIVE PROTOCOL',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: QualyxTheme.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              _buildChallengeCard(
                title: 'Daily Binary 4x4 Grid',
                desc: 'Balanced matrix with parity deduction constraints',
                icon: Icons.grid_4x4_rounded,
                color: QualyxTheme.violet,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QualyxScope(notifier: game, child: const GridPuzzleScreen())),
                  );
                },
              ),
              const SizedBox(height: 10),
              _buildChallengeCard(
                title: 'Master 6x6 Matrix',
                desc: 'Deep analytical challenge with triple prevention',
                icon: Icons.grid_view_rounded,
                color: QualyxTheme.cyan,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QualyxScope(notifier: game, child: const GridPuzzleScreen())),
                  );
                },
              ),
              const SizedBox(height: 28),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: QualyxTheme.violet,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => QualyxScope(notifier: game, child: const GridPuzzleScreen())),
                  );
                },
                icon: const Icon(Icons.play_arrow_rounded, size: 28),
                label: const Text(
                  'START LOGIC CHALLENGE',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChallengeCard({
    required String title,
    required String desc,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: QualyxTheme.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: QualyxTheme.textPrimary)),
                  const SizedBox(height: 3),
                  Text(desc, style: const TextStyle(fontSize: 12, color: QualyxTheme.textSecondary)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 14),
          ],
        ),
      ),
    );
  }
}
