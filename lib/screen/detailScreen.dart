import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rest_api/controller/bogPostController.dart';
import 'package:rest_api/models/blogPost.dart';
import 'package:rest_api/service/api_service.dart';

import '../controller/deleteController.dart';

class DetailScreen extends StatefulWidget {
  final int id;
  final String title;
  const DetailScreen({required this.id, required this.title});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final ApiService _apiService = Get.find();
  DeleteController _deleteController = Get.put(DeleteController());

  final BlogPostController _blogPostController = Get.put(BlogPostController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _blogPostController.getpost(widget.id);
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteController.delete(widget.id);
              Obx(() {
                DeleteState deleteState = _deleteController.deleteState.value;
                if (deleteState == DeleteLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (deleteState == DeleteSuccess) {
                    return Center(child: Text("delete"),);
                } 
                
                else if (deleteState == DeleteError) {
                  return Text("Error");
                }
                return SizedBox();
              });
            },
          )
        ],
      ),
      body: Obx(() {
        BlogPostState blogPostState = _blogPostController.blogPostState.value;
        if (blogPostState is BlogPostLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (blogPostState is BlogPostSuccess) {
          BlogPost post = blogPostState.post;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(child: Text(post.title ?? "")),
                Divider(),
                Center(child: Text(post.body ?? "")),
                Divider(),
                (post.photo == null)
                    ? SizedBox()
                    : Image.network(
                        "${ApiService.url}/${post.photo}",
                        height: 200,
                      )
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}
