import 'package:firebase_app/Dashboard.dart';
import 'package:firebase_app/Login.dart';
import 'package:firebase_app/Register.dart';
import 'package:firebase_app/ViewProducts.dart';
import 'package:firebase_app/ViewUsers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main()async
 {
   WidgetsFlutterBinding.ensureInitialized();
   //Firebase Databse Initilization code...
   await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Dashboard(),
  ));

}