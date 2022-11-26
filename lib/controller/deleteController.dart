import 'package:get/get.dart';
import 'package:rest_api/controller/postController.dart';
import 'package:rest_api/models/delete.dart';
import 'package:rest_api/screen/bottomnav.dart';
import 'package:rest_api/service/api_service.dart';

class DeleteController extends GetxController{
   final  ApiService _apiService = Get.find();
    PostController _postController = Get.find();
   Rx<DeleteState> deleteState = DeleteState().obs;
   
   void delete (int id){
    deleteState.value = DeleteLoading();
    _apiService.deletePost(id).then((deletepost) {
      
      deleteState.value = DeleteSuccess(deletepost);
      _postController.getAllPost();

    }
    
    ).catchError(
      (e)=>
      deleteState.value = DeleteError()
    );
   }
   

}
class DeleteState {}
class DeleteLoading extends DeleteState{}
class DeleteSuccess extends DeleteState{
  final DeletePost deletePost;

  DeleteSuccess(this.deletePost);
}
class DeleteError extends DeleteState{}