import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_clone/utils/utils.dart';

class AuthMethods{
  final FirebaseAuth _auth  =FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> get authChanges => _auth.authStateChanges();

  User get user => _auth.currentUser!;


  Future<bool> signINWithGoogle(BuildContext context) async{
    bool res = false;
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;


      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(credential);


      User? user = userCredential.user;

      if(user!=null){
        if(userCredential.additionalUserInfo!.isNewUser){
            await _firestore.collection('users').doc(user.uid).set({
              'username':user.displayName,
              'uid':user.uid,
              'profilePhoto':user.photoURL,
            });
        }
        res = true;
      }
    }on FirebaseAuthException catch(e){
      showSnackBar(context, e.message.toString());
        res = false;
    }
    return res;
  }


  void signOut() async{
    GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      await _googleSignIn.disconnect();
      _auth.signOut();

    }catch(e){}
  }
}
//8015876307
//0400032246220