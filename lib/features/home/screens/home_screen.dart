import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifsc_get_bank_details/core/constatnts.dart';
import 'package:ifsc_get_bank_details/core/theme/theme.dart';
import 'package:ifsc_get_bank_details/features/home/widgets/details_tile.dart';
import 'package:ifsc_get_bank_details/models/bank_details_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController ifsccontroller = TextEditingController();
  Future<void> fetchData(String ifscCode) async {
    final url = 'http://ifsc.rizad.me/?ifsc=$ifscCode';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print(responseData);
        print(responseData['ADDRESS']);
        print(responseData['BANK']);
        print(responseData['BRANCH']);
        print(responseData['CENTRE']);
        setState(() {
          bankDetails = BankDetails.fromMap(responseData);
          // print(bankDetails!.length);
        });
        print('andi');
      }
    } catch (error) {
      print(error.toString());
      Text(error.toString());
    }
  }

  // Future<void> fetchData(String ifscCode) async {
  //   final url = 'http://ifsc.rizad.me/?ifsc=$ifscCode';
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //       setState(() {
  //         bankDetails = BankDetails.fromMap(
  //             responseData); // Update the bankDetails variable
  //       });
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: ResponsiveValue<double>(context, conditionalValues: [
        Condition.between(start: 0, end: 450, value: 450),
      ]).value,
      child: Scaffold(
        backgroundColor: Palette.scaffoldBackgorundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Palette.appBarColor,
        ),
        body: Center(
          child: MaxWidthBox(
            maxWidth: 450,
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              color: Palette.scaffoldBackgorundColor,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 120,
                      width: double.infinity,
                      child: Card(
                        color: Palette.cardColor,
                        child: Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Enter IFSC code",
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                controller: ifsccontroller,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Palette.scaffoldBackgorundColor),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Palette.buttonColor,
                            fixedSize: Size(130, 50),
                          ),
                          onPressed: () {
                            print('fffffffffffffffffffffffffffffffff');
                            fetchData(ifsccontroller.text);
                            print('fffffffffffffffffffffffffffffffff');
                            setState(() {});
                          },
                          child: const Text(
                            "Search",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 600,
                      child: Card(
                          child: bankDetails != null
                              ? ListView(
                                  children: [
                                    DetailsTile(bankDetails!.bank),
                                    DetailsTile(bankDetails!.branch),
                                    DetailsTile(bankDetails!.address),
                                    DetailsTile(bankDetails!.state),
                                    DetailsTile(bankDetails!.city),
                                    DetailsTile(bankDetails!.bankcode),
                                    DetailsTile(bankDetails!.centre),
                                    DetailsTile(bankDetails!.contact),
                                    DetailsTile(bankDetails!.district),
                                    DetailsTile(bankDetails!.ifsc),
                                    DetailsTile(bankDetails!.iso3166),
                                    DetailsTile(bankDetails!.micr),
                                    DetailsTile(bankDetails!.imps.toString()),
                                    DetailsTile(bankDetails!.neft.toString()),
                                    DetailsTile(bankDetails!.rtgs.toString()),
                                    DetailsTile(bankDetails!.upi.toString()),
                                    DetailsTile(bankDetails!.swift),
                                  ],
                                )
                              : const Center(
                                  child: Text('Pls Enter a IFSC Code'))),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
