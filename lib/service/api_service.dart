import 'package:dio/dio.dart';
import 'package:rest_api/controller/deleteController.dart';
import 'package:rest_api/models/blogPost.dart';
import 'package:rest_api/models/delete.dart';
import 'package:rest_api/models/postModel.dart';
import 'package:rest_api/models/upload.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screen/Upload.dart';

class ApiService {
  Dio dio = Dio();
  
  static const url = "https://rubylearner.herokuapp.com";
  
  ApiService(){
    dio.interceptors.add(LogInterceptor());
  }

  Future<List<PostModel>> getAllPost() async {
    var getlink = await dio.get("$url/posts");
    var postList =  getlink.data as List;
    var result = postList.map((post) => PostModel.fromjson(post)).toList();
    return result;
  }
  Future <List<BlogPost>> getPost(int id)async{
      var getLink = await dio.get("$url/post?id=$id");
      var postList = getLink.data as List;
      var result = postList.map((posts) =>
          BlogPost.fromJson(posts)
       ).toList();
       return result;

  }
  Future<DeletePost> deletePost(int id)async{
      var getlink = await dio.delete("$url/post?id=$id");
      // var postList = getlink.data as List;
      // var result = postList.map((post) => 
      // DeletePost.fromJson(post)
      // ).toList();
       DeletePost result = DeletePost.fromJson(getlink.data);
      return result;
  }
  Future<UpLoad> uploadPost({required String title,required String body,required FormData? photo,required Function(int, int) onSendProgress  })async{
    var getlink = await dio.post("$url/post?title=$title&body=$body",data: photo,onSendProgress:onSendProgress );
    UpLoad result = UpLoad.fromJson(getlink.data);
    return result;
  }


 
}
