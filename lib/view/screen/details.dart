import 'package:flutter/material.dart';
 class Detailscrenn extends StatelessWidget {
    Detailscrenn({super.key,
      required this.title,
      required this.description,
      required this.urlToIamge,
      required this.publishedAT,});
   final String title;
   final String description;
   final String urlToIamge;
   final String publishedAT;
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('$title'),
       ),
       body: SingleChildScrollView(
         child: Column(
           children: [
                 Image.network('$urlToIamge'),
                 Text('$description',style: TextStyle(fontSize: 18),),
                 Text('$publishedAT',style: TextStyle(fontSize: 18),),
               ],
             ),
         ),
       );
   }
 }
