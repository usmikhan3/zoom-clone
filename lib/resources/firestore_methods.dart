import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:zoom_clone/utils/utils.dart';


class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> get meetingsHistory =>  _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('meetings').snapshots();


  void addTOMeetingHistory(String meetingName) async {
    try {
      _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('meetings')
          .add({
        'meetingName': meetingName,
        'createdAt': DateTime.now(),
      });
    }on FirebaseAuthException catch (e) {
      print(e.message!);
    }
  }
}
