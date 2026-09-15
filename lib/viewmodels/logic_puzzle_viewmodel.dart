import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/puzzle_node.dart';

class LogicPuzzleViewModel extends ChangeNotifier {
  int gridSize = 4;
  List<PuzzleCell> cells = [];
  List<ArchiveEntry> history = [];
  int secondsElapsed = 0;
  Timer? _timer;
  bool isCompleted = false;
  String? statusMessage;
  bool soundEnabled = true;
  bool highlightErrors = true;

  LogicPuzzleViewModel() {
    _initPreferences();
    generatePuzzle(4);
  }

  Future<void> _initPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    soundEnabled = prefs.getBool('qualyx_sound') ?? true;
    highlightErrors = prefs.getBool('qualyx_errors') ?? true;
    final archiveRaw = prefs.getString('qualyx_archive');
    if (archiveRaw != null) {
      try {
        final List<dynamic> list = jsonDecode(archiveRaw);
        history = list.map((e) => ArchiveEntry.fromJson(e as Map<String, dynamic>)).toList();
      } catch (_) {}
    }
    notifyListeners();
  }

  void generatePuzzle(int size) {
    gridSize = size;
    secondsElapsed = 0;
    isCompleted = false;
    statusMessage = null;
    _timer?.cancel();

    cells = List.generate(size * size, (index) {
      final r = index ~/ size;
      final c = index % size;
      // Fixed starter clues for binary deduction
      final isClue = (r + c) % (size == 4 ? 3 : 4) == 0;
      final val = isClue ? (r % 2) : null;
      return PuzzleCell(row: r, col: c, value: val, isLocked: isClue);
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isCompleted) {
        secondsElapsed++;
        notifyListeners();
      }
    });

    notifyListeners();
  }

  void toggleCell(int index) {
    if (cells[index].isLocked || isCompleted) return;
    final current = cells[index].value;
    if (current == null) {
      cells[index].value = 0;
    } else if (current == 0) {
      cells[index].value = 1;
    } else {
      cells[index].value = null;
    }
    _checkCompletion();
    notifyListeners();
  }

  void clearUnclued() {
    for (var cell in cells) {
      if (!cell.isLocked) {
        cell.value = null;
      }
    }
    statusMessage = 'Cleared user entries';
    notifyListeners();
  }

  void _checkCompletion() {
    // Check if full
    final allFilled = cells.every((c) => c.value != null);
    if (!allFilled) {
      statusMessage = null;
      return;
    }

    // Binary puzzle simple validator: no three in a row
    bool valid = true;
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize - 2; c++) {
        final v1 = cells[r * gridSize + c].value;
        final v2 = cells[r * gridSize + c + 1].value;
        final v3 = cells[r * gridSize + c + 2].value;
        if (v1 == v2 && v2 == v3) valid = false;
      }
    }
    for (int c = 0; c < gridSize; c++) {
      for (int r = 0; r < gridSize - 2; r++) {
        final v1 = cells[r * gridSize + c].value;
        final v2 = cells[(r + 1) * gridSize + c].value;
        final v3 = cells[(r + 2) * gridSize + c].value;
        if (v1 == v2 && v2 == v3) valid = false;
      }
    }

    if (valid) {
      isCompleted = true;
      _timer?.cancel();
      statusMessage = 'Puzzle Solved in $secondsElapsed s!';
      _saveToArchive();
    } else {
      statusMessage = 'Rule violation detected!';
    }
  }

  Future<void> _saveToArchive() async {
    final entry = ArchiveEntry(
      date: DateTime.now().toLocal().toString().split(' ')[0],
      size: gridSize,
      durationSeconds: secondsElapsed,
      solved: true,
    );
    history.insert(0, entry);
    final prefs = await SharedPreferences.getInstance();
    final jsonList = history.map((e) => e.toJson()).toList();
    await prefs.setString('qualyx_archive', jsonEncode(jsonList));
  }

  void setGridSize(int size) {
    if (size == gridSize) return;
    generatePuzzle(size);
  }

  void toggleErrors(bool val) async {
    highlightErrors = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('qualyx_errors', val);
    notifyListeners();
  }

  void toggleSound(bool val) async {
    soundEnabled = val;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('qualyx_sound', val);
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
