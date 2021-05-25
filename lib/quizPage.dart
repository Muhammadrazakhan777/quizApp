import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/result.dart';

class GetJsonData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString('assets/python.json'),
      builder: (context, snapshot) {
        List myData = json.decode(snapshot.data.toString());
        if (myData == null) {
          return Scaffold(
            body: Center(
              child: Text('loading'),
            ),
          );
        } else {
          return QuizPage(myData: myData);
        }
      },
    );
  }
}

class QuizPage extends StatefulWidget {
  var myData;
  QuizPage({Key key, @required this.myData}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState(myData);
}

class _QuizPageState extends State<QuizPage> {
  var myData;
  _QuizPageState(this.myData);
  Color colorToShow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  int timer = 30;
  String showTimer = '30';
  Map<String, Color> btnColor = {
    'a': Colors.indigoAccent,
    'b': Colors.indigoAccent,
    'c': Colors.indigoAccent,
    'd': Colors.indigoAccent,
  };
  bool cancelTimer = false;
  @override
  void initState() {
    setTimer();
    super.initState();
  }

  void setTimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextQuestion();
        } else if (cancelTimer == true) {
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showTimer = timer.toString();
      });
    });
  }

  void nextQuestion() {
    cancelTimer = false;
    timer = 30;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ResultPage(marks: marks)));
      }
      btnColor['a'] = Colors.indigo;
      btnColor['b'] = Colors.indigo;
      btnColor['c'] = Colors.indigo;
      btnColor['d'] = Colors.indigo;
    });
    setTimer();
  }

  void checkAnswer(k) {
    if (myData[2]['1'] == myData[1]['1'][k]) {
      marks = marks + 5;
      colorToShow = right;
    } else {
      colorToShow = wrong;
    }
    setState(() {
      btnColor[k] = colorToShow;
      cancelTimer = true;
    });
    Timer(Duration(seconds: 2), nextQuestion);
  }

  Widget choiceButton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          myData[1][i.toString()][k],
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
          maxLines: 1,
        ),
        color: btnColor[k],
        splashColor: Colors.indigoAccent[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 40,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Quiz Expert'),
            content: Text(
              'You cannot go back at this atage',
            ),
            actions: [
              MaterialButton(
                child: Text(
                  'I understand what you want to say',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  myData[0][i.toString()],
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    choiceButton('a'),
                    choiceButton('b'),
                    choiceButton('c'),
                    choiceButton('d'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showTimer,
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
