import 'package:flutter/material.dart';

class ManualPage extends StatelessWidget {
  const ManualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.grey.shade800,
          appBar: AppBar(
            title: Text("how to play?"),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView( //how to  be responsive?
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'How to Play Tic Tac Toe',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Tic Tac Toe is a simple two-player game. The players take turns marking a square in a 3x3 grid.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row wins the game.',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'To make a move:',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.white70,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '1. Tap on an empty square to place your mark (X or O).',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  Text(
                    '2. The game continues until one player wins or the board is full (a tie).',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Have fun playing Tic Tac Toe!',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
