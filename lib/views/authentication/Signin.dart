import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/controllers/SignInController.dart';
import 'package:op123/views/authentication/Signup.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  EdgeInsets margin = EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: getStaticAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                height: MediaQuery.of(context).size.height * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).accentColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "OnPlay365",
                      style: getDefaultTextStyle(
                          size: 20, weight: FontWeight.bold),
                    ),
                    Text(
                      "Sign In",
                      style: getDefaultTextStyle(size: 17),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        child: Divider(
                          color: Colors.white,
                          thickness: 5,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                            labelText: "Username",
                            border: OutlineInputBorder(),
                            hintText: "your username"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        SignInController(
                          context: context,
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ).signin();
                      },
                      child: Text(
                        "Sign In",
                        style: getDefaultTextStyle(
                            size: 19, weight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "New Here? Sign Up",
                        style: getDefaultTextStyle(size: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
