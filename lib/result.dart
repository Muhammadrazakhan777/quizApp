import 'package:flutter/material.dart';
import 'package:quiz_app/home.dart';

class ResultPage extends StatefulWidget {
  int marks;
  ResultPage({Key key, @required this.marks}) : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState(marks);
}

class _ResultPageState extends State<ResultPage> {
  List<String> images = [
    'images/good.png',
    'images/bad.png',
    'images/success.png',
  ];
  String message;
  String image;
  @override
  void initState() {
    if (marks < 20) {
      image = images[1];
      message = 'you should try hard \n' + 'your score is $marks';
    } else if (marks > 30) {
      image = images[0];
      message = 'you are best\n ' + 'your score is $marks';
    } else {
      image = images[2];
      message = 'you are fail\n' + 'your score is $marks';
    }
    super.initState();
  }

  int marks;
  _ResultPageState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.indigo,
        title: Text('result'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Material(
              elevation: 10,
              child: Container(
                child: Column(
                  children: [
                    Material(
                      child: Container(
                        width: 300,
                        height: 300,
                        child: ClipRRect(
                          child: Image(
                            image: AssetImage(image),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Center(
                        child: Text(
                          message,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 7,
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.indigo,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
