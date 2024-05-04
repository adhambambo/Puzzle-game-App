import 'package:flutter/material.dart';

void main() {
  runApp(MyPuzzleApp());
}

class MyPuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PuzzleScreen(),
    );
  }
}

class PuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PuzzleScreen(),
    );
  }
}

class PuzzleScreen extends StatefulWidget {
  @override
  _PuzzleScreenState createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  List<String> generatePuzzlePieces(int rows, int columns) {
    List<String> pieces = [];
    for (int i = 0; i < rows * columns; i++) {
      pieces.add('Piece ${i + 1}');
    }
    return pieces;
  }

  List<String> puzzlePieces = [];

  @override
  void initState() {
    super.initState();
    puzzlePieces = generatePuzzlePieces(4, 4);
    puzzlePieces.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puzzle Game'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    puzzlePieces.shuffle();
                  });
                },
                child: Text('Shuffle'),
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: puzzlePieces.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return Container(
                        width: 80.0,
                        height: 80.0,
                        color: Colors.grey,
                      );
                    },
                    onAccept: (data) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Piece placed correctly!'),
                      ));
                    },
                  );
                },
              ),
              SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                itemCount: puzzlePieces.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemBuilder: (context, index) {
                  return Draggable<String>(
                    data: puzzlePieces[index],
                    child: PuzzlePiece(piece: puzzlePieces[index]),
                    feedback: PuzzlePiece(piece: puzzlePieces[index], isBeingDragged: true),
                    childWhenDragging: Container(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PuzzlePiece extends StatelessWidget {
  final String piece;
  final bool isBeingDragged;

  const PuzzlePiece({required this.piece, this.isBeingDragged = false});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 80.0,
        height: 80.0,
        color: isBeingDragged ? Colors.blue : Colors.green,
        child: Center(
          child: Text(
            piece,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}