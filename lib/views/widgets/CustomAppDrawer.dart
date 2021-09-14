import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/User.dart';
import 'package:op123/app/states/CreditState.dart';
import 'package:op123/app/states/StateManager.dart';
import 'package:op123/views/MyHomePage.dart';
import 'package:op123/views/authentication/Signin.dart';
import 'package:op123/views/authentication/Signup.dart';
import 'package:op123/views/widgets/BetHistory.dart';
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

                if (token != "") {
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
              height: 15.h,
            ),

            ListTile(
              leading: Icon(
                Icons.person,
                color: Theme.of(context).accentColor,
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
                Icons.account_balance_wallet_outlined,
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
            ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Home",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                    (route) => false);
              },
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => BetHistory())),
              leading: Icon(
                Icons.history,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Bet History",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyHomePage())),
              leading: Icon(
                Icons.account_balance,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Transaction",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Text(
                "Deposit, Withdraw, Coin Transfers & Many more...",
                style: getDefaultTextStyle(size: 8.sp),
              ),
            ),
            ListTile(
              onTap: () => print("Transaction"),
              leading: Icon(
                Icons.info,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "About",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              onTap: () => print("Transaction"),
              leading: Icon(
                Icons.policy,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Policies",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              subtitle: Text(
                "Terms & Conditions, Fair Usage policy, Data privacy policy & many more...",
                style: getDefaultTextStyle(size: 8.sp),
              ),
            ),
            Spacer(),
            ListTile(
              onTap: () {
                context.refresh(authUserProvider);
                context.refresh(authTokenProvider);
                FlutterSecureStorage().deleteAll();
                Navigator.of(context).pop();
              },
              leading: Icon(
                Icons.logout_outlined,
                color: Theme.of(context).accentColor,
              ),
              title: Text(
                "Logout",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 5.h,
            )
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
