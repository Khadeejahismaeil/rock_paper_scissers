import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //This declares a class named MyApp that extends the StatelessWidget class.
  //This means the UI built by this class won't change dynamically based on state updates.

  const MyApp({super.key});
  //This is the constructor of the MyApp class.
  //It takes an optional argument named super.key which is required by StatelessWidget for key management.

  @override
  Widget build(BuildContext context) {
    //build  method is called whenever the widget needs to rebuild its UI.
    //It takes a BuildContext as input, which provides information about the widget's location.

    return MaterialApp(
      //Inside the build method, the code returns a MaterialApp widget.
      //This widget is the foundation for most Flutter applications using Material Design principles.
      //It provides various features like app bar, navigation, themes, and more etc...
      debugShowCheckedModeBanner: false,
      //disables the debug banner.

      title: 'Rock Paper Scissors', //the title of the app

      theme: ThemeData(
        //This defines the theme for the app.
        primarySwatch: Colors.orange, //set to orange
      ),
      home: const MyHomePage(),
      // MyHomePage class is set as the initial screen where the UI will be built.
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage class as a subclass of StatefulWidget
  const MyHomePage({super.key}); // It takes an optional key parameter
  //which is used to identify the widget in the widget tree.

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  //It's responsible for creating and returning a state object associated with the MyHomePage widget.
  //it creates an instance of the _MyHomePageState class, which will manage the state of the MyHomePage widget.
}

class _MyHomePageState extends State<MyHomePage> {
  String player1Choice = 'rock';
  String player2Choice = 'rock';
  String result = 'both are winners';
  //the variables store the current choices of players and outcome.

  List<String> choices = ['rock', 'paper', 'scissors'];
//This list contains the possible game options
  void play() {
    //This function is triggered when the "Play" button is pressed
    setState(() {
      // method to update the UI whenever the game state changes
      player1Choice = choices[Random().nextInt(choices.length)];
      player2Choice = choices[Random().nextInt(choices.length)];
      //randomly assigned values from the choices list
      result = _getWinner(player1Choice, player2Choice);
      //stores the game's outcome in the result variable
    });
  }

  String _getWinner(String player1, String player2) {
    //This function takes the choices of both players as input and returns the game result.
    /*It uses a series of if-else statements to compare the choices and determine the winner based on the rock-paper-scissors rules:
If the choices are the same, it's a tie ("both are winners").
Otherwise, it checks each player's choice and the other player's choice:
If a player chooses "rock" and the other chooses "scissors", the first player wins.
Similar logic applies for paper vs. rock and scissors vs. paper.*/
    if (player1 == player2) {
      return 'both are winners';
    } else if (player1 == 'rock') {
      if (player2 == 'scissors') {
        return 'Player 1 Wins!';
      } else {
        return 'Player 2 Wins!';
      }
    } else if (player1 == 'paper') {
      if (player2 == 'rock') {
        return 'Player 1 Wins!';
      } else {
        return 'Player 2 Wins!';
      }
    } else {
      // player1 == 'scissors'
      if (player2 == 'paper') {
        return 'Player 1 Wins!';
      } else {
        return 'Player 2 Wins!';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //provides the overall layout
      backgroundColor: const Color.fromARGB(255, 255, 244, 228),
      appBar: AppBar(
        //defines the app bar with a title, centered text, and an orange background
        title: const Text('Rock Paper Scissors',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),

      body: Center(
        /*body contains a Center widget that positions the game elements in the center:
          A Text widget displays the current result.
          A Row layout holds two columns for each player:
          Each column contains an Image.asset widget that displays the chosen image using string.
          A Text widget displays "player1" and "player2" below the image.
          An ElevatedButton with styled background and text allows the user to play the game again.*/
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Image.asset(
                      'assets/images/$player1Choice.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    const Text("player1")
                  ],
                ),
                const SizedBox(width: 100),
                Column(
                  children: [
                    Image.asset(
                      'assets/images/$player2Choice.png',
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text("player2")
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: play,
              child: const Text(
                'Play',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.orange),
                shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
