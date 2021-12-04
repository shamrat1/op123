import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';

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
                          labelText: 'Receiver Number',
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
                if (widget.type == TransactionType.DEPOSIT)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: TextFormField(
                      obscureText: true,
                      keyboardType: TextInputType.number,
                      controller: _passwordController,
                      enabled: false,
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
                onTap: () {},
                child: Container(
                  height: 50,
                  width: 90.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
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
