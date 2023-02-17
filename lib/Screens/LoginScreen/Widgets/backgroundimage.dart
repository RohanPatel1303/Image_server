import 'package:flutter/cupertino.dart';
import 'package:login_industrystandard/Constants/imageconstants.dart';

class BackgroundImage extends StatefulWidget {
  const BackgroundImage({Key? key}) : super(key: key);

  @override
  State<BackgroundImage> createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(bg_login),fit: BoxFit.cover)
      ),
    );
  }
}
