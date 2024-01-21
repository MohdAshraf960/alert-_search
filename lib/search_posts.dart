import 'dart:async';

import 'package:flutter/material.dart';

class Search<T extends Object> extends StatefulWidget {
  const Search(
      {Key? key,
      required this.displayStringForOption,
      required this.searchRequest})
      : super(key: key);

  final String Function(T option) displayStringForOption;
  final FutureOr<List<T>> Function(String) searchRequest;

  @override
  SearchState createState() => SearchState<T>();
}

class SearchState<T extends Object> extends State<Search<T>> {
  Iterable<T> options = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: StatefulBuilder(builder: (contex, setState) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.40,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                onChanged: (value) {
                  setState(() {
                    _debouncedSearch(value);
                  });
                },
                decoration: const InputDecoration(
                  hintText: "Search here...",
                ),
              ),
              dataWidget()
            ],
          ),
        );
      }),
    );
  }

  Expanded dataWidget() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          final T option = options.elementAt(index);
          return ListTile(
            onTap: () {
              Navigator.pop(context, option);
            },
            title: Text(widget.displayStringForOption(option)),
          );
        },
        itemCount: options.length,
      ),
    );
  }

  void _debouncedSearch(String query) {
    Future.delayed(const Duration(milliseconds: 500), () async {
      options = await widget.searchRequest.call(query);
    });
  }
}
