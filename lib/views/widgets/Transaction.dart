import 'package:flutter/material.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/models/TransactionResponse.dart';
import 'package:op123/app/services/TransactionService.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Transaction> _transactions = [];
  String _transactionType = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  _getTransactions() async {
    setState(() {
      _isLoading = false;
    });
    var response = await TransactionService().allTransactions(_transactionType);
    if(response.statusCode == 200){

    }else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: getStaticAppBar(context, title: "Transaction"),
      body: Container(
        height: 100.h,
        width: 100.w,
        color: Colors.black,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).backgroundColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () => print("Deposit"),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blue[300]),
                          child: Container(
                            width: 35.w,
                            child: Center(
                                child: Text(
                              "Deposit",
                              style: getDefaultTextStyle(size: 12.sp),
                            )),
                          )),
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: Colors.amber),
                          onPressed: () => print("Withdraw"),
                          child: Container(
                            width: 35.w,
                            child: Center(
                              child: Text(
                                "Withdraw",
                                style: getDefaultTextStyle(size: 12.sp),
                              ),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
