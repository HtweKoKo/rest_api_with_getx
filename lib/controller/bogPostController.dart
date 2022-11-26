import 'package:get/get.dart';
import 'package:rest_api/models/blogPost.dart';
import 'package:rest_api/service/api_service.dart';

class BlogPostController extends GetxController{
  final ApiService _apiService = Get.find();
    Rx<BlogPostState> blogPostState = BlogPostState().obs;

    void getpost(int id ){
      blogPostState.value = BlogPostLoading();
      _apiService.getPost(id)
      .then((post){
        if(post.isNotEmpty) {
          blogPostState.value = BlogPostSuccess(post[0]);
        }
      })
      .catchError((e)=>
      blogPostState.value = BlogPostError()
      )
      ;
    } 

}
class BlogPostState {}
class BlogPostLoading extends BlogPostState{}
class BlogPostSuccess extends BlogPostState{
  final BlogPost post;

  BlogPostSuccess(this.post);
}
class BlogPostError extends BlogPostState{}