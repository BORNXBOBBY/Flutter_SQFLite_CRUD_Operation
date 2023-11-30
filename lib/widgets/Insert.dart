import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import 'db_helper.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {

  File? _image;
  final ImagePicker _picker = ImagePicker();

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var contactController = TextEditingController();

  Future getImageGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(
        title: Text("Insert Data insqlite Crud"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.all(25),
                      child: Text(
                          "Regestration Form",
                          style:TextStyle(fontWeight: FontWeight.bold,fontSize: 23) ),
                    ),
                  ],
                ),
              ),

              Center(
                child: InkWell(
                  onTap: () {
                    getImageGallery();
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: _image != null
                        ? Image.file(_image!.absolute)
                        : Center(child: Icon(Icons.image)),
                  ),
                ),
              ),


              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Name",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: TextField(
                  controller: contactController,
                  decoration: InputDecoration(
                    hintText: "Contact",
                  ),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(15),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_image != null) {
                      // Save the image to the app's documents directory
                      final appDocDir = await getApplicationDocumentsDirectory();
                      final imagePath = '${appDocDir.path}/image_${DateTime.now().millisecondsSinceEpoch}.png';
                      await _image!.copy(imagePath);

                      // Insert record into SQLite with the image path
                      await DatabaseHelper.instance.insertRecord({
                        DatabaseHelper.columnName: nameController.text,
                        DatabaseHelper.columnEmail: emailController.text,
                        DatabaseHelper.columnContact: contactController.text,
                        DatabaseHelper.columnImagePath: imagePath,
                      });

                      Navigator.of(context).pop();
                    }
                  },
                  child: Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}