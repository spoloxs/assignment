import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(File file) async {
    final firebaseStorage = FirebaseStorage.instance;
        var snapshot = firebaseStorage.ref()
        .child('images/imageName')
        .putFile(file);
        String downloadURL = await (await snapshot).ref.getDownloadURL();
        return (downloadURL);
}

uploadData(String text, String downloadURL) async{
    final json = {
      "name": text,
      "image": downloadURL,
      };

    await FirebaseFirestore.instance.collection("data").doc("User").set(json);
}

Future<DocumentSnapshot<Map<String, dynamic>>> getData() async{
  final documentSnapshot = FirebaseFirestore.instance.collection("data").doc("User");
  return(documentSnapshot.get());
}