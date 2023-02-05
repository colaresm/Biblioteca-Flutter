import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/authentication_controller.dart';
import 'package:libraryWDA/main.dart';
import 'package:libraryWDA/models/user_authenticate.dart';

class LoginForm extends StatefulWidget {
  bool screenWidth;

  LoginForm({super.key, required this.screenWidth});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final _controller = Get.put(AuthenticationController());
  final Map<String, String> _formData = {};
  bool _rememberMe = false;

  Widget gap() => const SizedBox(height: 16);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Seja bem vindo',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 35,
                  color: Colors.black),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Text(
                'Faça login em sua conta',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                    color: companyColors.shade50),
              ),
            ),
            TextFormField(
              onSaved: (value) => _formData['email'] = value!,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                var text = value!.trim();
                if (value == null || text.isEmpty) {
                  return 'Campo obrigatório';
                }
                bool _emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(text);
                if (!_emailValid) {
                  return 'Email inválido';
                }
                return null;
              },
              style: TextStyle(fontSize: 18, color: companyColors.shade50),
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  label: Text('Email'),
                  hintText: 'Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
            gap(),
            TextFormField(
              obscureText: true,
              onSaved: (value) => _formData['password'] = value!,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                var text = value!.trim();
                if (value == null || text.isEmpty) {
                  return 'Campo obrigatório';
                }
                if (value.length < 6) {
                  return 'Senha deve conter pelo menos 6 caracteres';
                }
                return null;
              },
              style: TextStyle(fontSize: 18, color: companyColors.shade50),
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.only(left: 23, right: 23, top: 20, bottom: 20),
                  label: Text('Senha'),
                  hintText: 'Senha',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)))),
            ),
            gap(),
            CheckboxListTile(
              checkColor: companyColors.shade100,
              activeColor: companyColors.shade400,
              value: _rememberMe,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value!;
                });
              },
              title: Text(
                'Lembre-me',
                style: TextStyle(fontSize: 18, color: companyColors.shade50),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              dense: true,
              contentPadding: const EdgeInsets.all(0),
            ),
            gap(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    )),
                child: const Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    'ENTRAR',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState!.save();
                    await _controller.login(
                        UserAuthenticate(
                            username: _formData['email'],
                            password: _formData['password']),
                        _rememberMe);
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 20),
              child: TextButton(
                onPressed: () => Get.toNamed('/recover-password'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: companyColors.shade200),
                child: Text(
                  'Esqueci minha senha',
                  style: TextStyle(
                      fontSize: 16, decoration: TextDecoration.underline),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
