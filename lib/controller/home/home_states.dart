import 'package:iot_agriculture/models/sensorsReadings_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeReadSensorsSuccess extends HomeState {
  HomeReadSensorsSuccess(this.readings,
      );
  SensorReadings readings;




}
class HomeReadSensorsLoadingState extends HomeState{}