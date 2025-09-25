import 'package:flutter/material.dart';

class DragDrop extends StatefulWidget {
  const DragDrop({super.key});

  @override
  State<DragDrop> createState() => _DragDropState();
}

class _DragDropState extends State<DragDrop> {
  final colors = [Colors.red, Colors.green, Colors.blue];

  /// To track which boxes are correctly filled
  final Map<Color, bool> _filled = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Drag & Drop Game")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Draggable balls
          Wrap(
            spacing: 20,
            children: colors.map((color) {
              return Draggable<Color>(
                data: color,
                feedback: CircleAvatar(backgroundColor: color, radius: 30),
                childWhenDragging: CircleAvatar(
                  backgroundColor: color.withOpacity(0.3),
                  radius: 30,
                ),
                child: CircleAvatar(backgroundColor: color, radius: 30),
              );
            }).toList(),
          ),
          const SizedBox(height: 40),
          // Drop targets
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: colors.map((color) {
              return DragTarget<Color>(
                onAccept: (data) {
                  final correct = data == color;
                  if (correct) {
                    setState(() {
                      _filled[color] = true;
                    });
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Correct! ")));
                  } else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text("Wrong!")));
                  }
                },
                builder: (context, candidateData, rejectedData) {
                  final isFilled = _filled[color] == true;
                  return Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: color)),
                      borderRadius: BorderRadius.circular(12),
                      color: isFilled ? color : color.withOpacity(0.3),
                    ),
                    child: isFilled
                        ? const Icon(Icons.check, color: Colors.white, size: 40)
                        : const SizedBox.shrink(),
                  );
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
