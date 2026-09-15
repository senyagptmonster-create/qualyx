import 'package:flutter/material.dart';
import 'screens/logic_hub_screen.dart';
import 'state/qualyx_game_state.dart';
import 'theme/qualyx_theme.dart';

class QualyxApp extends StatefulWidget {
  const QualyxApp({super.key});

  @override
  State<QualyxApp> createState() => _QualyxAppState();
}

class _QualyxAppState extends State<QualyxApp> {
  final QualyxGameState _gameState = QualyxGameState();

  @override
  void dispose() {
    _gameState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return QualyxScope(
      notifier: _gameState,
      child: MaterialApp(
        title: 'Qualyx Logic Arena',
        debugShowCheckedModeBanner: false,
        theme: QualyxTheme.themeData,
        home: const LogicHubScreen(),
      ),
    );
  }
}
