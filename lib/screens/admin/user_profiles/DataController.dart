import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  Future queryData(String queryString) async {
    String newQueryString = (queryString.replaceAll(' ','')).toUpperCase();
    return FirebaseFirestore.instance.collection('users')
    .where('firstName', isGreaterThanOrEqualTo: newQueryString)
    .get();
  }
}