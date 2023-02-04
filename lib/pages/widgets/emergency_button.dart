import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyButton extends StatefulWidget {
  EmergencyButton();

  @override
  State<EmergencyButton> createState() => _EmergencyButtonState();
}

String _emergencyPhone = "";

class _EmergencyButtonState extends State<EmergencyButton> {
  @override
  void initState() {
    PatientController.getUserDetails(
            AuthenticationController.userPayload["patientId"].toString())
        .then(
      (response) {
        setState(() {
          _emergencyPhone = response['emergencyPhone'];
          _emergencyPhone =
              _emergencyPhone.substring(2, _emergencyPhone.length);
        });
      },
    );
  }

  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext bc) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Wrap(
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.6,
                            color: Color.fromARGB(255, 40, 40, 40),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 24.0),
                                      child: Icon(
                                        Icons.phone_in_talk,
                                        color: Colors.red,
                                        size: 128,
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                          child: Text(
                                        'Pressione para ligar para seu contato de emergência',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            Uri phoneno = Uri.parse(
                                                'tel:$_emergencyPhone');
                                            if (await launchUrl(phoneno)) {
                                              //dialer opened
                                            } else {
                                              //dailer is not opened
                                            }
                                          },
                                          child: Text('LIGAR',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          style: TextButton.styleFrom(
                                              fixedSize: const Size(120, 60),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                              ),
                                              backgroundColor: Colors.red))
                                    ],
                                  ),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              );
            });
      },
      backgroundColor: Color.fromARGB(255, 223, 2, 2),
      child: Icon(Icons.phone_in_talk),
    );
  }
}
