import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_industrystandard/Screens/LoginScreen/login.dart';

class ImageSelector extends StatefulWidget {
  const ImageSelector({Key? key}) : super(key: key);

  @override
  State<ImageSelector> createState() => _ImageSelectorState();
}

class _ImageSelectorState extends State<ImageSelector> {
  final List<XFile> imagelist=[];
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
    print("here we go");
  Uint8List bytecon;
  String img64;
    imagelist.map((element) async =>{
      debugPrint("helloo"),
      bytecon=await element.readAsBytes(),
      img64=base64Encode(bytecon),
      debugPrint(img64)
    });
    imagelist.forEach((element) {
      bytecon=element.readAsBytes() as Uint8List;
      print(base64Encode(bytecon));
    });
    var data=imagelist.first.readAsBytes().toString();
    var response=await http.post(Uri.https('webhook.site','4eedcb56-738f-4d67-bcf3-a512dc5f6fdb'),body: {
      "name":data
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
