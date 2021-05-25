import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/quizPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> images = [
    'images/py.png',
    'images/js.png',
    'images/bad.png',
    'images/cpp.png',
    'images/good.pn',
    'images/java.png',
    'images/sucess.png',
  ];
  Widget costumCard(String langName, String image) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GetJsonData(),
          ));
        },
        child: Material(
          color: Colors.indigo,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(100.0),
                    child: Container(
                      height: 200,
                      width: 200,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    langName,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Python is an interpreted, object-oriented, high-level programming language with dynamic semantics. ... Python is simple, easy to learn syntax.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo,
          title: Text(
            'Quiz Expert',
            style: TextStyle(),
          ),
        ),
        body: Center(
          child: costumCard('pythom', images[0]),
        ));
  }
}
