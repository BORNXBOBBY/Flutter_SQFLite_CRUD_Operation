import 'package:flutter/material.dart';
import 'package:flutter_sqllite_crud_operation/widgets/viewpage.dart';

import 'Insert.dart';
import 'db_helper.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Text("SQFlite CRUD Operation") ,
      ),

      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InsertPage(),));
                },
                child: Text("Insert")),

            ElevatedButton(
                onPressed: () async{
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewPage(),));
                },
                child: Text("ViewPage Update and Delete")),

          ],
        ),
      ),

    );
  }
}