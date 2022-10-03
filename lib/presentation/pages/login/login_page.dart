import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/data/providers/storage/local_storage.dart';
import 'package:getx_clean_arch/presentation/controllers/auth/auth_controller.dart';
import 'package:getx_clean_arch/presentation/widgets/app_dialog.dart';
import 'package:getx_clean_arch/presentation/widgets/app_text_field.dart';
import 'package:getx_clean_arch/presentation/widgets/custom_shake_widget.dart';
import 'package:getx_clean_arch/presentation/widgets/platform_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> _formKey;
  late GlobalKey<CustomShakeWidgetState> _emailState;
  late GlobalKey<CustomShakeWidgetState> _passwordState;
  late TextEditingController _phoneEditingController;
  late TextEditingController _passwordEditingController;

  final AuthController authController = Get.find();

  @override
  void initState() {
    _formKey = GlobalKey();
    _emailState = GlobalKey();
    _passwordState = GlobalKey();
    _phoneEditingController = TextEditingController(text: "");
    _passwordEditingController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailState.currentState?.dispose();
    _passwordState.currentState?.dispose();
    _phoneEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomShakeWidget(
              key: _emailState,
              child: AppTextFormField(
                controller: _phoneEditingController,
                hintText: 'Phone',
                validateEmptyText: 'Phone is required',
              ),
              shakeCount: 8,
              shakeOffset: 10,
            ),
            CustomShakeWidget(
              key: _passwordState,
              child: AppTextFormField(
                controller: _passwordEditingController,
                hintText: 'Password',
                validateEmptyText: 'Password is required',
              ),
              shakeCount: 8,
              shakeOffset: 10,
            ),
            Obx(
              () => authController.loading.value
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () async {
                        _login();
                      },
                      child: const Text('LOGIN'),
                    ),
            ),
            ElevatedButton(
              onPressed: () {
                LocalStorage.signOut();
              },
              child: const Text('LOGOUT'),
            ),
            PlatformButton().build(
              child: const Text('Show Dialog'),
              onPressed: () {
                scaleDialog(context,
                    title: 'Demo Dialog', content: 'Dialog Content', barrierDismissible: true, onConfirmClick: () {});
              },
            )
          ],
        ),
      ),
    );
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      _emailState.currentState?.shake();
      _passwordState.currentState?.shake();
    } else {
      authController.login(_phoneEditingController.text, _passwordEditingController.text);
    }
  }
}
