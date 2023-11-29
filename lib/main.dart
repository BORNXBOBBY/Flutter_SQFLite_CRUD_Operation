import 'package:flutter/material.dart';
import 'package:flutter_sqllite_crud_operation/widgets/dashboard.dart';

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "dashboard",
    routes: {
      'dashboard' : (context) => DashBoard(),
    },
  ));

}