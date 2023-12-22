import 'package:firebase_database/firebase_database.dart';
import 'package:iot_agriculture/core/network/end_points.dart';

class RemoteRepo {
  static final _fireStore = FirebaseDatabase.instance;

  static Stream<DatabaseEvent> getHomeData() {
     final Stream<DatabaseEvent> data = _fireStore.ref(AppEndPoints.homeData).onValue;
    return data;
  }

}
