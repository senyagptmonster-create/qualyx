import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app/brand.dart';
import '../app/theme.dart';
import 'screens.dart';
import 'qualyx_store.dart';

class ProductApp extends StatelessWidget {
  const ProductApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QualyxStore(),
      child: MaterialApp(
        title: 'Qualyx',
        theme: ThemeData(
          scaffoldBackgroundColor: cBg,
          colorScheme: ColorScheme.light(primary: cInk, secondary: cAccent),
        ),
        home: QualyxHome(),
      ),
    );
  }
}

class QualyxHome extends StatelessWidget {
  const QualyxHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Qualyx', style: AppTheme.display(cSurface)), backgroundColor: cInk),
      drawer: Drawer(
        backgroundColor: cSurface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: cInk),
              child: Text('Menu', style: AppTheme.display(cSurface)),
            ),
            ListTile(
              leading: Icon(Icons.grid_4x4, color: cAccent),
              title: Text('Daily Puzzle', style: AppTheme.text(cInk)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => DailyLogicPuzzleScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.archive, color: cAccent),
              title: Text('Solver Archive', style: AppTheme.text(cInk)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => SolverArchiveScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.lightbulb, color: cAccent),
              title: Text('Deduction Tips', style: AppTheme.text(cInk)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => DeductionTipsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: cAccent),
              title: Text('Game Settings', style: AppTheme.text(cInk)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => GameSettingsScreen()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text('Welcome to Qualyx', style: AppTheme.display(cInk)),
      ),
    );
  }
}
