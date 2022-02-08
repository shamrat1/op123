import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/Club.dart';
import 'package:OnPlay365/app/models/GeneralResponse.dart';
import 'package:OnPlay365/app/services/RemoteService.dart';
import 'package:OnPlay365/app/states/StateManager.dart';
import 'package:OnPlay365/views/widgets/StaticAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditingEnabled = false;
  var selectedClub = "Select Club";
  int selectedClubId = 0;
  List<Club> clubs = [];
  bool loading = false;

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _sponserController = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  EdgeInsets margin = EdgeInsets.symmetric(horizontal: 20, vertical: 10);

  @override
  void initState() {
    super.initState();
    _getClubs();
    var user = context.read(authUserProvider);
    setState(() {
      _nameController.text = user.name!;
      _mobileController.text = user.mobile!;
      _emailController.text = user.email!;
      _countryController.text = user.country!;
      _usernameController.text = user.username!;
      _sponserController.text = user.sponserEmail!;
      selectedClubId = user.clubId!;
    });
  }

  void _updateUserInfo() async {
    if(_currentPasswordController.text.length > 0){
      if(_passwordController.text.length > 0){
        if(_passwordController.text.length > 7 && _passwordController.text == _passwordConfirmation.text){

        }else{
          showCustomSimpleNotification("New Passwords Must be of 8 or more characters & Password Confirmation should be same as new password.", Colors.red);
          return;
        }
      }
      var data = {
        "name" : _nameController.text,
        "email" : _emailController.text,
        "country" : _countryController.text,
        "club_id" : selectedClubId,
        "mobile" : _mobileController.text,
        "password" : _currentPasswordController.text,
        "new_password" : _passwordController.text,
        "new_password_confirmation" : _passwordConfirmation.text,
      };
      setState(() {
        loading = true;
      });
      var response = await RemoteService().updareUserInfo(data);
      if(response.statusCode == 200){
        showCustomSimpleNotification("User Info Updated", Colors.blue);
        var generalResponse = generalResponseFromMap(response.body);
        context.read(authUserProvider.notifier).change(generalResponse.user!);
        setState(() {
          loading = false;
        });
        Navigator.pop(context);
      }else if(response.statusCode == 401){
        showCustomSimpleNotification(response.body, Colors.amber);
      }else{
        print(response.body);
        showCustomSimpleNotification("${response.statusCode} Something went wrong.", Colors.red);
      }
      setState(() {
        loading = false;
      });
    }else{
      showCustomSimpleNotification("Enter The Current Password.", Colors.red);
      return;
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getStaticAppBar(context, title: "Profile"),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).backgroundColor,
        onPressed: () {
          setState(() {
            isEditingEnabled = !isEditingEnabled;
          });
        },
        child: Icon(
          isEditingEnabled ? Icons.edit_off : Icons.edit_rounded,
          color: Colors.white,
        ),
      ),
      body: Container(
        // margin: EdgeInsets.all(8),
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.symmetric(vertical: 8),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      enabled: false,
                      labelText: "Username",
                      border: OutlineInputBorder(),
                      hintText: "Username"),
                ),
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Name",
                      border: OutlineInputBorder(),
                      hintText: "Name"),
                ),
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _mobileController,
                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Mobile",
                      border: OutlineInputBorder(),
                      hintText: "Mobile"),
                ),
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Email",
                      border: OutlineInputBorder(),
                      hintText: "Email"),
                ),
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Country",
                      border: OutlineInputBorder(),
                      hintText: "Country"),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _sponserController,
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: "Sponser",
                    border: OutlineInputBorder(),
                    hintText: "Sponser",
                  ),
                ),
              ),
              Container(
                margin: margin,
                width: MediaQuery.of(context).size.width * 0.77,
                child: DropdownButton<Club>(
                  hint: Text(selectedClub),
                  underline: Container(
                    height: 2,
                    width: MediaQuery.of(context).size.width * 0.77,
                    color: Colors.black45,
                  ),
                  dropdownColor: Theme.of(context).backgroundColor,
                  items: clubs.map((Club value) {
                    return DropdownMenuItem<Club>(
                      value: value,
                      child: new Text(
                        value.name!,
                        style: getDefaultTextStyle(size: 18),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClub = value?.name! ?? "Select Club";
                      selectedClubId = value!.id!;
                    });
                  },
                ),
              ),
              if(isEditingEnabled)
              ...[
              Divider(
                color: Colors.black,
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Password",
                      border: OutlineInputBorder(),

                      hintText: "Password"),
                ),
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _passwordConfirmation,
                  obscureText: true,

                  decoration: InputDecoration(
                      enabled: isEditingEnabled,
                      labelText: "Password Confirmation",
                      border: OutlineInputBorder(),
                      hintText: "Password Confirmation"),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                margin: margin,
                child: TextFormField(
                  controller: _currentPasswordController,
                  obscureText: true,

                  decoration: InputDecoration(
                    enabled: isEditingEnabled,
                    labelText: "Current Password *",
                    border: OutlineInputBorder(),
                    hintText: "Current Password ( Required )",
                  ),
                ),
              ),
              Divider(
                color: Colors.black,
              ),
              InkWell(
                onTap: (){
                  _updateUserInfo();
                },
                child: Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width * .50,
                    child: Center(
                      child: loading ? CircularProgressIndicator() : Text(
                        "Update",
                        style: getDefaultTextStyle(
                          size: 18,
                        ),
                      ),
                    )),
              ),
                ]
            ],
          ),
        ),
      ),
    );
  }

  void _getClubs() async {
    RemoteService().getRegisterEssentials().then((response) {
      if (response.statusCode == 200) {
        setState(() {
          clubs = clubFromJson(response.body);
          if(selectedClubId > 0){
            var club = clubs.firstWhere((element) => element.id == selectedClubId);
            selectedClub = club.name!;
          }
        });
      }
    });
  }
}
