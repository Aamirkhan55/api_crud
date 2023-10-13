import 'package:api_crud/services/http_helper.dart';
import 'package:api_crud/view/post_edit.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class PostDetails extends StatelessWidget {
  PostDetails(this.itemId, {Key? key}) : super(key: key) {
    _futurePost = HttpHelper().getItem(itemId);
  }

  String itemId;
  late Future<Map> _futurePost;
  late Map post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => PostEdit(post)));
          }, icon: const Icon(Icons.edit)),
          IconButton(onPressed: () async{
            //Delete
            bool deleted=await HttpHelper().deleteItem(itemId);

            if(deleted)
              {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Post deleted')));
              }
            else
              {
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text('Failed to delete')));
              }
          }, icon: const Icon(Icons.delete)),
        ],
      ),
      body: FutureBuilder<Map>(
        future: _futurePost,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Some error occurred ${snapshot.error}'));
          }

          if (snapshot.hasData) {
            post = snapshot.data!;

            return Column(
              children: [
                Text(
                  '${post['title']}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('${post['body']}'),
              ],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}