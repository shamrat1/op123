import 'package:flutter/material.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/controllers/SignUpController.dart';
import 'package:OnPlay365/views/widgets/CustomAppDrawer.dart';
import 'package:OnPlay365/views/widgets/StaticAppBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _sponserController = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  EdgeInsets margin = EdgeInsets.symmetric(horizontal: 20);

  var selectedClub = "Select Club";
  void _handleClub(String clubId) {
    // some
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _countryController.text = "Bangladesh";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: getStaticAppBar(context),
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).backgroundColor,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.90,
                padding: EdgeInsets.symmetric(vertical: 20),
                margin: EdgeInsets.symmetric(vertical: 20),
                // height: MediaQuery.of(context).size.height * 0.50,
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
                      "Sign Up",
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
                            hintText: "Username"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                            labelText: "Name",
                            border: OutlineInputBorder(),
                            hintText: "Name"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _mobileController,
                        decoration: InputDecoration(
                            labelText: "Mobile Number",
                            border: OutlineInputBorder(),
                            hintText: "your mobile number"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            hintText: "your email"),
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
                      height: 10,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _passwordConfirmation,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Confirm Password",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _countryController,
                        decoration: InputDecoration(
                          labelText: "Country",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: margin,
                      child: TextFormField(
                        controller: _sponserController,
                        decoration: InputDecoration(
                            labelText: "Sponser",
                            border: OutlineInputBorder(),
                            hintText: "Name of Sponser"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   margin: margin,
                    //   child: DropdownButton(
                    //     items: [
                    //       DropdownMenuItem(
                    //         child: Text("op365"),
                    //         onTap: () => _handleClub('1'),
                    //       ),
                    //       DropdownMenuItem(
                    //         child: Text("other club"),
                    //         onTap: () => _handleClub('2'),
                    //       ),
                    //       DropdownMenuItem(
                    //         child: Text("Another club"),
                    //         onTap: () => _handleClub('3'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      margin: margin,
                      width: MediaQuery.of(context).size.width * 0.77,
                      child: DropdownButton<String>(
                        hint: Text(selectedClub),
                        underline: Container(
                          height: 2,
                          width: MediaQuery.of(context).size.width * 0.77,
                          color: Colors.black45,
                        ),
                        dropdownColor: Theme.of(context).backgroundColor,
                        items: <String>[
                          'Op365',
                          'Some Club',
                          'Club House 354',
                          'DBoyzzz'
                        ].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: new Text(
                              value,
                              style: getDefaultTextStyle(size: 18),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedClub = value ?? "Select Club";
                          });
                        },
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        SignUpController(
                                context: context,
                                username: _usernameController.text,
                                password: _passwordController.text,
                                passwordConfirmation:
                                    _passwordConfirmation.text,
                                email: _emailController.text,
                                name: _nameController.text,
                                country: _countryController.text)
                            .register();
                      },
                      child: Text(
                        "Sign Up",
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
                        "Already Have An Account? Sign In",
                        style: getDefaultTextStyle(size: 11),
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
