import 'package:flutter/material.dart';
import 'package:op123/app/constants/TextDefaultStyle.dart';
import 'package:op123/app/constants/globals.dart';
import 'package:op123/app/models/TransactionResponse.dart';
import 'package:op123/app/services/TransactionService.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Transaction> _transactions = [];
  String? _transactionType;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getTransactions();
  }

  _getTransactions() async {
    if (mounted)
      setState(() {
        _isLoading = false;
      });
    var response = await TransactionService().allTransactions(_transactionType);

    if (mounted)
      setState(() {
        _transactions.addAll(response.transactions!.transaction!);
      });
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
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => print("Deposit"),
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blue[300]),
                        child: Container(
                          width: 35.w,
                          child: Center(
                            child: Text(
                              "New Deposit",
                              style: getDefaultTextStyle(size: 12.sp),
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.amber),
                        onPressed: () => print("Withdraw"),
                        child: Container(
                          width: 35.w,
                          child: Center(
                            child: Text(
                              "New Withdraw",
                              style: getDefaultTextStyle(size: 12.sp),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (var item in _transactions)
                  ListTile(
                    title: Text(
                      "Type " + item.type!,
                      style: getDefaultTextStyle(
                          size: 20, weight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Amount: ${item.amount} $currencylogoText",
                          style: getDefaultTextStyle(
                            size: 16,
                            weight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${item.status!.toUpperCase()}",
                          style: getDefaultTextStyle(
                            size: 16,
                            weight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          DateFormat("hh:mm a dd/M/yyyy")
                              .format(item.createdAt!)
                              .toString(),
                          style: getDefaultTextStyle(
                            size: 16,
                            weight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
