import 'package:cpa_ui/components/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'homepage.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otp = TextEditingController();
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: key,
            child: Column(
              children: [
                TextWidget(
                  controller: otp,
                  label: 'Enter OTP',
                  validator: ((val) {
                    if (val!.isEmpty) return 'required';
                    return null;
                  }),
                ),
                ElevatedButton(
                  onPressed: () async {
                    bool valid = key.currentState!.validate();
                    if (valid) {
                      print('object');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    }
                    return;
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
