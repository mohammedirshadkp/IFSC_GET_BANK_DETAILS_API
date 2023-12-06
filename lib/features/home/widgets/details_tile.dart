import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifsc_get_bank_details/core/constatnts.dart';
import 'package:ifsc_get_bank_details/core/theme/theme.dart';
import 'package:ifsc_get_bank_details/models/bank_details_model.dart';

class DetailsTile extends ConsumerWidget {
  String data;
  DetailsTile(this.data, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding).copyWith(top: 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Palette.scaffoldBackgorundColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              "Details:",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300.0,
                maxWidth: 300.0,
                minHeight: 60.0,
              ),
              child: Text(
                data,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
