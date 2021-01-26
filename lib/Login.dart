import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController =  new TextEditingController();
  TextEditingController passController = new TextEditingController();

  final FirebaseAuth mAuth = FirebaseAuth.instance;


  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  submitData()async
  {
    if(formKey.currentState.validate()) //check if the form is validated
      // all the text boxes are not empty. then form validate
        {
      String email = emailController.text;
      String password = passController.text;

     final User user = (await mAuth.signInWithEmailAndPassword(email: email, password: password)).user;

      if(user != null)
        {
          print(user.email);
          print("Login success");
        }
      else
        {

          print("login failed");
        }







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
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height/2,
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
                  child: Text("Login"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  shape: StadiumBorder(),
                ),

                FlatButton(
                  onPressed: (){
                  Navigator.pop(context);

                  },
                  child: Text("Don't have an account? Register"),

                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


}
