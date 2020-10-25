import 'package:flutter/material.dart';
class GamePage extends StatefulWidget {
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  List<String> listXo = ["", "", "", "", "", "", "", "", "", ""];
  List<bool> listXoPress= [false,false ,false, false, false, false, false, false, false, false];
  bool xOControl = true; //first control x
  var textStyle = TextStyle(fontSize: 21, color: Color(0xFF7a4841));
  int scoreX=0;
  int scoreO=0;
  int filledBox=0;
  bool winControl=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF090a14),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top:40),
              child: Padding(
                padding: const EdgeInsets.only(left:30.0,right: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Player X",
                          style: textStyle,
                        ),
                        Text(
                          scoreX.toString(),
                          style: textStyle,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Player O",
                          style: textStyle,
                        ),
                        Text(
                          scoreO.toString(),
                          style: textStyle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if(!listXoPress[index]){
                          _onTap(index);
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border:
                            Border.all(color: Color(0xFF4d2b32), width: 2)),
                        child: Center(
                          child: Text(
                            listXo[index],
                            style:
                            TextStyle(fontSize: 40, color: Color(0xFF7a4841)),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(4),
              child: Column(
                children: [
                  Text("Tic Tac Toe",style:TextStyle(color:Color(0xFF7a4841),fontSize: 30,),),
                  Text("Good Games",style:TextStyle(color:Color(0xFF7a4841),fontSize: 15,fontStyle: FontStyle.italic),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) {
    setState(() {
      if (xOControl && listXo[index] == "") {
        listXo[index] = "X";
        listXoPress[index]=true;
        filledBox+=1;
      } else if (!xOControl && listXo[index] == "") {
        listXo[index] = "O";
        listXoPress[index]=true;
        filledBox+=1;
      }
      xOControl = !xOControl;
      _winnerCheck();
    });
  }

  void _winnerCheck() {
    // checks 1st row
    if (listXo[0] == listXo[1] && listXo[0] == listXo[2] && listXo[0] != "") {
      _showWinDialog(listXo[0]);
      winControl=true;
    }

    // checks 2nd row
    if (listXo[3] == listXo[4] && listXo[3] == listXo[5] && listXo[3] != "") {
      _showWinDialog(listXo[3]);
      winControl=true;
    }

    // checks 3rd row
    if (listXo[6] == listXo[7] && listXo[6] == listXo[8] && listXo[6] != "") {
      _showWinDialog(listXo[6]);
      winControl=true;
    }

    // checks 1st column
    if (listXo[0] == listXo[3] && listXo[0] == listXo[6] && listXo[0] != "") {
      _showWinDialog(listXo[0]);
      winControl=true;
    }

    // checks 2nd column
    if (listXo[1] == listXo[4] && listXo[1] == listXo[7] && listXo[1] != "") {
      _showWinDialog(listXo[1]);
      winControl=true;
    }

    // checks 3rd column
    if (listXo[2] == listXo[5] && listXo[2] == listXo[8] && listXo[2] != "") {
      _showWinDialog(listXo[2]);
      winControl=true;
    }

    // checks diagonal
    if (listXo[6] == listXo[4] && listXo[6] == listXo[2] && listXo[6] != "") {
      _showWinDialog(listXo[6]);
      winControl=true;
    }

    // checks diagonal
    if (listXo[0] == listXo[4] && listXo[0] == listXo[8] && listXo[0] != "") {
      _showWinDialog(listXo[0]);
      winControl=true;
    }
    else if(filledBox==9 && winControl==false) {
      _showDrawDialog();
    }
  }

  _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Draw",
                style: TextStyle(color: Color(0xFF090a14)),
              ),
            ),
            backgroundColor: Colors.white70,
            actions: [
              FlatButton(
                  onPressed: (){
                    _gameBoardClear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Play Again!",style: textStyle))
            ],
          );
        });
  }

  _showWinDialog(String value) {
    showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Winner is:" + value,
                style: TextStyle(color: Color(0xFF090a14)),
              ),
            ),
            backgroundColor: Colors.white70,
            actions: [
              FlatButton(
                  onPressed: (){
                    _gameBoardClear();
                    Navigator.of(context).pop();
                  },
                  child: Text("Play Again!",style: textStyle))
            ],
          );
        });

    if(value=="X") scoreX+=1;
    else if(value=="O") scoreO+=1;
  }

  void _gameBoardClear(){
    setState(() {
      for(int i=0;i<9;i++){
        listXo[i]="";
        listXoPress[i]=false;
      }
    });
    filledBox=0;
    winControl=false;
  }
}