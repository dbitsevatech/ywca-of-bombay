import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  Future getData(String collection) async {
    // final FirebaseFireStore firebaseFirestore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = 
    await FirebaseFirestore.instance.collection(collection).get();
    return snapshot.docs;
  }

  Future queryData(String queryString) async {
    return FirebaseFirestore.instance.collection('users')
    .where('firstName', isGreaterThanOrEqualTo: queryString)
    .get();
  }
}