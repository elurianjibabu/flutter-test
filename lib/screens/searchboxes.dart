import 'package:cpa_ui/components/get_address.dart';
import 'package:cpa_ui/screens/map_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get/get_controller.dart';
import '../globals/colors.dart';
import '../widgets/text_widget.dart';

class SearchBoxes extends StatefulWidget {
  const SearchBoxes({super.key});
  @override
  State<SearchBoxes> createState() => _SearchBoxesState();
}

class _SearchBoxesState extends State<SearchBoxes> {
  final startAddressController = TextEditingController(text: 'vijayawada');
  final destinationAddressController = TextEditingController(text: 'hyderabad');
  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return GetBuilder<GetController>(
        init: GetController(),
        builder: (controller) {
          return SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    //Color.fromARGB(179, 249, 248, 248),
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  width: width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /*
                        const Text(
                          'CPA',
                          style: TextStyle(fontSize: 25.0),
                        ),
                        const SizedBox(height: 10),
                     */
                        textField(
                          label: 'Start',
                          hint: 'Choose starting point',
                          // prefixIcon: const Icon(Icons.looks_one),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.my_location),
                            onPressed: () {
                              controller.updateStartAddress(
                                  address: startAddressController.text);
                            },
                          ),
                          controller: startAddressController,
                          focusNode: startAddressFocusNode,
                          width: width,
                          locationCallback: (String value) {},
                        ),
                        const SizedBox(height: 10),
                        textField(
                            label: 'Destination',
                            hint: 'Choose destination',
                            //   prefixIcon: const Icon(Icons.looks_two),
                            controller: destinationAddressController,
                            focusNode: desrinationAddressFocusNode,
                            width: width,
                            locationCallback: (String value) {}),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            startAddressFocusNode.unfocus();
                            desrinationAddressFocusNode.unfocus();
                            controller.updateStartAddress(
                                address: startAddressController.text);
                            controller.updateDestAddress(
                                address: destinationAddressController.text);
                            await getaddressDetails();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Find Route'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                            visible: getController.getTotalDistance <= 0
                                ? false
                                : true,
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                'Total Distance is: ${getController.getTotalDistance.toStringAsFixed(2)} KM',
                                style: TextStyle(
                                    fontSize: 25, color: GetColor().black),
                              ),
                            )),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
