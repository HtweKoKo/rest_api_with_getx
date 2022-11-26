import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rest_api/controller/uploadController.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  GlobalKey<FormState> _key = GlobalKey();
  UpLoadController _upLoadController = Get.put(UpLoadController());
  ImagePicker _picker = ImagePicker();
   File? _image;
    String? _title,_body;
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(title: Text("UpLoad")),
      body: Obx((){
          UploadState uploadState = _upLoadController.uploadState.value;
          if(uploadState is UploadLoading){
            return Center(child:
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              
                Text("uploading Please wait....${( _upLoadController.percentage *100).toInt()}"),
                Divider(),
                CircularProgressIndicator(value: ( _upLoadController.percentage *100))
              
            ],)
            );
          }
          else if(uploadState is UploadSuccess){
            return Text(uploadState.upload.result ?? "");
          }

        return Form(
          key: _key,
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text("Enter Title"),
                  TextFormField(
                    onSaved: (title){
                      _title = title;
                    },
                    validator: ((title) { 
                    if(title == null || title.isEmpty){
                      return "Enter title";
                    }
                    }
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Enter Body"),
                  TextFormField(
                    maxLines: 5,
                    minLines: 2,
                    onSaved: (body){
                      _body = body;
                    },
                    validator: ((title) { 
                    if(title == null || title.isEmpty){
                      return "Enter body";
                    }
                    }
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Select an image"),
                      IconButton(
                        onPressed: ()async{
                         final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
                          if(image !=null){
                            setState(() {
                            _image = File(image.path);
                              
                            });
                          }
                        },
                      icon: Icon(Icons.image),),
                      (_image == null) ? SizedBox() : Image.file(_image!,height: 200,),
            
                      ElevatedButton(onPressed: ()async{
                        d.MultipartFile? multipartFile ;
                         d.FormData? formData;
                        if(_image != null){
                          multipartFile =await d.MultipartFile.fromFile(_image!.path,filename: "image.png") ;
                        }
                        if(_key.currentState !=null && _key.currentState!.validate()){
                          _key.currentState!.save();
                          if(multipartFile != null){
                              formData = d.FormData.fromMap(
                            {"photo": multipartFile}
                          );
                          }
                        _upLoadController.uploadPost(title: _title ?? "", body: _body ?? "", photo: formData);
                        }
            
                      }, 
                      child: Text("upload"))
                ],
              ),
            ),
          ) ,
            );
      }),
    );
  }
}