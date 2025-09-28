import 'package:flutter/material.dart';
import 'package:latom/ui/widgets/loading_widget.dart';

class LtFutureBuilder<T> extends StatelessWidget {
  
  final Future<T?>? future;
  final Widget Function(T? data) builder; 

  const LtFutureBuilder({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {
    if (future == null) {
      return LoadingWidget();
    }
    return FutureBuilder<T?>(
      future: future, 
      builder: (context, AsyncSnapshot<T?> snapshot){
        if (snapshot.connectionState == ConnectionState.done) {
          // BUILD THE LAYOUT
          return builder(snapshot.data);
        }
        if (snapshot.connectionState == ConnectionState.waiting){
          return LoadingWidget();
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
