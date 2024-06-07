import 'package:flutter/material.dart';
import 'package:task_manager/utils/app_route.dart';
import 'package:task_manager/view/widgets/background_widget.dart';

import '../../../utility/on_tap_action.dart';
import '../../../widgets/bottom_rich_text.dart';
import '../../../widgets/elevated_text_button.dart';
import 'custom_pin_code_text_field.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({super.key});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController pinVerificationTextEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundWidget(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),

                  ///------Header text------///
                  Text(
                    "PIN Verification",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(
                    height: 8,
                  ),

                  ///------Sub Header Text------///
                  Text(
                    "A 6 digit verification pin has sent to your email address.",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),

                  const SizedBox(
                    height: 18,
                  ),

                  ///------Pin Verification Input Field------///
                  Form(
                    key: _formKey,
                    child: CustomPinCodeTextField(
                      context,
                      pinVerificationTextEditingController,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),

                  ///------Verify Button------///
                  ElevatedTextButton(
                    text: "Verify",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        OnTapAction.onTapGoResetPasswordScreen(context);
                      }
                    },
                  ),

                  const SizedBox(
                    height: 40,
                  ),

                  ///------Sign in text------///
                  Center(
                    child: BottomRichText(
                      text01: "Have account?",
                      text02: "Sign In",
                      onTap: () => OnTapAction.onTapRemoveUntil(context, AppRoute.loginScreen),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    pinVerificationTextEditingController.dispose();
    super.dispose();
  }
}
