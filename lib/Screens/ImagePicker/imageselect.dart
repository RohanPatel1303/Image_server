import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
class ImageSelector extends StatefulWidget {
  const ImageSelector({Key? key}) : super(key: key);
  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final List<XFile> imagelist=[];
  List <String> base64images=[];

  openGallery()async{
    final XFile? selected_img=await ImagePicker().pickImage(source: ImageSource.camera);
    if(selected_img!=null)
    {
      imagelist.add(selected_img);
      setState(() {
      });
    }else{
      Get.dialog(
        AlertDialog(
          title: const Text("No Image Selected"),
          actions: [
            GestureDetector(
              onTap: (){
                Get.back();
              },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text("Okay",style: TextStyle(fontWeight: FontWeight.bold)),
                )
            )
          ],
          alignment: Alignment.center,
        )
      );
    }

  }
  postdata()async{
    if(imagelist!=null && imagelist.isNotEmpty){
      Get.dialog(
          Dialog(
            // The background color
            backgroundColor: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // The loading indicator
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 15,
                  ),
                  // Some text
                  Text('Loading...')
                ],
              ),
            ),
          ),
          barrierDismissible: false
      );
      base64images=[];
      imagelist.forEach((element) async{
        XFile image=element;
        Uint8List imagebyte=await element.readAsBytes();
        String base64=base64Encode(imagebyte);
        base64images.toList(growable: true);
        base64images.add(base64.toString());
        print(base64images.length);
      });
      Timer(Duration(seconds: 4), ()async {
        var url =Uri.https("webhook.site","01f12cc4-cd35-4822-ae93-ab8d9fa4f2f7");
        print(base64images.length);
        print("here it comes");
        var response=await http.post(url,body:jsonEncode(base64images));
        print(response.statusCode);
        print("finished");
        Get.back();
      });
    }else{
      Get.dialog(
        AlertDialog(
          title: Text("Please Select Image"),
        )
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Image Select Screen"),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(flex: 3,
              child: GridView.builder(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 40),
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

                              child: const Icon(Icons.cancel_rounded,color: Colors.red),
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
                    child:const Text("Select Images"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(onPressed: ()=>{
                    postdata()
                  },
                      child: const Text("Post Request"))
                ],
              ),
            )
          ],
        )
    );
  }
}
