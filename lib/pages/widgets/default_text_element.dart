import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:intl/intl.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class DefaultFormElement extends StatefulWidget {
  TextEditingController _controller;
  String labelText;
  String featureKey;
  Function updateField;
  DefaultFormElement(
      this._controller, this.labelText, this.featureKey, this.updateField);

  @override
  State<DefaultFormElement> createState() => _DefaultFormElementState(
      this._controller, this.labelText, this.featureKey, this.updateField);
}

class _DefaultFormElementState extends State<DefaultFormElement> {
  TextEditingController _controller;
  String labelText;
  String featureKey;
  Function updateField;
  _DefaultFormElementState(
      this._controller, this.labelText, this.featureKey, this.updateField);
  dateToBrazilianFormat(date) {
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(date);
  }

  requiredField(value) {
    if (value == null || value.isEmpty) return "Campo Obrigatório";
  }

  validateCPF(value) {
    if (!CPFValidator.isValid(value) || value == "") return "CPF inválido";
  }

  validatePhone(String value) {
    if (value.length < 15) return 'Telefone inválido';
  }

  validadeRG(String value) {
    if (value.length < 12) return 'RG inválido';
  }

  validadeCEP(String value) {
    if (value.length < 9) return 'CEP inválido';
  }

  getMask(feature) {
    switch (feature) {
      case 'cpf':
        return [MaskedInputFormatter('###.###.###-##')];

      case 'rg':
        return [
          MaskTextInputFormatter(
              mask: '##########-#',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];

      case 'firstPhone':
        return [
          MaskTextInputFormatter(
              mask: '(##) #####-####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];

      case 'emergencyPhone':
        return [
          MaskTextInputFormatter(
              mask: '(##) #####-####',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];
      case 'cep':
        return [
          MaskTextInputFormatter(
              mask: '#####-###',
              filter: {"#": RegExp(r'[0-9]')},
              type: MaskAutoCompletionType.lazy)
        ];

      default:
        return [MaskedInputFormatter('###############################')];
    }
  }

  getValidator(value, feature) {
    switch (feature) {
      case 'cpf':
        return validateCPF(value);
      case 'email':
        return validateCPF(value);
      case 'firstPhone':
        return validatePhone(value);
      case 'emergencyPhone':
        return validatePhone(value);
      case 'rg':
        return validadeRG(value);
      case 'cep':
        return validadeCEP(value);
      default:
        return requiredField(value);
    }
  }

  var _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  Widget getFormElement(String value) {
    switch (value) {
      case 'BIRTHDATE':
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Form(
              child: TextFormField(
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                labelText: labelText,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
            controller: _controller,
            readOnly: true,
            onTap: () async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1930),
                  initialDate: DateTime.now(),
                  lastDate: DateTime.now());
              if (date != null) {
                _controller.text = dateToBrazilianFormat(date);
                updateField(date, featureKey, true);
              }
            },
          )),
        );

      default:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: getMask(featureKey),
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 23, right: 23, top: 20, bottom: 20),
                    labelText: labelText,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                controller: _controller,
                validator: (value) => getValidator(value, featureKey),
                onChanged: (value) {
                  updateField(
                      value, featureKey, _formKey.currentState!.validate());
                },
              )),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return getFormElement(featureKey.toUpperCase());
  }
}
