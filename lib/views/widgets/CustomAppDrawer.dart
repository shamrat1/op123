import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/User.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/authentication/Signup.dart';
import 'package:sizer/sizer.dart';

class CustomAppDrawer extends StatefulWidget {
  const CustomAppDrawer({Key? key}) : super(key: key);

  @override
  _CustomAppDrawerState createState() => _CustomAppDrawerState();
}

class _CustomAppDrawerState extends State<CustomAppDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60,
        color: Theme.of(context).backgroundColor,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Consumer(
              builder: (context, watch, child) {
                var token = watch(authTokenProvider);
                var user = watch(authUserProvider);
                // print(token);

                if (user != null) {
                  return _setAuthorizedView(user);
                }
                return _setUnAuthorizedView();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _setUnAuthorizedView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 40,
          child: SvgPicture.asset("assets/images/logo-light.svg"),
        ),
        Divider(
          color: Colors.white,
        ),
        SizedBox(
          height: 40.h,
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignInPage()));
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
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
        ),
      ],
    );
  }

  Widget _setAuthorizedView(User user) {
    return Consumer(
      builder: (context, watch, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 40,
              child: SvgPicture.asset("assets/images/logo-light.svg"),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 20.h,
            ),

            ListTile(
              leading: Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: Text(
                "Hello, ${user.name}",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              onLongPress: () =>
                  context.read(creditProvider.notifier).fetchCredit(),
              leading: Icon(
                Icons.monetization_on_outlined,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Coins ${context.read(creditProvider)} $currencylogoText",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Text(
                "Longpress to sync with server.",
                style: getDefaultTextStyle(size: 8.sp),
              ),
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.login,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Sign In",
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   ),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => SignInPage()));
            //   },
            // ),
            // ListTile(
            //   leading: Icon(
            //     Icons.how_to_reg,
            //     color: Colors.white,
            //   ),
            //   title: Text(
            //     "Sign Up",
            //     style: TextStyle(color: Colors.white, fontSize: 20),
            //   ),
            //   onTap: () {
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => SignUpPage()));
            //   },
            // ),
          ],
        );
      },
    );
  }
}
