import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ifsc_get_bank_details/core/constatnts.dart';
import 'package:ifsc_get_bank_details/core/theme/theme.dart';

class DetailsTile extends ConsumerWidget {
  final String data;
  final String title;
  const DetailsTile({super.key, required this.data, required this.title});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding).copyWith(top: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Palette.scaffoldBackgorundColor),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 300.0,
                maxWidth: 300.0,
                minHeight: 60.0,
              ),
              child: Center(
                child: Text(
                  data,
                  style: const TextStyle(fontSize: 16.0, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
