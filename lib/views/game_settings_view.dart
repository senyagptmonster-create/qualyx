import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../ui/puzzle_styles.dart';
import '../viewmodels/logic_puzzle_viewmodel.dart';

class GameSettingsView extends StatelessWidget {
  const GameSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LogicPuzzleViewModel>();

    return Scaffold(
      backgroundColor: QualyxPalette.background,
      appBar: AppBar(
        title: const Text('Game Configuration', style: QualyxTypography.heading),
        backgroundColor: QualyxPalette.surface,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: QualyxPalette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: QualyxPalette.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Grid Size Preference', style: QualyxTypography.subhead),
                const SizedBox(height: 8),
                const Text('Choose the board dimension for daily challenges.', style: QualyxTypography.body),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text('4 x 4 (Classic)')),
                        selected: vm.gridSize == 4,
                        selectedColor: QualyxPalette.purple,
                        labelStyle: TextStyle(
                          color: vm.gridSize == 4 ? Colors.white : QualyxPalette.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (_) => vm.setGridSize(4),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ChoiceChip(
                        label: const Center(child: Text('6 x 6 (Master)')),
                        selected: vm.gridSize == 6,
                        selectedColor: QualyxPalette.purple,
                        labelStyle: TextStyle(
                          color: vm.gridSize == 6 ? Colors.white : QualyxPalette.textMuted,
                          fontWeight: FontWeight.bold,
                        ),
                        onSelected: (_) => vm.setGridSize(6),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: QualyxPalette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: QualyxPalette.border),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: QualyxPalette.purpleLight,
                  activeTrackColor: QualyxPalette.purple,
                  title: const Text('Highlight Rule Violations', style: QualyxTypography.subhead),
                  subtitle: const Text('Show immediate alert when 3 identical numbers align.', style: QualyxTypography.body),
                  value: vm.highlightErrors,
                  onChanged: vm.toggleErrors,
                ),
                const Divider(color: QualyxPalette.border),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  activeColor: QualyxPalette.purpleLight,
                  activeTrackColor: QualyxPalette.purple,
                  title: const Text('Haptic & Sound Feedback', style: QualyxTypography.subhead),
                  subtitle: const Text('Audio cues during cell selections and completion.', style: QualyxTypography.body),
                  value: vm.soundEnabled,
                  onChanged: vm.toggleSound,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: QualyxPalette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: QualyxPalette.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('About Qualyx', style: QualyxTypography.subhead),
                const SizedBox(height: 8),
                const Text(
                  'Qualyx is a standalone offline binary deduction solver designed to challenge logic and pattern recognition.',
                  style: QualyxTypography.body,
                ),
                const SizedBox(height: 12),
                const Text('Version: 1.0.0 (Release Build)', style: TextStyle(color: QualyxPalette.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
