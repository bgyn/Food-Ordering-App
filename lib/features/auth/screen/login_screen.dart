import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_app/core/common/custom_text_field.dart';
import 'package:food_app/features/auth/controller/auth_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  int _index = 0;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signIn(
    WidgetRef ref,
  ) {
    ref.read(authControllerProvider.notifier).siginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context);
  }

  void logeIn(
    WidgetRef ref,
  ) {
    ref.read(authControllerProvider.notifier).loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                          _index = 0;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: _index == 0
                                ? BorderSide(
                                    width: 1.5,
                                    color: Theme.of(context).primaryColor)
                                : const BorderSide(color: Colors.transparent),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          emailController.clear();
                          passwordController.clear();
                          _index = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: _index == 1
                                    ? BorderSide(
                                        width: 1.5,
                                        color: Theme.of(context).primaryColor)
                                    : const BorderSide(
                                        color: Colors.transparent))),
                        child: Text(
                          'Sing-up',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFields(
                  textEditingController: emailController,
                  title: 'Email Address',
                  obscure: false,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CustomTextFields(
                  textEditingController: passwordController,
                  title: 'Password',
                  obscure: true,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Passcode?",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              onPressed: _index == 0 ? () => logeIn(ref) : () => signIn(ref),
              child: Text(
                _index == 0 ? 'Login' : 'Sign-up',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontSize: 16,
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
