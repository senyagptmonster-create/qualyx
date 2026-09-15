class PuzzleCell {
  final int row;
  final int col;
  int? value; // null = empty, 0, or 1
  final bool isLocked;

  PuzzleCell({
    required this.row,
    required this.col,
    this.value,
    this.isLocked = false,
  });

  PuzzleCell copyWith({int? value, bool? isLocked}) {
    return PuzzleCell(
      row: row,
      col: col,
      value: value ?? this.value,
      isLocked: isLocked ?? this.isLocked,
    );
  }
}

class ArchiveEntry {
  final String date;
  final int size;
  final int durationSeconds;
  final bool solved;

  ArchiveEntry({
    required this.date,
    required this.size,
    required this.durationSeconds,
    required this.solved,
  });

  Map<String, dynamic> toJson() => {
        'date': date,
        'size': size,
        'durationSeconds': durationSeconds,
        'solved': solved,
      };

  factory ArchiveEntry.fromJson(Map<String, dynamic> json) => ArchiveEntry(
        date: json['date'] as String? ?? 'Today',
        size: json['size'] as int? ?? 4,
        durationSeconds: json['durationSeconds'] as int? ?? 60,
        solved: json['solved'] as bool? ?? true,
      );
}
