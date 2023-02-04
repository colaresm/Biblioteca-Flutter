import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libraryWDA/controllers/recover_password_controller.dart';
import 'package:libraryWDA/models/recover_password.dart';
import 'package:libraryWDA/pages/recover_password/components/recover_password_component.dart';

class RecoverPasswordPage extends StatelessWidget {
  RecoverPasswordPage({super.key});

  final _controller = Get.put(RecoverPasswordController());

  void _changeStep(int step, RecoverPassword formField) async {
    if (step == 1) {
      await _controller.recoverPassword(formField).then((value) {
        if (value) {
          _controller.step = 2;
          _controller.actionText = 'Insira o código para recuperação';
          _controller.inputLabel = 'Código';
          _controller.update();
        }
      });
    } else if (step == 2) {
      await _controller.recoverPassword(formField).then((value) {
        if (value) {
          _controller.step = 3;
          _controller.actionText = 'Insira a nova senha';
          _controller.inputLabel = 'Nova senha';
          _controller.update();
        }
      });
    } else if (step == 3) {
      await _controller.recoverPassword(formField).then((value) {
        if (value) {
          _controller.step = 1;
          Get.toNamed('/recover-password-success');
          _controller.update();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: GetBuilder<RecoverPasswordController>(
          init: RecoverPasswordController(),
          builder: (_) {
            return RecoverPasswordComponent(
              step: _.step,
              actionText: _.actionText,
              inputTextLabel: _.inputLabel,
              changeStep: _changeStep,
            );
          },
        ),
      ),
    );
  }
}
