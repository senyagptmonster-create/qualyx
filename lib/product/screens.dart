import 'package:flutter/material.dart';
import '../app/brand.dart';
import '../app/theme.dart';

class DailyLogicPuzzleScreen extends StatelessWidget {
  const DailyLogicPuzzleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(title: Text('Daily Puzzle', style: AppTheme.display(cSurface)), backgroundColor: cInk),
      body: Center(child: Text('Puzzle Grid', style: AppTheme.text(cInk))),
    );
  }
}

class SolverArchiveScreen extends StatelessWidget {
  const SolverArchiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(title: Text('Solver Archive', style: AppTheme.display(cSurface)), backgroundColor: cInk),
      body: Center(child: Text('Archive', style: AppTheme.text(cInk))),
    );
  }
}

class DeductionTipsScreen extends StatelessWidget {
  const DeductionTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(title: Text('Deduction Tips', style: AppTheme.display(cSurface)), backgroundColor: cInk),
      body: Center(child: Text('Tips', style: AppTheme.text(cInk))),
    );
  }
}

class GameSettingsScreen extends StatelessWidget {
  const GameSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cBg,
      appBar: AppBar(title: Text('Game Settings', style: AppTheme.display(cSurface)), backgroundColor: cInk),
      body: Center(child: Text('Settings', style: AppTheme.text(cInk))),
    );
  }
}
