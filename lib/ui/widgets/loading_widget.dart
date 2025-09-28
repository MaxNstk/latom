

import 'package:flutter/material.dart';

class LtLoadingWidget extends StatelessWidget {
  const LtLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Directionality(
      textDirection: TextDirection.ltr, // or rtl if appropriate
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 30, height: 30, child: CircularProgressIndicator()),
            Padding(
              padding: EdgeInsets.only(top: 12),
              child: Text("Loading..."),
            ),
          ],
        ),
      ),
    );
  }
}
