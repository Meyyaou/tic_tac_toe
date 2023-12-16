import 'package:flutter/material.dart';
import 'package:tic_tac_toe/game_button.dart';
import 'dart:math';

import 'package:tic_tac_toe/manual_page.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int scoreX = 0;
  int scoreO = 0;
  int i = 0;
  String turn = "X";
  int totalGames = 0;
  bool Auto = false;
  bool fin = false;

  List listButton = <GameButton>[
    new GameButton(1),
    new GameButton(2),
    new GameButton(3),
    new GameButton(4),
    new GameButton(5),
    new GameButton(6),
    new GameButton(7),
    new GameButton(8),
    new GameButton(9)
  ];
  List<List<int>> winningConditions = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  void caseChangeColor(int x, int y, int z) {
    listButton[x].setColor(Colors.white);
    listButton[y].setColor(Colors.white);
    listButton[z].setColor(Colors.white);
  }

  void checkWinner() {
    // Check for a winner or a tie
    for (int i = 0; i < winningConditions.length; i++) {
      int a = winningConditions[i][0];
      int b = winningConditions[i][1];
      int c = winningConditions[i][2];

      if (listButton[a].play == listButton[b].play &&
          listButton[b].play == listButton[c].play &&
          listButton[a].play != "") {
        // We have a winner
        setState(() {
          caseChangeColor(a, b, c);
          fin = true; //pour boucler le jeu auto
          showWinnerDialog(listButton[a].play!);
        });

        return;
      }
    }

    // Check for a tie
    if (listButton.every((button) => button.play != "")) {
      fin = true;
      showWinnerDialog("Tie");
    }
  }

  void showWinnerDialog(String winner) {
    totalGames++;

    if (winner == "X") {
      scoreX++;
    } else if (winner == "O") {
      scoreO++;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          title: Text("Game Over", style: TextStyle(fontSize: 25)),
          content: Text(
            winner == "Tie" ? "It's a Tie!" : "Player $winner wins!",
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                start();
              },
              child: Text("Restart", style: TextStyle(fontSize: 25)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black12,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Text(
              "Player X : $scoreX \t\t\t\t\t\t\t\t\t\t\t Player O : $scoreO",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Auto Play:",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Switch(
                  value: Auto,
                  onChanged: (value) {
                    setState(() {
                      Auto = value;
                      if (Auto && turn == "X") {
                        AutoMode();
                      }
                    });
                  },
                ),
              ],
            ),
            GridView.builder(
                padding: EdgeInsets.all(3),
                shrinkWrap: true,
                //pour la centrer et eviter l'erreur renderbox not laid out
                physics: NeverScrollableScrollPhysics(),
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xD8DDEAE1))),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(20)),
                      onPressed: () {
                        setState(() {
                          if (Auto && turn == "X" && !fin) {
                            AutoMode();
                          }
                          if (!(listButton[index]?.played ?? false) && !fin) {
                            listButton[index].played = true;
                            listButton[index].play = turn;

                            if (turn == "X") {
                              turn = "O";
                              if (Auto) {
                                AutoMode();
                              }
                            } else {
                              turn = "X";
                            }
                            checkWinner();
                          }
                        });
                      },
                      child: Text(
                        listButton[index].play,
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                start();
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                color: Colors.white, // Adjust color as needed
                child: Text(
                  "Restart Game",
                  style: TextStyle(
                    color: Colors.black, // Adjust color as needed
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ]),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.question_mark, color: Colors.black),
            backgroundColor: Colors.white54,
            onPressed: () => {
              Navigator.push(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (_, __, ___) => ManualPage())) //le manuel
            },
          ),
        ));
  }

  void start() {
    setState(() {
      turn = "X";
      listButton.forEach((button) {
        button.played = false;
        button.play = "";
      });
      if (Auto && turn == "X") {
        AutoMode();
      }
    });
  }

  void AutoMode() {
    List<int> availableButtons = [];
    for (int i = 0; i < listButton.length; i++) {
      if (!listButton[i].played) {
        availableButtons.add(i);
      }
    }

    if (availableButtons.isNotEmpty) {
      int randomIndex = Random().nextInt(availableButtons.length);
      int selectedButtonIndex = availableButtons[randomIndex];

      listButton[selectedButtonIndex].played = true;
      listButton[selectedButtonIndex].play = turn;

      checkWinner();
      turn = "O";
    }
  }
}
