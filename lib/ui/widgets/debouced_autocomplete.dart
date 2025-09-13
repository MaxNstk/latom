
import 'package:flutter/material.dart';
import 'package:latom/core/utils/debounceable.dart';


class DebouncedAutocomplete<T extends Object> extends StatefulWidget {

  final Function(T selectedOpt) onSelect; 
  final Function(T opt) getDisplayStringForOption; 

  final Future<Iterable<T>> Function(String query) searchFunction;

  const DebouncedAutocomplete({super.key, required this.onSelect, required this.searchFunction, required this.getDisplayStringForOption});

  @override
  State<DebouncedAutocomplete<T>> createState() => _DebouncedAutocompleteState<T>();
}

class _DebouncedAutocompleteState<T extends Object> extends State<DebouncedAutocomplete<T>> {

  late final Debounceable<Iterable<T>?, String> _deboucedSearch; 

  Iterable<T> _lastOptions = Iterable<T>.empty();

  @override
  void initState() {
    super.initState();
    _deboucedSearch = debounce(widget.searchFunction);
  }

  @override
  Widget build(BuildContext context) {
    return Autocomplete<T>(
      optionsBuilder: (TextEditingValue textEditingValue) async {
        final Iterable<T>? options = await _deboucedSearch(textEditingValue.text);
        if (options!.isEmpty){ 
          return _lastOptions;
        }
        _lastOptions = options;
        return options;
      },
      displayStringForOption: (T opt) => widget.getDisplayStringForOption(opt),
      onSelected: (T opt) {
        setState(() {
          widget.onSelect(opt);
        });
      },
    );
  }
}
