import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iot_agriculture/controller/home/home_states.dart';
import 'package:iot_agriculture/models/sensorsReadings_model.dart';
class HomeCubit extends Cubit<HomeState>{
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final _database=FirebaseDatabase.instance.ref();
   List sensorsReadings=[];
  void readSensorsReadings(){

    _database.child('ID-1').onValue.listen((event) {
      final data=event.snapshot.value! as Map<dynamic,dynamic>;
      SensorReadings readings=SensorReadings.fromMap(data);
         data.forEach((key, value) {sensorsReadings.add(value);});
           readings.sensorsReadingsList=sensorsReadings;
    emit(HomeReadSensorsSuccess(readings,),);
    });


  }


}