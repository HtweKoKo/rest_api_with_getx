

import 'package:get/get.dart';
import 'package:rest_api/controller/postController.dart';
import 'package:rest_api/screen/bottomnav.dart';
import 'package:rest_api/service/api_service.dart';
import 'package:dio/dio.dart' as d;

import '../models/upload.dart';

class UpLoadController extends GetxController{
  ApiService _apiService = Get.find();
  PostController _postController = Get.find();
  RxDouble percentage = 0.0.obs;
    Rx<UploadState> uploadState = UploadState().obs;
    
    void uploadPost({required String title,required String body,required d.FormData? photo}){

      uploadState.value = UploadLoading();
      _apiService.uploadPost(title: title, body: body, photo: photo, 
      onSendProgress: (send,data){
        percentage.value = send/data;
      }
      ).
      then((uploadrespone) {
      uploadState.value = UploadSuccess(uploadrespone);
      Future.delayed(Duration(seconds: 1));
      Get.off(()=>BottomNav());
       _postController.getAllPost();
      uploadState.value = UploadState();
     
      }
      ).catchError((e)=>
      uploadState.value = UploadError()
      );
    }

}
class UploadState {}
class UploadLoading extends UploadState{}
class UploadSuccess extends UploadState{
  final UpLoad upload;

  UploadSuccess(this.upload);

  
}
class UploadError extends UploadState{}