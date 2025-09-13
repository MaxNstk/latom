import 'package:flutter/material.dart';

class LtFutureBuilder<T> extends StatelessWidget {
  
  final Future<T?> future;
  final Widget Function(T data) builder; 
  final String nullResponseMsg;
  
  const LtFutureBuilder({super.key, required this.future, required this.builder, required this.nullResponseMsg});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<T?>(
      future: future, 
      builder: (context, AsyncSnapshot<T?> snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data == null){
              return Center(child: Text(nullResponseMsg)); 
            }
          // BUILD THE LAYOUT
          return builder(snapshot.data!);
        }
        if (snapshot.connectionState == ConnectionState.waiting){
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
        if (snapshot.hasError){
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 30),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text('Error retrieving info: ${snapshot.error}')
              )
            ]
          );
        }
        else {
          return Text("Error while fetching data: state: ${snapshot.connectionState}; data: ${snapshot.data}");
        }
        
      }
    );
  }
}
