import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/authentication/Signup.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({Key? key}) : super(key: key);

  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: MediaQuery.of(context).size.width * 0.60,
      color: Theme.of(context).backgroundColor,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                child: SvgPicture.asset("assets/images/logo-light.svg"),
              ),
              Divider(
                color: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.40,
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MyHomePage()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.login,
                  color: Colors.white,
                ),
                title: Text(
                  "Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignInPage()));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.how_to_reg,
                  color: Colors.white,
                ),
                title: Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignUpPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
