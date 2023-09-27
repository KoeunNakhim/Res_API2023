import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:apiwithflutter/view/screen/details.dart';
import '../../model/resmodel.dart';
import 'details.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
   Future<NewsResModel> getData() async{
     final date = DateTime.now();
     final formattedDate = "${date.year}-${date.day}-${date.month}";
     var url = Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=$formattedDate&sortBy=publishedAt&apiKey=12e119617d90477aad9671b56e18a502');
     var response = await http.get(url);
     print(response.statusCode);
     var data = jsonDecode(response.body);
     return NewsResModel.fromJson(data);
     return data;
   }
   late Future<NewsResModel> _future;
   initData() async{
     _future = getData();
   }
   refreshData()async{
     setState(() {
       _future = getData();
     });
   }
   @override
  void initState() {
     initData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("HeLoo"),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError){
            return Center(
              child: Text("Something was wrong"),
            );
          }
          if(snapshot.hasData){
            return RefreshIndicator(
              onRefresh: (){
                return refreshData();
              },
              child: ListView.builder(
                itemCount: snapshot.data!.articles!.length,
                itemBuilder: (context ,index){
                final articale = snapshot.data!.articles![index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute (
                            builder:(context) => Detailscrenn(
                              title:articale.title!,
                              description:articale.description!,
                              urlToIamge:articale.urlToImage!,
                                publishedAT:articale.publishedAt!,
                            ), ),
                      );
                    },
                    child: ListTile(
                      title: Text(articale.title!),
                        subtitle:
                        Text(articale.description!),
                      leading: articale.urlToImage != null? Image.network(articale.urlToImage!)
                          : SizedBox(
                        width: 10,
                      )
                    ),
                  );
                }
              ),
            );
          }
          return Container();
        }
      )
    );
  }
}

