import 'package:flutter/material.dart';
import 'package:washingmachine/controller.dart';
import 'package:washingmachine/model.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:washingmachine/view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Washing machine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Controll panel'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
    final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Model initValue = Model(140, "Стандартний режим бавовна", 60, 1400);
  Model model = Model(140, "Стандартний режим бавовна", 60, 1400);
  Controller controller;

  void createController(Model model){
    controller = Controller(model);
  }
//  Model(140, "Стандартний режим бавовна", 60, 1400);
//  MODES.add();
//  MODES.add("Стандартний режим бавовна 60гр 1400 о хв 140хв");
//  MODES.add("Делікатне прання 30гр 700 обх 90хв");
//  MODES.add("Прискорене прання 60гр 1400 обх 60хв");

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                DropdownButton<Model>(
                  value: initValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (Model newValue) {
                    setState(() {
                      model = newValue;
                    });
                  },
                  items: <Model>[initValue,Model(90, "Делікатне прання", 30, 700), Model(60, "Прискорене прання", 60, 1400)]
                      .map<DropdownMenuItem<Model>>((Model value) {
                    return DropdownMenuItem<Model>(
                      value: value,
                      child: Text(value.mode.toString()),
                    );
                  }).toList(),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      model.speed.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.cyan
                      ),
                    ),
                    Text(
                      " об/хв",
                      style: TextStyle(
                        fontSize: 20,
                        //color: Colors.deepOrangeAccent
                      ),
                    ),
                  ],
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      model.temperature.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.deepOrangeAccent
                      ),
                    ),
                    Text(
                      " градусів ℃",
                      style: TextStyle(
                          fontSize: 20,
                          //color: Colors.deepOrangeAccent
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      model.timerMinutes.toString(),
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.greenAccent
                      ),
                    ),
                    Text(
                      " хвилин",
                      style: TextStyle(
                        fontSize: 20,
                        //color: Colors.deepOrangeAccent
                      ),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              child: Icon(
                Icons.play_circle_outline,
                size: 100.0,
                color: Colors.green,
              ),
              onTap: () {
                createController(model);
                controller.resetTimer();
                controller.startTimer();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => View(model)),
                );
              },
            )
          ],
        )
      ),
    );
  }
}
