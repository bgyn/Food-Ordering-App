import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/custom_text_field.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';

class ForgotPasscode extends ConsumerStatefulWidget {
  const ForgotPasscode({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ForgotPasscodeState();
}

class _ForgotPasscodeState extends ConsumerState<ForgotPasscode> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void resetPasscode(
      {required String email,
      required WidgetRef ref,
      required BuildContext context}) {
    ref
        .read(authControllerProvider.notifier)
        .resetPasscode(email: email, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Reset Passcode",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Colors.black, fontSize: 24),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextFields(
                  textEditingController: emailController,
                  title: 'Email',
                  obscure: false),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                onPressed: () => resetPasscode(
                  email: emailController.text.trim(),
                  ref: ref,
                  context: context,
                ),
                child: Text(
                  'Reset Passcode',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontSize: 16,
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
