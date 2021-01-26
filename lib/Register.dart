import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController emailController =  new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();


   final FirebaseAuth mAuth = FirebaseAuth.instance;
   final FirebaseFirestore mFireStore = FirebaseFirestore.instance;


  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  submitData()async
  {
    if(formKey.currentState.validate()) //check if the form is validated
      // all the text boxes are not empty. then form validate
        {
          String email = emailController.text;
          String password = passController.text;
          String name = nameController.text;
          String phone = phoneController.text;


          // register a user
          final User user = (await mAuth.createUserWithEmailAndPassword(email: email, password: password)).user;

          print(user.email+" has been registered");

          // save user data in firestore database
         await mFireStore.collection("users").doc(user.uid).set({
           "name": name,
           "phone": phone,
           "email": email,
           "password": password
         });




    }

    else
    {
      print("Form is inValid");

    }



  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height*0.7,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20)
              )
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: (value)
                  {
                    if(value.isEmpty)
                      return "Full name is required";
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Full name"
                  ),
                ),
                TextFormField(
                  controller: phoneController,
                  validator: (value)
                  {
                    if(value.isEmpty)
                      return "Phone is required";
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Phone"
                  ),
                ),
                TextFormField(
                  controller: emailController,
                  validator: (value)
                  {
                    if(value.isEmpty)
                      return "Email is required";
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Email"
                  ),
                ),
                TextFormField(
                  controller: passController,
                  validator: (val)
                  {
                    if(val.isEmpty)
                      return "Password is required";
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password"
                  ),
                ),
                MaterialButton(
                  minWidth: MediaQuery.of(context).size.width/2,
                  onPressed: submitData,
                  child: Text("Register"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                ),

                FlatButton(
                  onPressed: (){

                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>Login()
                    ));
                  },
                  child: Text("Already Registered? Login"),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


}
