import 'package:flutter_countdown_timer/countdown_controller.dart';

class Model {
  int timerMinutes = 1;
  String mode;
  int temperature;
  int speed;
  CountdownController countdownController;

  Model(this.timerMinutes,this.mode,this.temperature,this.speed);


}