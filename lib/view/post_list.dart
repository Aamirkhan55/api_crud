import 'package:api_crud/services/http_helper.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PostList extends StatelessWidget {
 PostList({super.key});

  final Future<List<Map>> _futurPosts = HttpHelper().fetchItem();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Post List'),
      ),
      body: FutureBuilder<List<Map>>(
        future: _futurPosts, 
        builder: (BuildContext context, AsyncSnapshot snapshot){
          // Check f\For Error
          if(snapshot.hasError) {
            return Text('Some Error Occured ${snapshot.error}');
          }
          // Has Data Arrived
           if (snapshot.hasData) {
             List<Map> posts = snapshot.data;
             return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                Map thisItem = posts[index];
                return Card(
                  child: ListTile(
                    trailing: Text('${thisItem['id']}'),
                    title: Text('${thisItem['title']}'),
                    subtitle: Text('${thisItem['body']}'),
                     ),
                );
              }
              ); 
           }
          //Display Loader
           return const Center(
            child: CircularProgressIndicator(
            color: Colors.teal,
           ));
        }
        ),
    );
  }
}