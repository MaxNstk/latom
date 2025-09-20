

import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width:30, height: 30, child: CircularProgressIndicator()),
          Padding(padding: EdgeInsets.only(top: 12), child: Text("Loading..."),),
        ],
      )
    );
  }
}