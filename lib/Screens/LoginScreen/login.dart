import 'package:flutter/material.dart';
import 'package:login_industrystandard/Constants/imageconstants.dart';
import 'package:login_industrystandard/Screens/DetailsScreen/details.dart';
import 'package:login_industrystandard/Screens/LoginScreen/Widgets/dropdownwidget.dart';
import 'package:get/get.dart';
const List<String> itemList = <String>["Tea", "Snacks", "Lunch", "Dinner"];
const List<String> purposelist = <String>[
  "Education",
  "Commercial",
  "Testing",
  "Other"
];
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? emailstring;
  String? passstring;
  String? purpose;
  String? food;

  @override
  Widget build(BuildContext context) {
    void purposecallback(value) {
      purpose = value;
      setState(() {});
      print(purpose);
    }

    void setfood(value) {
      food = value;
      setState(() {});
      print(food);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(bg_login), fit: BoxFit.fill)),
          ),
          Container(
            child: Text(
              "Login",
              style: TextStyle(fontSize: 32),
            ),
          ),
          Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Enter Your Email Address:"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (text) {
                        emailstring = text;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "Email",
                          label: Text("Email"),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("Enter Password:"),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      onChanged: (text2) {
                        passstring = text2;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          label: Text("Password"),
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Dropdownwidget(
                        itemList: itemList,
                        hint: "What Food You Like The Most",
                        onselect: setfood),
                    SizedBox(
                      height: 20,
                    ),
                    Dropdownwidget(
                        itemList: purposelist,
                        hint: "What's Your Purpose?",
                        onselect: purposecallback),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () => {
                              debugPrint(purpose),
                                  Get.to(Details(), arguments: [
                                    emailstring,
                                    passstring,
                                    food,
                                    purpose
                                  ])
                                },
                            child: Text("Submit")),
                      ],
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
