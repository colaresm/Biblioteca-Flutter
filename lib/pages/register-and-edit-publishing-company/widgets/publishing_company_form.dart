import 'package:flutter/material.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/controllers/book_controller.dart';
import 'package:libraryWDA/controllers/patient_controller.dart';
import 'package:libraryWDA/controllers/publishing_company_controller.dart';
import 'package:libraryWDA/models/publishing_company_list_item.dart';
import 'package:libraryWDA/pages/main/main_page.dart';
import 'package:libraryWDA/pages/widgets/cancel_button.dart';
import 'package:libraryWDA/pages/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:libraryWDA/main.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:get/get.dart';

class PublishingCompanyForm extends StatefulWidget {
  const PublishingCompanyForm({super.key});

  @override
  State<PublishingCompanyForm> createState() => _PublishingCompanyFormState();
}

TextEditingController _controllerDatePicker = new TextEditingController();

class _PublishingCompanyFormState extends State<PublishingCompanyForm> {
  final _formKey = GlobalKey<FormState>();
  var _publishingCompany = {
    "name": "",
  };

  requiredField(value) {
    if (value.isEmpty) return "Campo Obrigatório";
  }

  createPublishingComapany() {
    if (_formKey.currentState!.validate()) {
      PublishingCompanyController.create(_publishingCompany)
          .then((value) => {
                Get.snackbar('Sucesso', 'Editora cadastrada com sucesso',
                    backgroundColor: Colors.greenAccent,
                    borderWidth: 2,
                    icon: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                    colorText: Colors.white,
                    borderColor: Colors.white),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainPage("home", "", 0),
                  ),
                )
              })
          .catchError(
              (error) => Get.snackbar('Erro', 'Erro ao cadastrar editora',
                  backgroundColor: companyColors.shade600,
                  icon: Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                  borderWidth: 2,
                  colorText: Colors.white,
                  borderColor: Colors.white));
    }
  }

  backPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MainPage("home", "", 0),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text('Autor'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  labelText: 'Digite o nome da editora',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
              validator: (value) => requiredField(value),
              onChanged: (value) {
                _publishingCompany['name'] = value;
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Column(
                children: [
                  DefaultButton(
                      "FINALIZAR",
                      Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      createPublishingComapany),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: CancelButton(backPage),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
