class SensorReadings {


   SensorReadings({
     required this.sensor1Reading,
    required this.sensor2Reading,
    required this.sensor3Reading,
    required this.sensor4Reading,
    required this.sensor5Reading,
    required this.sensor6Reading,
    required this.sensor7Reading,
    required this.sensor8Reading,
    required this.sensor9Reading,

  });

  factory SensorReadings.fromMap(Map<dynamic, dynamic> map) {

    return SensorReadings(
      sensor1Reading: map['Sensor1'] ?? '',
      sensor2Reading: map['Sensor2'] ?? '',
      sensor3Reading: map['Sensor3'] ?? '',
      sensor4Reading: map['Sensor4'] ?? '',
      sensor5Reading: map['Sensor5'] ?? '',
      sensor6Reading: map['Sensor6'] ?? '',
      sensor7Reading: map['Sensor7'] ?? '',
      sensor8Reading: map['Sensor8'] ?? '',
      sensor9Reading: map['Sensor9'] ?? '',
    );
  }


  final  sensor1Reading;
  final  sensor2Reading;
  final  sensor3Reading;
  final  sensor4Reading;
  final  sensor5Reading;
  final  sensor6Reading;
  final  sensor7Reading;
  final  sensor8Reading;
  final  sensor9Reading;
  late List sensorsReadingsList=[];
}
