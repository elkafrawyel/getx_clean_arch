import 'package:flutter/material.dart';
import 'package:getx_clean_arch/presentation/pages/login_screen/animations/change_screen_animation.dart';
import 'auth_content.dart';
import 'wrapWithAnimatedBuilder.dart';

class TopText extends StatefulWidget {
  const TopText({Key? key}) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const BackButton(),
            Text(
              ChangeScreenAnimation.currentScreen == Screens.createAccount ? 'Create Account' : 'Login',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
