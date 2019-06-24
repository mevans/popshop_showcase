//import 'package:flutter/material.dart';
//import 'package:popshop/auth.dart';
//import 'package:popshop/common_widgets/header_with_underline.dart';
//import 'package:popshop/common_widgets/rounded_dark_button.dart';
//import 'package:popshop/common_widgets/text_field_focus_elevation.dart';
//import 'package:popshop/data/database_helper.dart';
//import 'package:popshop/models/popshop_scope.dart';
//import 'package:popshop/models/user.dart';
//import 'package:popshop/screens/auth/login_screen_presenter.dart';
//import 'package:popshop/screens/auth/signup_screen.dart';
//import 'package:popshop/screens/communities_list/communities_list_page.dart';
//
//class LoginScreen extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    return LoginScreenState();
//  }
//}
//
//class LoginScreenState extends State<LoginScreen>
//    implements LoginScreenContract, AuthStateListener {
//  BuildContext _ctx;
//  final formKey = GlobalKey<FormState>();
//  final scaffoldKey = GlobalKey<ScaffoldState>();
//  TextEditingController emailController, passwordController;
//  LoginScreenPresenter _presenter;
//
//  @override
//  void initState() {
//    super.initState();
//    _presenter = LoginScreenPresenter(this);
//    var authStateProvider = AuthStateProvider();
//    authStateProvider.subscribe(this);
//    emailController = TextEditingController();
//    passwordController = TextEditingController();
//  }
//
//  void _submit() {
//    final form = formKey.currentState;
//    if (form.validate()) {
//      form.save();
//      _presenter.doLogin(emailController.text, passwordController.text);
//    }
//  }
//
//  void _showSnackBar(String text) {
//    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(text)));
//  }
//
//  @override
//  onAuthStateChanged(AuthState state) {
//    if (state == AuthState.LOGGED_IN && _ctx != null && mounted) {
//      Navigator.of(_ctx).pushReplacement(
//          MaterialPageRoute(builder: (ctx) => CommunitiesListPage()));
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      key: scaffoldKey,
//      backgroundColor: Colors.white,
//      body: Form(
//        key: formKey,
//        child: Center(
//          child: ListView(
//            padding: EdgeInsets.symmetric(vertical: 64),
//            shrinkWrap: true,
//            children: [
//              HeaderWithUnderline(
//                "Login to popshop",
//                textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
//                lineMargin: 14,
//                lineWidth: 70,
//                lineHeight: 1.5,
//              ),
//              SizedBox(height: 48),
//              Padding(
//                padding: const EdgeInsets.symmetric(horizontal: 48.0),
//                child: Container(
//                  decoration: BoxDecoration(boxShadow: [
//                    BoxShadow(
//                        blurRadius: 16,
//                        color: Colors.black.withOpacity(0.08),
//                        offset: Offset(-10, 5))
//                  ]),
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(24),
//                    child: Container(
//                      padding:
//                          EdgeInsets.symmetric(vertical: 36, horizontal: 22.5),
//                      decoration: BoxDecoration(
//                        color: Colors.white,
//                        border: Border(
//                            left: BorderSide(
//                                width: 3,
//                                color: Theme.of(context).primaryColor)),
//                      ),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.stretch,
//                        children: <Widget>[
////                        Text(
////                          "LOGIN",
////                          style: TextStyle(
////                              fontFamily: 'Monserrat',
////                              fontSize: 16,
////                              fontWeight: FontWeight.w400,
////                              color: Color(0xff263238)),
////                        ),
////                        SizedBox(height: 32),
//                          TextFieldFocusElevation(
//                            hint: "Email Address",
//                            onTap: () {
////                            formKey.currentState.reset();
//                            },
//                            textEditingController: emailController,
//                          ),
//                          SizedBox(height: 16),
//                          TextFieldFocusElevation(
//                            hint: "Password",
//                            onTap: () {
//                              print("On tap");
////                            formKey.currentState.reset();
//                            },
//                            textEditingController: passwordController,
//                          ),
//                          SizedBox(height: 8),
//                          Align(
//                            alignment: Alignment.centerRight,
//                            child: Material(
//                              color: Colors.transparent,
//                              child: InkWell(
//                                onTap: () {},
//                                child: Padding(
//                                  padding: const EdgeInsets.all(4.0),
//                                  child: Text(
//                                    "Forgot?",
//                                    style: TextStyle(
//                                        color: Colors.black38, fontSize: 12),
//                                  ),
//                                ),
//                              ),
//                            ),
//                          ),
//                          SizedBox(height: 24),
//                          RoundedDarkButton(
//                            text: "LOGIN",
//                            textSize: 16,
//                            onTap: () {
//                              if (formKey.currentState.validate()) _submit();
//                            },
//                          ),
//                          SizedBox(height: 8),
//                          Center(
//                            child: Material(
//                              color: Colors.transparent,
//                              child: InkWell(
//                                child: Padding(
//                                  padding: const EdgeInsets.all(8.0),
//                                  child: Text(
//                                    "Sign up here",
//                                    style: TextStyle(
//                                      color: Colors.deepOrange,
//                                      fontSize: 12,
//                                    ),
//                                  ),
//                                ),
//                                onTap: () {
//                                  Navigator.pushReplacement(
//                                      context,
//                                      MaterialPageRoute(
//                                          builder: (ctx) => SignupScreen()));
//                                },
//                              ),
//                            ),
//                          )
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//
////  @override
////  Widget build(BuildContext context) {
////    _ctx = context;
////    return Scaffold(
////      key: scaffoldKey,
////      backgroundColor: Colors.white,
////      body: Padding(
////        padding: const EdgeInsets.symmetric(horizontal: 48.0),
////        child: Column(
////          crossAxisAlignment: CrossAxisAlignment.stretch,
////          mainAxisAlignment: MainAxisAlignment.center,
////          children: <Widget>[
////            Image.asset(
////              "assets/popshop-logo.png",
////              height: 70,
////            ),
////            SizedBox(height: 70),
////            Text(
////              "LOG IN",
////              textAlign: TextAlign.center,
////              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
////            ),
////            Padding(
////              padding: const EdgeInsets.symmetric(vertical: 35.0),
////              child: Form(
////                key: formKey,
////                child: Column(
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  children: <Widget>[
////                    Text(
////                      "Email Address",
////                    ),
////                    SizedBox(height: 5),
////                    TextFormField(
////                      controller: emailController,
////                      decoration: InputDecoration(
////                          contentPadding: EdgeInsets.symmetric(
////                              vertical: 12, horizontal: 16),
////                          border: OutlineInputBorder(
////                              borderRadius: BorderRadius.circular(0),
////                              borderSide: BorderSide(width: 0.5)),
////                          enabledBorder: OutlineInputBorder(
////                              borderSide:
////                                  BorderSide(color: Colors.grey, width: 1),
////                              borderRadius: BorderRadius.circular(0))),
////                    ),
////                    SizedBox(height: 15),
////                    Row(
////                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
////                      children: <Widget>[
////                        Text(
////                          "Password",
////                        ),
////                        GestureDetector(
////                            onTap: () {},
////                            child: Text(
////                              "Forgot?",
////                              style: TextStyle(
////                                  fontWeight: FontWeight.bold,
////                                  decoration: TextDecoration.underline),
////                            ))
////                      ],
////                    ),
////                    SizedBox(height: 5),
////                    TextFormField(
////                      obscureText: true,
////                      controller: passwordController,
////                      decoration: InputDecoration(
////                          contentPadding: EdgeInsets.symmetric(
////                              vertical: 12, horizontal: 16),
////                          border: OutlineInputBorder(
////                              borderRadius: BorderRadius.circular(0),
////                              borderSide: BorderSide(width: 0.5)),
////                          enabledBorder: OutlineInputBorder(
////                              borderSide:
////                                  BorderSide(color: Colors.grey, width: 1),
////                              borderRadius: BorderRadius.circular(0))),
////                    ),
////                  ],
////                ),
////              ),
////            ),
////            Align(
////              child: Material(
////                color: Color(0xff1d1d1b),
////                child: InkWell(
//////                  splashColor: limeColor(),
////                  onTap: _submit,
////                  child: Container(
////                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 70),
////                    child: Text(
////                      "Log In",
////                      style: TextStyle(
//////                          color: limeColor(),
////                          fontWeight: FontWeight.bold,
////                          fontSize: 22),
////                    ),
////                  ),
////                ),
////              ),
////            ),
////            SizedBox(height: 25),
////            Text(
////              "Dont have an account? Sign up here",
////              textAlign: TextAlign.center,
////              style: TextStyle(
////                  fontWeight: FontWeight.bold,
////                  decoration: TextDecoration.underline),
////            )
////          ],
////        ),
////      ),
////    );
////  }
//
//  @override
//  void onLoginError(String errorTxt) {
//    _showSnackBar(errorTxt);
//  }
//
//  @override
//  void onLoginSuccess(User user) async {
//    print("Success with user: ${user.authToken}");
//    await DatabaseHelper().saveUser(user);
//    PopshopScope.of(context).login(user);
////    _showSnackBar("Logged in! ${user.id}");
//    AuthStateProvider().notify(AuthState.LOGGED_IN);
//  }
//}
