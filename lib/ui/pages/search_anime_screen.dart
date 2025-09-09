


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:latom/models/anime.dart';
import 'package:latom/services/anime_service.dart';
import 'package:latom/ui/widgets/lt_scaffold.dart';

const Duration debounceDuration = Duration(milliseconds: 500);


class SearchAnimeScreen extends StatefulWidget {
  const SearchAnimeScreen({super.key});

  @override
  State<SearchAnimeScreen> createState() => _SearchAnimeScreenState();
}

class _SearchAnimeScreenState extends State<SearchAnimeScreen> {

  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return LtScaffold(
      title: 'Pesquisa anime',
      body: SafeArea(child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            //Form(child: Column(
            //  key: _formKey,
            //  children: [
            //    TextFormField(
            //      controller: _controller,
            //      keyboardType: TextInputType.text,
            //      decoration: InputDecoration(labelText: "Prompt the anime"),
            //    )
            //  ],
            //))
            AsyncAutoComplete()
          ],
        ),
      )),
    );
  }
}


class AsyncAutoComplete extends StatefulWidget {
  const AsyncAutoComplete({super.key});

  @override
  State<AsyncAutoComplete> createState() => _AsyncAutoCompleteState();
}

class _AsyncAutoCompleteState extends State<AsyncAutoComplete> {

  String? _query;

  Iterable<Anime> _lastOptions = Iterable<Anime>.empty();
  late final _Debounceable<Iterable<Anime>?, String> _deboucedSearch; 

  Future<Iterable<Anime>> _search(String query) async {
    _query = query;

    Iterable<Anime> results = await AnimeService().fetchAnimes(_query);

    if (_query != query){
      return List.empty();
    }
    _query = null;

    return results;
  }

  @override
  void initState() {
    super.initState();
    _deboucedSearch = _debounce(_search);
  }


  @override
  Widget build(BuildContext context) {
    return Autocomplete<Anime>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final Iterable<Anime>? options = await _deboucedSearch(textEditingValue.text);
        if (options!.isEmpty){ 
          return _lastOptions;
        }
        _lastOptions = options;
        return options;
      },
      displayStringForOption: (Anime anime) => anime.toString(),
      onSelected: (Anime anime) {
        print('Selected ID: ${anime.id}');
      },
    );
  }
}

typedef _Debounceable<S, T> = Future<S?> Function(T parameter);

/// Returns a new function that is a debounced version of the given function.
///
/// This means that the original function will be called only after no calls
/// have been made for the given Duration.
_Debounceable<S, T> _debounce<S, T>(_Debounceable<S?, T> function) {
  _DebounceTimer? debounceTimer;

  return (T parameter) async {
    if (debounceTimer != null && !debounceTimer!.isCompleted) {
      debounceTimer!.cancel();
    }
    debounceTimer = _DebounceTimer();
    try {
      await debounceTimer!.future;
    } on _CancelException {
      return null;
    }
    return function(parameter);
  };
}

// A wrapper around Timer used for debouncing.
class _DebounceTimer {
  _DebounceTimer() {
    _timer = Timer(debounceDuration, _onComplete);
  }

  late final Timer _timer;
  final Completer<void> _completer = Completer<void>();

  void _onComplete() {
    _completer.complete();
  }

  Future<void> get future => _completer.future;

  bool get isCompleted => _completer.isCompleted;

  void cancel() {
    _timer.cancel();
    _completer.completeError(const _CancelException());
  }
}

// An exception indicating that the timer was canceled.
class _CancelException implements Exception {
  const _CancelException();
}