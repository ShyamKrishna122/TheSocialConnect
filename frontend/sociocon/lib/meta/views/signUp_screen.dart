import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sociocon/app/routes/app.routes.dart';
import 'package:sociocon/core/notifiers/auth.notifier.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode userNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  void _onTap() {
    Navigator.of(context).pushReplacementNamed(LoginRoute);
  }

  bool _isLoading = false;

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    userNameFocusNode.dispose();
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
      registerUser();
    }
  }

  registerUser() async{
    var authenticationNotifier =
        Provider.of<AuthenticationNotifier>(context, listen: false);
    if (emailController.text.isNotEmpty &&
        userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      await authenticationNotifier.createAccount(
        context: context,
        userName: userNameController.text.trim(),
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
    return Scaffold(
      body: Stack(children: [
        Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "TheSocioCon",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
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
                        hintText: "userName",
                        border: InputBorder.none,
                        errorStyle: TextStyle(
                          height: 0,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: userNameController,
                      focusNode: userNameFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        emailFocusNode,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value!.isEmpty) return 'Fill this field';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: emailController,
                      focusNode: emailFocusNode,
                      onEditingComplete: () =>
                          FocusScope.of(context).requestFocus(
                        passwordFocusNode,
                      ),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) return 'Fill this field';
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
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
                      obscuringCharacter: "*",
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
                        if (value!.length < 8) {
                          return 'Password must be longer than 8 characters';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  MaterialButton(
                    child: Text(
                      'Sign Up',
                    ),
                    onPressed: () {
                      saveForm();
                    },
                  ),
                  SizedBox(
                    height: 20 * 1.5,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "Already have an account?",
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
                            text: " Sign In",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = _onTap,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (_isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
      ]),
    );
  }
}
