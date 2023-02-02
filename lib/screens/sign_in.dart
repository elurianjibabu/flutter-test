// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cpa_ui/components/validators.dart';
import 'package:cpa_ui/screens/sign_up.dart';
import 'package:flutter/material.dart';

import '../components/text_widget.dart';

class DriverSignIn extends StatefulWidget {
  const DriverSignIn({Key? key}) : super(key: key);

  @override
  State<DriverSignIn> createState() => _DriverSignInState();
}

class _DriverSignInState extends State<DriverSignIn> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  var signupkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var screenWidth = screenSize.width;
    var screenHeight = screenSize.height;
    return Form(
      key: signupkey,
      child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Container(
                // padding: EdgeInsets.all(8), // Border width
                decoration: BoxDecoration(
                    color: Colors.white, shape: BoxShape.rectangle),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(90), // Image radius
                  child: Image.asset(
                    'assets/cpa.jpeg',
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              TextWidget(
                controller: username,
                label: 'Email or Phone',
                validator: (value) {
                  var type = int.tryParse(value!);
                  bool isValid = mailValidator.hasMatch(value);
                  var runtimeType = type.runtimeType;
                  if (value.isEmpty) {
                    return 'required';
                  } else if (runtimeType == Null && !isValid) {
                    //email
                    return 'bad email format';
                  } else if (runtimeType == int && value.length != 10) {
                    //phone
                    return '10 digits required';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              TextWidget(
                controller: password,
                label: 'Password',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password required';
                  } else if (!passwordValidator.hasMatch(value)) {
                    return 'password should contain minimum 8 characters\n1 special, 1 number, 1 Uppercase and 1 lowercase ';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        'forgot password ? ',
                        style: TextStyle(fontSize: 16),
                      ))
                ],
              ),
              SizedBox(
                height: screenHeight * .02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * .07,
                    //width: screenWidth * .1,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black)),
                      onPressed: () {
                        signupkey.currentState!.validate();
                      },
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    child: Text(
                      '-----or-----',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * .01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Need an Account?',
                    style: TextStyle(fontSize: 20),
                  ),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DriverSignup(),
                        ),
                      );
                      //signup screen
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}
