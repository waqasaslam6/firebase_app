import 'package:firebase_app/Users.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum UserType{
  Admin,
  Staff,
  User
}

class ViewUsers extends StatefulWidget {
  @override
  _ViewUsersState createState() => _ViewUsersState();
}

class _ViewUsersState extends State<ViewUsers> {

  String url = "https://reqres.in/api/users?page=2";

  List<Datum> _users=[];
  int page;

  bool dataPresent = false;


  fetchUsers()async
  {
    // Request sent to URL for getting data
   var response =  await http.get(url,

       );

   if(response.statusCode == 200)
     {
       dataPresent = true;
       var users = response.body;
       var jsonData = usersFromJson(users);
        _users = jsonData.data;
        page = jsonData.page;


        setState(() {

        });
     }

   else{

     dataPresent = false;

     setState(() {

     });
   }



  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page == null?"No page found":page.toString()),
      ),

      body: Container(
        padding: EdgeInsets.all(5),
        child: Stack(
          children: [
            dataPresent?
            ListView.separated(
              itemCount: _users.length,
              scrollDirection: Axis.vertical,
              separatorBuilder: (context,int index)
              {
                return Divider(thickness: 2,);
              },
              itemBuilder: (context, int index)
              {
                return ListTile(
                  title: Text(_users[index].firstName +" "+ _users[index].lastName),
                  subtitle: Text(_users[index].email),
                  leading: Container(
                    width: 50,
                      child: ClipOval(
                          child: Image.network(_users[index].avatar))),
                );
              },
            ):
            Text("Data not found"),

          ],
        ),
      ),



    );
  }
}


