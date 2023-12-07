import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifsc_get_bank_details/core/constatnts.dart';
import 'package:ifsc_get_bank_details/core/theme/theme.dart';
import 'package:ifsc_get_bank_details/features/home/widgets/details_tile.dart';
import 'package:ifsc_get_bank_details/models/bank_details_model.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:http/http.dart' as http;

String? errorMessage;
bool isLoading = false;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TextEditingController ifsccontroller = TextEditingController();

  Future<void> fetchData(String ifscCode) async {
    try {
      if (ifscCode.isEmpty || ifscCode.length != 11) {
        setState(() {
          errorMessage = 'Invalid IFSC code';
          bankDetails = null; // Reset bankDetails if code is invalid
        });
        return; // Exit the function early if IFSC code is invalid
      }

      final url = 'http://ifsc.rizad.me/?ifsc=$ifscCode';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        setState(() {
          bankDetails = BankDetails.fromMap(responseData);
          errorMessage = null; // Reset error message if successful
        });
      } else {
        setState(() {
          errorMessage = 'Failed to fetch data: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
      });
      print('Error fetching data: $e');
    } finally {
      isLoading = false;
    }
  }

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
                      // width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: ifsccontroller,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(5.5),
                                ),
                                prefixIcon: const Icon(Icons.account_balance,
                                    color: Colors.blue),
                                hintText: "Enter your IFSC CODE",
                                hintStyle: TextStyle(color: Colors.blue),
                                filled: true,
                                fillColor: Colors.blue[50],
                              ),
                            )
                          ],
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
                            backgroundColor: Colors.blueAccent,
                            fixedSize: const Size(130, 50),
                          ),
                          onPressed: () {
                            setState(() {
                              fetchData(ifsccontroller.text);
                              isLoading = true;
                            });
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
                    isLoading == true
                        ? const SizedBox(
                            height: 650,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : Container(
                            height: 650,
                            color: Palette.scaffoldBackgorundColor,
                            child: Card(
                              elevation: 0,
                              color: Palette.scaffoldBackgorundColor,
                              child: bankDetails != null
                                  ? ListView(
                                      physics: const ScrollPhysics(
                                        parent: BouncingScrollPhysics(
                                            decelerationRate:
                                                ScrollDecelerationRate.normal),
                                      ),
                                      children: [
                                        DetailsTile(
                                            data: bankDetails!.bank,
                                            title: "bank"),
                                        DetailsTile(
                                            data: bankDetails!.branch,
                                            title: "branch"),
                                        DetailsTile(
                                            data: bankDetails!.address,
                                            title: "address"),
                                        DetailsTile(
                                            data: bankDetails!.state,
                                            title: "state"),
                                        DetailsTile(
                                            data: bankDetails!.city,
                                            title: "city"),
                                        DetailsTile(
                                            data: bankDetails!.centre,
                                            title: "centre"),
                                        DetailsTile(
                                            data: bankDetails!.contact,
                                            title: "contact"),
                                        DetailsTile(
                                            data: bankDetails!.district,
                                            title: "district"),
                                        DetailsTile(
                                            data: bankDetails!.ifsc,
                                            title: "ifsc"),
                                        DetailsTile(
                                            data: bankDetails!.iso3166,
                                            title: "iso3166"),
                                        DetailsTile(
                                            data: bankDetails!.micr,
                                            title: "micr"),
                                        DetailsTile(
                                            data: bankDetails!.imps.toString(),
                                            title: "imps"),
                                        DetailsTile(
                                            data: bankDetails!.neft.toString(),
                                            title: "neft"),
                                        DetailsTile(
                                            data: bankDetails!.rtgs.toString(),
                                            title: "rtgs"),
                                        DetailsTile(
                                            data: bankDetails!.upi.toString(),
                                            title: "upi"),
                                        DetailsTile(
                                            data: bankDetails!.swift,
                                            title: "swift"),
                                      ],
                                    )
                                  : errorMessage != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            errorMessage!,
                                            style: TextStyle(
                                                color: Colors
                                                    .red), // Style the error message here
                                          ),
                                        )
                                      : SizedBox.shrink(),
                            ),
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
