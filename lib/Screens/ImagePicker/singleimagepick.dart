import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SingleImagePick extends StatefulWidget {
  const SingleImagePick({Key? key}) : super(key: key);

  @override
  State<SingleImagePick> createState() => _SingleImagePickState();
}

class _SingleImagePickState extends State<SingleImagePick> {
  final List<XFile> imagelist=[];
  List <String> base64images=[];

  openGallery()async{
    final XFile? selected_img=await ImagePicker().pickImage(source: ImageSource.camera);
    if(selected_img!=null)
    {
      imagelist.add(selected_img);
      setState(() {
      });
    }

  }
  postdata()async{
    print("start");
    // print(imagelist.first);
    // XFile image=imagelist.first;
    // Uint8List imagebyte=await image.readAsBytes();
    // String base64=base64Encode(imagebyte);
    // print(base64);
    imagelist.forEach((element) async {
      base64images=[];
      XFile image=element;
      Uint8List imagebyte=await element.readAsBytes();
      String base64=base64Encode(imagebyte);
      base64images.toList(growable: true);
      base64images.add(base64.toString());
      print(base64images);


    });
    // print(base64images);
    Timer(Duration(seconds: 4), ()async {
      var url =Uri.https("webhook.site","4eedcb56-738f-4d67-bcf3-a512dc5f6fdb");
      print(base64images.length);
      print("here it comes");
      var response=await http.post(url,body:jsonEncode(base64images));
      print(response.statusCode);
      print("finished");
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Select Screen"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 3,
              child: GridView.builder(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 40),
                  itemCount: imagelist.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return
                      Stack(
                        children: [
                          Image.file(File(imagelist[index].path),fit: BoxFit.fill,),
                          Positioned(
                            right: 30,
                            child: GestureDetector(

                              child: Icon(Icons.cancel_rounded,color: Colors.red),
                              onTap: ()=>{
                                imagelist.toList(growable: true),
                                imagelist.removeAt(index),
                                // itemList.removeAt(0),
                                setState(() {

                                })
                              },
                            ),
                          )


                        ],
                      );
                  }),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  ElevatedButton(onPressed: ()=>{
                    openGallery()

                  },
                    child:Text("Select Images"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: ()=>{
                    postdata()
                  },
                      child: Text("Post Request"))
                ],
              ),
            )

          ],
        )
    );
  }
}
