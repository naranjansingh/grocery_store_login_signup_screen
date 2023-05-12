import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cutkut/ui/loginPage/login.dart';

void main() => runApp(MaterialApp(
      title: 'cutkut',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.grey,
          accentColor: Colors.teal,
          fontFamily: 'nunito'),
      home: cutkutLogin(),
    ));
