import 'package:firebase_app/Products.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class ViewProducts extends StatefulWidget {
  @override
  _ViewProductsState createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {



  void fetchProducts()async
  {
   final String url = "http://apps.qboxus.com/grocery/api/showAllProducts";

   var body = {
   };

   var response = await http.post(url,

   body: body

   );


   if(response.statusCode ==200)
     {

    var productsJson = response.body;

    var products = productsFromJson(productsJson);

     }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Products"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [



          ],
        ),
      )


    );
  }
}


