import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/puzzle_styles.dart';
import 'viewmodels/logic_puzzle_viewmodel.dart';
import 'views/daily_puzzle_view.dart';
import 'views/solver_archive_view.dart';
import 'views/deduction_tips_view.dart';
import 'views/game_settings_view.dart';

class QualyxApp extends StatelessWidget {
  const QualyxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LogicPuzzleViewModel(),
      child: MaterialApp(
        title: 'Qualyx',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          scaffoldBackgroundColor: QualyxPalette.background,
          colorScheme: const ColorScheme.dark(
            primary: QualyxPalette.purple,
            secondary: QualyxPalette.cyan,
            surface: QualyxPalette.surface,
          ),
          fontFamily: 'AppFont',
        ),
        home: const QualyxNavigationShell(),
      ),
    );
  }
}

class QualyxNavigationShell extends StatefulWidget {
  const QualyxNavigationShell({super.key});

  @override
  State<QualyxNavigationShell> createState() => _QualyxNavigationShellState();
}

class _QualyxNavigationShellState extends State<QualyxNavigationShell> {
  int _selectedView = 0;

  final List<Widget> _views = const [
    DailyPuzzleView(),
    SolverArchiveView(),
    DeductionTipsView(),
    GameSettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_selectedView],
      drawer: Drawer(
        backgroundColor: QualyxPalette.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [QualyxPalette.card, QualyxPalette.surface],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border(bottom: BorderSide(color: QualyxPalette.border)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: QualyxPalette.purple.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.grid_4x4, color: QualyxPalette.purple, size: 28),
                  ),
                  const SizedBox(height: 12),
                  const Text('Qualyx Deductions', style: QualyxTypography.heading),
                  const SizedBox(height: 4),
                  const Text('Daily Cognitive Logic', style: QualyxTypography.body),
                ],
              ),
            ),
            _buildDrawerTile(0, 'Daily Puzzle', Icons.extension_outlined),
            _buildDrawerTile(1, 'Solver Archive', Icons.archive_outlined),
            _buildDrawerTile(2, 'Deduction Handbook', Icons.lightbulb_outline),
            _buildDrawerTile(3, 'Game Settings', Icons.settings_outlined),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerTile(int index, String title, IconData icon) {
    final isSelected = _selectedView == index;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? QualyxPalette.purpleLight : QualyxPalette.textMuted,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.white : QualyxPalette.textMuted,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      tileColor: isSelected ? QualyxPalette.card : Colors.transparent,
      onTap: () {
        setState(() {
          _selectedView = index;
        });
        Navigator.pop(context);
      },
    );
  }
}
