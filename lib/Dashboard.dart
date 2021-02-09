

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Dashboard extends StatefulWidget {
  final String userId;

  Dashboard({Key key, this.userId});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController taskName = new TextEditingController();
  TextEditingController taskDesc = new TextEditingController();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();


 Future<dynamic> updateData(document)async{

    await FirebaseFirestore.instance.collection("tasks").doc(document.id).update({
      "name": taskName.text,
      "description": taskDesc.text
    });
    taskName.clear();
    taskDesc.clear();
    showUpdateBtn = false;
    setState(() {

    });
  }

  String uploadURL;
  FirebaseFirestore mStore = FirebaseFirestore.instance;
  saveTaskToFirebase() async {
    if (formKey.currentState.validate()) {


     // saving data based on document id.
     //  await mStore.collection("tasks").doc(widget.userId).set({
     //    "name": taskName.text,
     //  });


      //  saving data with random document id
      await mStore.collection("tasks").add({
        "name": taskName.text,
        "description": "jhjk",
        "imagePath": uploadURL
      });

      taskName.clear();
      taskDesc.clear();
      showUpdateBtn = false;
      setState(() {

      });

    } else {
      Fluttertoast.showToast(
          msg: "Please enter some text",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  File _image;
  final picker = ImagePicker();

   pickImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }


    FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    Reference reference = firebaseStorage.ref().child("/images/"+DateTime.now().toString()+".png");

    UploadTask uploadTask = reference.putFile(_image);
    // download
    uploadTask.then((response) async {
      uploadURL= await response.ref.getDownloadURL();
    });



    setState(() {

    });
  }




  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskName.dispose();
  }

  DocumentSnapshot doc;

 bool showUpdateBtn = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        height: MediaQuery.of(context).size.height,
       // width: MediaQuery.of(context).size.width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _image !=null?
              Image.file(_image):
                  Container(height: 0,),
              MaterialButton(
                child: Text("Pick Image"),
                color: Colors.blue,
                onPressed: (){
                  pickImage();
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty) return "Enter something";
                  return null;
                },
                controller: taskName,
                decoration: InputDecoration(
                    hintText: "Enter a task", border: OutlineInputBorder()),
              ),
              SizedBox(height: 5,),
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('tasks').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context,int index)
                      {
                        return Card(
                          // margin: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipOval(
                                    child: Image.network("https://reqres.in/img/faces/7-image.jpg",
                                    scale: 1.5,),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(snapshot.data.docs[index]["name"],
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed: ()async{
                                          await FirebaseFirestore.instance.collection("tasks").doc(snapshot.data.docs[index].id).delete();
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.edit),
                                        onPressed: ()async{
                                           taskName.text = snapshot.data.docs[index]["name"];
                                           taskDesc.text = snapshot.data.docs[index]["description"];
                                          showUpdateBtn = true;
                                          setState(() {

                                          });
                                        },
                                      ),
                                    ],
                                  ),

                                ],
                              )
                            ],
                          ),
                          elevation: 8,
                          color: Colors.grey[200],
                          shadowColor: Colors.grey[300],
                        );
                      },
                    )
                  );
                },
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: saveTaskToFirebase,
                      child: Text("Save",
                      style: TextStyle(
                     fontSize: 18,
                     color: Colors.white,
                      ),),

                      color: Theme.of(context).primaryColor,
                    ),

                    showUpdateBtn ?
                    Row(
                      children: [
                        SizedBox(width: 15,),
                        MaterialButton(
                          onPressed: ()async{
                            updateData(doc);
                          },
                          child: Text("Update it",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),),
                          color: Colors.teal,
                        ),
                      ],
                    ):
                        Container(height: 0,)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
