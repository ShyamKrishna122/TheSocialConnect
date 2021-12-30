import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/notifiers/auth.notifier.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _onTap() {
    Navigator.of(context).pushReplacementNamed(
      SignUpRoute,
    );
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid)
      return;
    else {
      _formKey.currentState!.save();
      await loginUser();
    }
  }

  Future<void> loginUser() async {
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      await authenticationNotifier.loginUser(
        context: context,
        userEmail: emailController.text.trim(),
        userPassword: passwordController.text.trim(),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black87,
          content: Text(
            "Fill in the details",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 20 * 3,
                ),
                Text(
                  "TheSocioCon",
                ),
                SizedBox(
                  height: 20 * 3,
                ),
                Text(
                  "Sign In",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20 * 1.5,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * 0.75,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                        height: 0,
                      ),
                    ),
                    controller: emailController,
                    focusNode: emailFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(passwordFocusNode),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Fill this field';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20 * 1,
                ),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20 * 0.75,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: InputBorder.none,
                      errorStyle: TextStyle(
                        height: 0,
                      ),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Fill this field';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20 * 0.5,
                ),
                Spacer(),
                MaterialButton(
                  child: Text(
                    'Login',
                  ),
                  onPressed: () {
                    saveForm();
                  },
                ),
                SizedBox(
                  height: 20 * 1.5,
                ),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.64),
                      fontSize: 16,
                    ),
                    children: [
                      TextSpan(
                        text: " Sign Up",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()..onTap = _onTap,
                      ),
                    ],
                  ),
                ),
                Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
