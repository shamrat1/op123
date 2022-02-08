import 'package:flutter/material.dart';
import 'package:OnPlay365/app/constants/TextDefaultStyle.dart';
import 'package:OnPlay365/app/constants/globals.dart';
import 'package:OnPlay365/app/models/TransactionResponse.dart';
import 'package:OnPlay365/app/services/TransactionService.dart';
import 'package:OnPlay365/views/widgets/CustomAppDrawer.dart';
import 'package:OnPlay365/views/widgets/NewTransactionForm.dart';
import 'package:OnPlay365/views/widgets/StaticAppBar.dart';
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
        _isLoading = true;
      });
    var response = await TransactionService().allTransactions(_transactionType);

    if (mounted)
      setState(() {
        _isLoading = false;
        _transactions = [];
        _transactions.addAll(response.transactions!.transaction!);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomAppDrawer(),
      appBar: getStaticAppBar(context, title: "Transaction"),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getTransactions(),
        child: Icon(Icons.refresh),
      ),
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
            child: _isLoading ? Center(
              child: CircularProgressIndicator(),
            ) : Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => NewTransactionForm())),
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
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (ctx) => NewTransactionForm(
                                  type: TransactionType.WITHDRAW,
                                ))),
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
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text("Date",style: getDefaultTextStyle(size: 10),)),
                      DataColumn(label: Text("Type",style: getDefaultTextStyle(size: 10),)),
                      DataColumn(label: Text("In",style: getDefaultTextStyle(size: 10),),numeric: true),
                      DataColumn(label: Text("Out",style: getDefaultTextStyle(size: 10),)),
                      // DataColumn(label: Text("Amount",style: getDefaultTextStyle(size: 10),)),
                    ],
                    rows: [
                      for (var item in _transactions)
                        DataRow(cells: [
                          DataCell(Text(
                                      DateFormat("hh:mm a dd/M/yyyy")
                                          .format(item.createdAt!)
                                          .toString(),
                                      style: getDefaultTextStyle(
                                        size: 12,
                                        weight: FontWeight.w300,
                                      ),
                          ),),
                          DataCell(Text(
                                      item.type.toString(),
                                      style: getDefaultTextStyle(
                                        size: 12,
                                        weight: FontWeight.w300,
                                      ),
                          ),),
                          DataCell(Text(
                            _isTransactionIn(item.type.toString(), item.paymentType.toString()) ? item.amount.toString() : "0",
                            style: getDefaultTextStyle(
                              size: 16,
                              weight: FontWeight.w300,
                            ),
                          ),),
                          DataCell(Text(
                            _isTransactionIn(item.type.toString(), item.paymentType.toString()) ? "0" : item.amount.toString(),
                            style: getDefaultTextStyle(
                              size: 16,
                              weight: FontWeight.w300,
                            ),
                          ),),
                        ]),
                    ],
                  ),
                )
                // for (var item in _transactions)
                //   ListTile(
                //     title: Text(
                //       "Type " + item.type!,
                //       style: getDefaultTextStyle(
                //           size: 20, weight: FontWeight.bold),
                //     ),
                //     subtitle: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Text(
                //           "Amount: ${item.amount} $currencylogoText",
                //           style: getDefaultTextStyle(
                //             size: 16,
                //             weight: FontWeight.w400,
                //           ),
                //         ),
                //         Text(
                //           "${item.status!.toUpperCase()}",
                //           style: getDefaultTextStyle(
                //             size: 16,
                //             weight: FontWeight.w500,
                //           ),
                //         ),
                //         Text(
                //           DateFormat("hh:mm a dd/M/yyyy")
                //               .format(item.createdAt!)
                //               .toString(),
                //           style: getDefaultTextStyle(
                //             size: 16,
                //             weight: FontWeight.w300,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  bool _isTransactionIn(String type, String paymentType){
    switch (type.toLowerCase()){
      case "onBet":
        return false;
      case "deposit":
        return true;
      case "withdraw":
        return false;
      case "betWin":
        return true;
      case "offerDeposit":
        return true;
      case "sponsered":
        return true;
      case "app login bonus":
        return true;
      case "gift":
        return paymentType.contains("giftFrom");
      default:
        return false;
    }
  }
}
