import 'package:api_crud/services/http_helper.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class PostEdit extends StatefulWidget {
  PostEdit(this.post, {Key? key}) : super(key: key);
  Map post;

  @override
  State<PostEdit> createState() => _PostEditState();
}

class _PostEditState extends State<PostEdit> {
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerBody = TextEditingController();

  @override
  initState() {
    super.initState();
    _controllerTitle.text = widget.post['title'];
    _controllerBody.text = widget.post['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _controllerTitle,
              ),
              TextFormField(
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
                        .updateItem(dataToUpdate, widget.post['id'].toString());

                    if (status) {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context)
                          .showSnackBar(const SnackBar(content: Text('Post updated')));
                    }
                    else
                      {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(content: Text('Failed to update the post')));
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