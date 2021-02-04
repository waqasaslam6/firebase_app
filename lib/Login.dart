import 'package:firebase_app/Dashboard.dart';
import 'package:firebase_app/Register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final FirebaseAuth mAuth = FirebaseAuth.instance;

  String errorMessage;
  String userId;

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  User user;
  submitData() async {
    if (formKey.currentState.validate()) //check if the form is validated
    // all the text boxes are not empty. then form validate
    {
      String email = emailController.text;
      String password = passController.text;

      try {
        final User user = (await mAuth.signInWithEmailAndPassword(
                email: email, password: password))
            .user;

        if (user != null) {
          userId = user.uid;

          Fluttertoast.showToast(
              msg: "Login Success",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP_RIGHT,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);


          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Dashboard(
            userId: userId,
          )));
        }
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
            msg: "Invalid Login Details",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP_RIGHT,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        print('Failed with error code: ${e.code}');
        print(e.message);
      }
    } else {
      print("Form is inValid");
    }
  }


  Future<bool> _onBackPressed() async {
    // Your back press code here...

    SystemNavigator.pop();
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          leading: Container(height: 0,),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextFormField(
                    controller: emailController,
                    validator: (value) {
                      if (value.isEmpty) return "Email is required";
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                  ),
                  TextFormField(
                    controller: passController,
                    validator: (val) {
                      if (val.isEmpty) return "Password is required";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width / 2,
                    onPressed: submitData,
                    child: Text("Login"),
                    textColor: Colors.white,
                    color: Theme.of(context).primaryColor,
                    shape: StadiumBorder(),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>Register()
                      ));
                    },
                    child: Text("Don't have an account? Register"),
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
