import 'package:flutter/material.dart';
import 'package:popshop/common_widgets/header_with_underline.dart';
import 'package:popshop/common_widgets/rounded_dark_button.dart';
import 'package:popshop/common_widgets/text_field_focus_elevation.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/popshop_scope.dart';
import 'package:popshop/models/user.dart';

class AuthScreen extends StatefulWidget {
  final AuthType authType;

  const AuthScreen({Key key, this.authType}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController brandNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool tosAgreed = false;
  bool loading = false;

  void handleError(String text) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  void _submit() async {
    User user;
    if (formKey.currentState.validate() == false) return;
    setState(() => loading = true);

    // User attempts signup
    if (widget.authType == AuthType.SIGNUP) {
      if (!tosAgreed) {
        handleError("Please accept ToS");
      }
      user = await RestDatasource()
          .signup(brandNameController.text, emailController.text,
          passwordController.text)
          .catchError((e) {
        handleError(e.message);
      });
    } else {
      user = await RestDatasource()
          .login(emailController.text, passwordController.text)
          .catchError((e) {
        handleError(e.message);
      });
    }
    if (user != null) PopshopScope.of(context).login(user, context);
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    String title, buttonText, switchAuthType;
    switch (widget.authType) {
      case AuthType.LOGIN:
        title = "Login to popshop";
        buttonText = "LOGIN";
        switchAuthType = "Sign up here";
        break;
      case AuthType.SIGNUP:
        title = "Brand Sign Up";
        buttonText = "SIGNUP";
        switchAuthType = "Already have an account?";
        break;
    }
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 64),
            shrinkWrap: true,
            children: [
              HeaderWithUnderline(
                title,
                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                lineMargin: 14,
                lineWidth: 70,
                lineHeight: 1.5,
              ),
              SizedBox(height: 48),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 16,
                        color: Colors.black.withOpacity(0.08),
                        offset: Offset(-10, 5))
                  ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 22.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(
                                width: 3,
                                color: Theme.of(context).primaryColor)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          if (widget.authType == AuthType.SIGNUP) ...[
                            TextFieldFocusElevation(
                              hint: "Brand Name",
                              textEditingController: brandNameController,
                            ),
                            SizedBox(height: 16),
                          ],
                          TextFieldFocusElevation(
                            hint: "Email Address",
                            textInputType: TextInputType.emailAddress,
                            textEditingController: emailController,
                          ),
                          SizedBox(height: 16),
                          TextFieldFocusElevation(
                            hint: "Password",
                            password: true,
                            textEditingController: passwordController,
                          ),
                          SizedBox(height: 8),
                          if (widget.authType == AuthType.LOGIN)
                            Align(
                              alignment: Alignment.centerRight,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      "Forgot?",
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 12),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 24),
                          RoundedDarkButton(
                            text: buttonText,
                            textSize: 16,
                            onTap: () {
                              _submit();
//                              if (formKey.currentState.validate()) _submit();
                            },
                            child: loading ? CircularProgressIndicator() : null,
                          ),
                          SizedBox(height: 8),
                          if (widget.authType == AuthType.SIGNUP)
                            Row(
                              children: [
                                Transform.scale(
                                  scale: 0.7,
                                  child: Checkbox(
                                    value: tosAgreed,
                                    onChanged: (b) {
                                      setState(() {
                                        tosAgreed = b;
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "By creating an account you agree to our ToS",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.black38),
                                  ),
                                )
                              ],
                            ),
                          Center(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    switchAuthType,
                                    style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (ctx) => AuthScreen(
                                                authType: widget.authType ==
                                                        AuthType.LOGIN
                                                    ? AuthType.SIGNUP
                                                    : AuthType.LOGIN,
                                              )));
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum AuthType { LOGIN, SIGNUP }
