import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/shared_widget/default_form_field.dart';

import '../../../../features/users/presentation/pages/user_page.dart';
import '../../../../features/login/presentation/provider/login_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  static const String route = "login";
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DefaultFormField(
                controller: _emailController,
                hint: "E-mail",
                validatorFunction: (value) {
                  if (value!.isEmpty) {
                    return 'Enter valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              Consumer(
                builder: (context, ref, child) {
                  final userStatus = ref.watch(userLoginProvider).userStatus;
                  if (userStatus == LoginStatus.unauthenticated) {
                    return const Text(
                      "Please enter Valid Email",
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: GestureDetector(
                  onTap: () => _login(context),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
    } else {
      final loginStatus =
          await ref.read(userLoginProvider).login(email: _emailController.text);
      if (loginStatus == LoginStatus.authenticated) {
        context.goNamed(UserPage.route);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
