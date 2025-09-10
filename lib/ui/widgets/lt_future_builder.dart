import 'package:flutter/material.dart';

class LtFutureBuilder extends StatelessWidget {
  
  final Future future;
  final Function builder; 
  
  const LtFutureBuilder({super.key, required this.future, required this.builder});

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: future, 
      builder: (context, snapshot){
        List<Widget> children;
        if (snapshot.hasData){
          children = snapshot.data == null ?
            [const Text("Error while retrieving data")] :
            [builder(snapshot.data)];
        }
        else if (snapshot.hasError){
          children = [
            const Icon(Icons.error_outline, color: Colors.red, size: 30),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text('Error retrieving anime info: ${snapshot.error}')
            )
          ];
        }else{
          children = [
            SizedBox(width:30, height: 30, child: CircularProgressIndicator())
          , Padding(padding: EdgeInsets.only(top: 12), child: Text("Loading..."),)
          ];          
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
