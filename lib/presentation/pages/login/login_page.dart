import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_clean_arch/data/providers/storage/local_provider.dart';
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
            GetBuilder<AuthController>(
              builder: (_) => authController.futureState.isLoading
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
                LocalProvider.signOut();
              },
              child: const Text('LOGOUT'),
            ),
            PlatformButton().build(
              child: const Text('Show Scale Dialog'),
              onPressed: () {
                scaleDialog(
                  context: context,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 200),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'This is a scale dialog',
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Colors.grey.shade700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  horizontalMargin: 12,
                  title: 'Demo Dialog',
                  barrierDismissible: true,
                  onConfirmClick: () {},
                  onCancelClick: () {},
                );
              },
            ),
            PlatformButton().build(
              child: const Text('Show Rotate Dialog'),
              onPressed: () {
                rotateDialog(
                  context: context,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 200),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'This is a rotate dialog',
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                                color: Colors.grey.shade700,
                              ),
                        ),
                      ),
                    ],
                  ),
                  horizontalMargin: 12,
                  title: 'Demo Dialog',
                  barrierDismissible: true,
                  onConfirmClick: () {},
                  onCancelClick: () {},
                );
              },
            ),
            PlatformButton().build(
              child: const Text('Show Translate Dialog'),
              onPressed: () {
                translateDialog(
                  context: context,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const FlutterLogo(size: 200),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'This is a translate dialog',
                          style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  startOffset: const Offset(0.0, 1.0),
                  horizontalMargin: 12,
                  title: 'Demo Dialog',
                  barrierDismissible: true,
                  onConfirmClick: () {},
                  onCancelClick: () {},
                );
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
