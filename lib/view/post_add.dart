import 'package:api_crud/services/http_helper.dart';
import 'package:flutter/material.dart';

class PostAdd extends StatefulWidget {
  const PostAdd({Key? key}) : super(key: key);

  @override
  State<PostAdd> createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Add a title'
                ),
                controller: _controllerTitle,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'Add a body'
                ),
                controller: _controllerBody,
                maxLines: 5,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, String> dataToUpdate = {
                      'title': _controllerTitle.text,
                      'body': _controllerBody.text,
                    };

                    bool status = await HttpHelper()
                        .addItem(dataToUpdate);

                    if (status) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Post added')));
                    }
                    else
                    {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Failed to add the post')));
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}