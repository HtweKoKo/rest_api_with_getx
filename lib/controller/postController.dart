 
import "package:get/get.dart";
import 'package:rest_api/service/api_service.dart';
import 'package:rest_api/models/postModel.dart';


 class PostController extends GetxController{
   final  ApiService _apiService = Get.find();
    Rx<PostListState> postList = PostListState().obs;
      @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAllPost();
  }
    void getAllPost(){
      postList.value = PostLoading();
      _apiService.getAllPost().then(
        (postLists){
        postList.value = PostSuccess(postLists);
    }).catchError(
          (e)=>postList.value = PostError()
        );
    }

 }
 class PostListState{}
 class PostLoading extends PostListState{}
 class PostSuccess extends PostListState{
    final List<PostModel> postModel;

  PostSuccess(this.postModel);

 }
 class PostError extends PostListState{}