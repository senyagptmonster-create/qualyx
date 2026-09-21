import 'package:flutter/material.dart';

class BinaryGridPainter extends CustomPainter {
  final List<List<int>> grid; // 0: empty, 1: binary 0, 2: binary 1
  final int gridSize;

  const BinaryGridPainter({
    required this.grid,
    required this.gridSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Board background
    final bgPaint = Paint()
      ..color = const Color(0xFF121420)
      ..style = PaintingStyle.fill;
    final rrect = RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16));
    canvas.drawRRect(rrect, bgPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFF8B5CF6).withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(rrect, borderPaint);

    // Cell calculations
    // Fit the grid inside the shorter side so it never paints past its bounds.
    final double side = size.width < size.height ? size.width : size.height;
    final double cellSize = side / gridSize;
    final double ox = (size.width - side) / 2;
    final double oy = (size.height - side) / 2;

    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        final cellRect = Rect.fromLTWH(ox + c * cellSize + 4, oy + r * cellSize + 4, cellSize - 8, cellSize - 8);
        final cellRRect = RRect.fromRectAndRadius(cellRect, const Radius.circular(8));

        final int val = (r < grid.length && c < grid[r].length) ? grid[r][c] : 0;

        Color cellBg = const Color(0xFF1E2235);
        if (val == 1) {
          cellBg = const Color(0xFF3B82F6).withValues(alpha: 0.25);
        } else if (val == 2) {
          cellBg = const Color(0xFF8B5CF6).withValues(alpha: 0.25);
        }

        canvas.drawRRect(cellRRect, Paint()..color = cellBg);
        canvas.drawRRect(cellRRect, Paint()..color = Colors.white10..style = PaintingStyle.stroke..strokeWidth = 1.0);

        if (val != 0) {
          final text = val == 1 ? '0' : '1';
          final textSpan = TextSpan(
            text: text,
            style: TextStyle(
              color: val == 1 ? const Color(0xFF60A5FA) : const Color(0xFFA78BFA),
              fontSize: cellSize * 0.45,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
            ),
          );
          final tp = TextPainter(
            text: textSpan,
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          )..layout();

          final textOffset = Offset(
            ox + c * cellSize + (cellSize - tp.width) / 2,
            oy + r * cellSize + (cellSize - tp.height) / 2,
          );
          tp.paint(canvas, textOffset);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant BinaryGridPainter oldDelegate) {
    return oldDelegate.gridSize != gridSize || oldDelegate.grid != grid;
  }
}
