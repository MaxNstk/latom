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
        List<Widget> children;
        if (snapshot.connectionState == ConnectionState.waiting){
          children = [
            SizedBox(width:30, height: 30, child: CircularProgressIndicator())
          , Padding(padding: EdgeInsets.only(top: 12), child: Text("Loading..."),)
          ];
        }
        else if (snapshot.hasError){
          children = [
            const Icon(Icons.error_outline, color: Colors.red, size: 30),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Error retrieving info: ${snapshot.error}')
            )
          ];
        }else if (snapshot.connectionState == ConnectionState.done) {
          children = [
            snapshot.data != null ?
              builder(snapshot.data!) :
              Center(child: Text(nullResponseMsg)) 
          ];          
        }
        else {
          children = [Text("Error while fetching data: state: ${snapshot.connectionState}; data: ${snapshot.data}")];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          )
        );
      }
    );
  }
}
