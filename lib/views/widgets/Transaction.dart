

import 'package:flutter/material.dart';
import 'package:op123/views/widgets/CustomAppDrawer.dart';
import 'package:op123/views/widgets/StaticAppBar.dart';
import 'package:sizer/sizer.dart';

class Transaction extends StatefulWidget {
  const Transaction({ Key? key }) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}