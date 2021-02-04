

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dashboard extends StatefulWidget {
  final String userId;

  Dashboard({Key key, this.userId});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController taskName = new TextEditingController();

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();


 Future<dynamic> updateData(document)async{

    await FirebaseFirestore.instance.collection("tasks").doc(document.id).update({
      "name": taskName.text,
    });
    taskName.clear();
    showUpdateBtn = false;
    setState(() {

    });
  }

  saveTaskToFirebase() async {
    if (formKey.currentState.validate()) {
      FirebaseFirestore mStore = FirebaseFirestore.instance;

     // saving data based on document id.
     //  await mStore.collection("tasks").doc(widget.userId).set({
     //    "name": taskName.text,
     //  });


      //  saving data with random document id
      await mStore.collection("tasks").add({
        "name": taskName.text,
      });

      taskName.clear();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    taskName.dispose();
  }

  DocumentSnapshot doc;

 bool showUpdateBtn = false;


  Future<bool> _onBackPressed() async {
    // Your back press code here...
    showDialog(context: context,
        child: AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure ?"),
          actions: [
            MaterialButton(
              child: Text("Yes",
                style: TextStyle(
                    color: Colors.white
                ),),
              color: Theme.of(context).accentColor,
              onPressed: ()
              {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context)=>Login()
                ));
              },
            ),
            FlatButton(
              child: Text("No",
                style: TextStyle(
                    color: Colors.white
                ),),
              color: Colors.grey,
              onPressed: ()
              {
                Navigator.pop(context);
              },
            ),
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
        child: Scaffold(
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
                        child: GridView(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing:  10,
                            crossAxisSpacing: 10,
                          ),
                          children: snapshot.data.docs.map((document) {
                            doc = document;
                            return Card(
                             // margin: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(document["name"],
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: ()async{
                                              await FirebaseFirestore.instance.collection("tasks").doc(document.id).delete();
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: ()async{
                                              taskName.text = document["name"];
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
                              color: Colors.grey[300],
                              shadowColor: Colors.grey,
                            );
                          }).toList(),
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
        ),
      ),
    );
  }
}
