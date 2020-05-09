import 'package:firebase_database/firebase_database.dart';
import 'package:ludoplay/utils/common.dart';

void setupLocator() {
  //Database
  locator.registerLazySingleton(() => FirebaseDatabase());
}
