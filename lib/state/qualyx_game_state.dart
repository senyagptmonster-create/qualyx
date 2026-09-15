import 'package:flutter/material.dart';

class QualyxGameState extends ChangeNotifier {
  int gridSize = 4;
  late List<List<int>> grid;
  int movesCount = 0;
  int hintsUsed = 0;
  bool isCompleted = false;

  QualyxGameState() {
    resetPuzzle();
  }

  void resetPuzzle() {
    // 4x4 initial puzzle with some fixed cells
    grid = [
      [1, 0, 2, 0],
      [0, 2, 0, 1],
      [2, 0, 1, 0],
      [0, 1, 0, 2],
    ];
    movesCount = 0;
    hintsUsed = 0;
    isCompleted = false;
    notifyListeners();
  }

  void toggleCell(int r, int c) {
    if (r < 0 || r >= gridSize || c < 0 || c >= gridSize) return;
    // Cycle: 0 (empty) -> 1 (binary 0) -> 2 (binary 1) -> 0
    grid[r][c] = (grid[r][c] + 1) % 3;
    movesCount++;
    _checkSolution();
    notifyListeners();
  }

  void _checkSolution() {
    // If every cell is filled
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c] == 0) return;
      }
    }
    isCompleted = true;
  }
}

class QualyxScope extends InheritedNotifier<QualyxGameState> {
  const QualyxScope({
    super.key,
    required QualyxGameState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static QualyxGameState of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<QualyxScope>();
    assert(scope != null, 'No QualyxScope found in context');
    return scope!.notifier!;
  }
}
