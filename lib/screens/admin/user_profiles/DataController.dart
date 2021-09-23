import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection('users')
    .where('firstName', isGreaterThanOrEqualTo: queryString)
    .get();
  }
}