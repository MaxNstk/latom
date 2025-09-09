import 'package:flutter/material.dart';
import 'package:latom/ui/widgets/anime_detail_widget.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';


class AnimeSearchForm extends StatefulWidget {
  const AnimeSearchForm({super.key});

  @override
  AnimeSearchFormState createState() {
    return AnimeSearchFormState();
  }
}

class AnimeSearchFormState extends State<AnimeSearchForm> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  int? _submittedAnimeId;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: "ANIMEE",
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: "Input anime ID"),
                      validator: (value) {
                        if (value == null || value.isEmpty)  {
                          return 'Please enter some text';
                        }
                        if (int.tryParse(value) == null){
                          return 'Not a Number';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final id = int.parse(_controller.text);
                            setState(() {
                              _submittedAnimeId = id;
                            });
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32,),
              if (_submittedAnimeId != null)
                AnimeDetailWidget(
                  key: ValueKey(_submittedAnimeId),
                  animeId: _submittedAnimeId!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
