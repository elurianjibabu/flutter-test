import 'package:cpa_ui/components/validators.dart';
import 'package:cpa_ui/components/text_widget.dart';
import 'package:cpa_ui/globals/variables.dart';
import 'package:cpa_ui/model/user_model.dart';
import 'package:cpa_ui/screens/otp.dart';
import 'package:cpa_ui/services/add_user.dart';
import 'package:flutter/material.dart';

var signUpKey = GlobalKey<FormState>();

class DriverSignup extends StatefulWidget {
  const DriverSignup({Key? key}) : super(key: key);

  @override
  State<DriverSignup> createState() => _DriverSignupState();
}

class _DriverSignupState extends State<DriverSignup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController phone = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: signUpKey,
          child: Padding(
              padding: const EdgeInsets.all(25),
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Sign Up',
                      style: getWhiteBoldStyle(fontSize: 30),
                    ),
                  ),
                  TextWidget(
                    controller: email,
                    label: 'Email Id',
                    validator: (value) {
                      bool valid = mailValidator.hasMatch(value!);

                      if (value.isEmpty) {
                        return 'required';
                      } else if (!valid) {
                        return 'email must be in @ format';
                      }
                      return null;
                    },
                  ),
                  TextWidget(
                    controller: phone,
                    label: 'Phone No',
                    inputType: TextInputType.phone,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'required';
                      } else if (val.length != 10) {
                        return 'number should be 10 digits';
                      }
                      return null;
                    },
                  ),
                  TextWidget(
                    controller: password,
                    label: 'Password',
                    validator: (str) {
                      bool valid = passwordValidator.hasMatch(str.toString());
                      if (str!.isEmpty) {
                        return 'required';
                      } else if (!valid || str.length < 8) {
                        return 'password should contain minimum 8 characters\n1 special, 1 number, 1 Uppercase and 1 lowercase ';
                      }
                      return null;
                    },
                  ),
                  TextWidget(
                    controller: confirmPassword,
                    label: 'confirm Password',
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'required';
                      } else if (confirmPassword.text != password.text) {
                        return "passwords doesn't match";
                      }
                      return null;
                    },
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: width * .5,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: loading
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black)),
                              child: Text(
                                'Sign Up',
                                style: getWhiteBoldStyle(color: Colors.white),
                              ),
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });

                                if (!signUpKey.currentState!.validate()) {
                                  // return;
                                } else {
                                  int? number = int.parse(phone.text);
                                  var user = User(
                                    firstName: confirmPassword.text,
                                    email: email.text,
                                    password: password.text,
                                    phoneNumber: number,
                                    id: null,
                                  );
                                  await ApiService()
                                      .registerUser(user: user)
                                      .then((value) async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const OTPScreen(),
                                      ),
                                    );
                                  });
                                }
                                setState(() {
                                  loading = false;
                                });
                                return;
                              },
                            ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
