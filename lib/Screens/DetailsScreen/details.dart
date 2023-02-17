import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:login_industrystandard/Screens/ImagePicker/imageselect.dart';
List <String> modal=["Email","Password","Favourite Time For Consuming Food","Purpose"];
class Details extends StatefulWidget {
  const Details({Key? key}) : super(key: key);
  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    List data=Get.arguments;
    print(data);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.6,
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context,index){
                      return
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          tileColor: Colors.blue,
                          title: Text(modal[index]),
                          subtitle: Text(data[index]),
                      ),
                        );

                    },
                    padding: const EdgeInsets.all(20),

                  ),
                ),
              ),
              ElevatedButton(onPressed: ()=>{
                Get.to(const ImageSelector())
              }, child: const Text("Select Image"))
            ],
          ),
        ),
      ),
    );
  }
}
