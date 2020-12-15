import 'dart:async';

import 'package:flutter/material.dart';
import 'package:washingmachine/controller.dart';
import 'package:washingmachine/model.dart';


class View extends StatefulWidget {
  final Model _model;
  Controller _controller;

  View(this._model) {
    _controller = Controller(_model);
  }
  @override
  ViewState createState() => ViewState(_controller);
}

class ViewState extends State<View> {
  Timer _timer;
  int seconds = 0;
  int minutes = 0;
  int hours = 0;

  Controller _controller;
  ViewState(this._controller);
  bool timerActive = true;

  @override
  void initState(){
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), _onTimeChange);
  }

  void _onTimeChange(Timer timer){
    setState(() {
      seconds = _controller.getTimer().currentRemainingTime.sec;
      minutes = _controller.getTimer().currentRemainingTime.min;
      hours = _controller.getTimer().currentRemainingTime.hours;
      if (seconds == null) seconds = 0;
      if (minutes == null) minutes = 0;
      if (hours == null) hours = 0;
      timerActive = _controller.isTimerRunning();
    });
  }

  void timerState() {
    setState(() {
      _controller.isTimerRunning()
          ? _controller.stopTimer()
          : _controller.startTimer();
      timerActive = _controller.isTimerRunning();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
              hours.toString() + ":" + minutes.toString() + ":" + seconds.toString(),
          style: TextStyle(
            color: Colors.cyan,
            fontSize: 40,
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    _controller.getSpeed().toString(),
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
                    _controller.getTemp().toString(),
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
              GestureDetector(
                child: Icon(
                  (timerActive
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline),
                  color: (_controller.isTimerRunning()
                      ? Colors.orange
                      : Colors.green),
                  size: 100.0,
                ),
                onTap: () {
                  timerState();
                },
              ),
              GestureDetector(
                child: Icon(
                  Icons.stop,
                  color: Colors.red,
                  size: 100.0,
                ),
                onTap: () {
                  _timer.cancel();
                  Navigator.pop(context);
                  _controller.resetTimer();
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}
