import 'package:washingmachine/model.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';

class Controller{
  final Model _model;

  Controller(this._model);

  void resetTimer(){
    _model.countdownController = CountdownController(duration: Duration(minutes: _model.timerMinutes));
  }

  void startTimer(){
    _model.countdownController.start();
  }

  void stopTimer(){
    _model.countdownController.stop();
  }

  bool isTimerRunning(){
    return _model.countdownController.isRunning;
  }

  CountdownController getTimer(){
    return _model.countdownController;
  }

  int getSpeed(){
    return _model.speed;
  }
  int getTemp(){
    return _model.temperature;
  }
}