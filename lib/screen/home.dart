import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:rest_api/controller/deleteController.dart';
import 'package:rest_api/controller/postController.dart';
import 'package:rest_api/screen/detailScreen.dart';
import 'package:rest_api/service/api_service.dart';
import 'package:rest_api/models/postModel.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DeleteController _deleteController = Get.put(DeleteController());
    PostController  _postController = Get.find();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Rest Api")),
      body: Obx(
        (){
          PostListState state = _postController.postList.value;
          if(state is PostLoading){
            return Center(child: CircularProgressIndicator());

          }
         else if(state is PostSuccess){
              List<PostModel> list = state.postModel;
            return  ListView.builder(
              
              itemCount: list.length,
              itemBuilder: ((context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: (() {
                    Get.to(()=>DetailScreen(id: list[index].id ?? 0,title: list[index].title ?? "",));
                  }),
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical:5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Center(
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                       Text(list[index].title ?? "" ),
                    IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print("delete");
             
              // _deleteController.delete(list[index].id ?? 0 );

              // Obx(() {
              //   DeleteState deleteState = _deleteController.deleteState.value;
              //   if (deleteState == DeleteLoading) {
              //     return Center(child: CircularProgressIndicator());
              //   } else if (deleteState == DeleteSuccess) {
              //       return SizedBox();
              //   } 
                
              //   else if (deleteState == DeleteError) {
              //     return Text("Error");
              //   }
              //   return SizedBox();
              // });
            },
          )

                        ],)
                      
                    )),
                ),
              ));
              
            }));
          }
          else if(state is PostError){
            return Text("Error");
          }
          return SizedBox();
        }
      
      
      ),
      // body: FutureBuilder<List<PostModel>>(
      //   future:apiService.getAllPost() ,
      //   builder:((context, snapshot) {
      //     if(snapshot.hasData){
      //       return ListView.builder(
              
      //         itemCount: snapshot.data?.length,
      //         itemBuilder: ((context, index) {
      //         return Text(snapshot.data![index].title ?? "" );
              
      //       }));
      //     }
      //     else if(snapshot.hasError){
      //       return Text(snapshot.error.toString());

      //     }
      //     return CircularProgressIndicator();
      //   }) ),
    );
  }
}