import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAhead extends StatelessWidget {
  final FutureOr<Iterable<Object?>> Function(String) suggestionsCallback;
  const TypeAhead({
    Key? key,
    required this.suggestionsCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      getImmediateSuggestions: true,
      textFieldConfiguration: const TextFieldConfiguration(
        // autofocus: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          hintText: "Search",
          hintStyle: TextStyle(fontSize: 15),
        ),
      ),
      suggestionsCallback: suggestionsCallback,
      itemBuilder: (context, suggestion) {
        return ListTile(
          title: Text(suggestion.toString()),
        );
      },
      onSuggestionSelected: (suggestion) {},
      hideOnEmpty: true,
      hideOnLoading: true,
      hideOnError: true,
    );
  }
}
