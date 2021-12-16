import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/services/TransactionService.dart';
import 'package:OnPlay365/app/states/SettingState.dart';
import 'package:OnPlay365/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TransactionType { WITHDRAW, DEPOSIT }

class NewTransactionForm extends StatefulWidget {
  final TransactionType type;
  const NewTransactionForm({Key? key, this.type = TransactionType.DEPOSIT})
      : super(key: key);

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  TextEditingController _amountController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _backendMobileController =
      TextEditingController(text: "01234567894");
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _paymentTypeController =
      TextEditingController(text: "Bkash");
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    var settings = context.read(settingResponseProvider)?.siteSetting;
    if(settings != null){
      _backendMobileController.text = settings.backendNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getStaticAppBar(
        context,
        title: widget.type == TransactionType.DEPOSIT ? "Deposit" : "Withdraw",
      ),
      body: Container(
        color: Theme.of(context).accentColor,
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        height: 100.h,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    decoration: InputDecoration(
                        labelText: 'Amount',
                        hintText: '100',
                        border: OutlineInputBorder()),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _mobileController,
                    decoration: InputDecoration(
                        labelText: 'Mobile',
                        hintText: '012345678901',
                        border: OutlineInputBorder()),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                if (widget.type == TransactionType.DEPOSIT)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _backendMobileController,
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: 'Backend Number',
                          hintText: '012345678901',
                          border: OutlineInputBorder()),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                if (widget.type == TransactionType.WITHDRAW)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _paymentTypeController,
                      enabled: false,
                      decoration: InputDecoration(
                          labelText: 'Payment Type',
                          // hintText: '012345678901',
                          border: OutlineInputBorder()),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: _passwordController,
                      enabled: true,
                      decoration: InputDecoration(
                          labelText: 'Current Password',
                          border: OutlineInputBorder()),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 20,
              child: InkWell(
                onTap: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  if(widget.type == TransactionType.DEPOSIT){
                    var depositData = {
                      "amount" : _amountController.text,
                      "mobile" : _mobileController.text,
                      "backend_mobile" : _backendMobileController.text,
                      "password" : _passwordController.text,
                    };
                    print(depositData);
                    var response = await TransactionService().deposit(depositData);

                    if(response.statusCode == 200){
                      // success
                      showCustomSimpleNotification("Deposit Request added successfully.", Colors.green);
                      Navigator.pop(context);
                    }else if(response.statusCode == 401){
                      // failed validation failed
                      showCustomSimpleNotification("Make sure you've entered correct amount, contact Number & password.", Colors.yellow);
                    }else{
                      // something else wrong
                      showCustomSimpleNotification("Something went wrong. Contact Admin.", Colors.red);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }else{
                    var withdrawData = {
                      "amount" : _amountController.text,
                      "mobile" : _mobileController.text,
                      "payment_type" : _paymentTypeController.text,
                      "password" : _passwordController.text,
                    };
                    var response = await TransactionService().withdraw(withdrawData);

                    if(response.statusCode == 200){
                      // success
                      showCustomSimpleNotification("Withdraw Request added successfully.", Colors.green);
                      Navigator.pop(context);
                    }else if(response.statusCode == 401){
                      // failed validation failed
                      showCustomSimpleNotification("Make sure you've entered correct amount, contact Number & password.", Colors.yellow);
                    }else{
                      // something else wrong
                      showCustomSimpleNotification("Something went wrong. Contact Admin.", Colors.red);
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  }
                },
                child: Container(
                  height: 50,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isLoading ? CircularProgressIndicator() : Text(
                      "Submit",
                      style: getDefaultTextStyle(size: 14.sp),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
