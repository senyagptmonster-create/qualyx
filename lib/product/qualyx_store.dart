import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class QualyxStore extends ChangeNotifier {
  List<dynamic> puzzles = [];
  Map<String, dynamic> settings = {};

  QualyxStore() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('qualyx_data');
    if (data != null) {
      final map = jsonDecode(data);
      puzzles = map['puzzles'] ?? [];
      settings = map['settings'] ?? {};
      notifyListeners();
    }
  }

  Future<void> completePuzzle(String id) async {
    puzzles.add({"id": id, "date": DateTime.now().toIso8601String()});
    await _save();
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('qualyx_data', jsonEncode({'puzzles': puzzles, 'settings': settings}));
  }
}
