import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:search_demo/edit_textfield.dart';

class EnhancedTypeAheadField<T> extends StatelessWidget {
  const EnhancedTypeAheadField({
    super.key,
    required this.controller,
    required this.errorMessage,
    required this.buttonText,
    required this.onPressed,
    required this.onSelected,
    required this.displayStringForOption,
    required this.suggestionsCallback,
    required this.labelText,
    this.validator
  });

  final TextEditingController controller;
  final String errorMessage;
  final String buttonText;
  final VoidCallback onPressed;
  final void Function(T) onSelected;
  final String Function(T option) displayStringForOption;
  final FutureOr<List<T>> Function(String) suggestionsCallback;
  final String labelText;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TypeAheadField<T>(
      hideOnSelect: true,
      hideWithKeyboard: true,
      hideOnUnfocus: true,
      controller: controller,
      builder: (context,controller,node){
        return  EditTextField(
          controller: controller,
          focusNode: node,
          labelText: labelText,
          validator: validator,
        );
      },
      decorationBuilder: (context, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Material(
          color: Colors.white,
          type: MaterialType.card,
          elevation: 4,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          child: child,
        ),
      ),
      debounceDuration: const Duration(milliseconds: 500),
      itemBuilder: (context, value) {
        return ListTile(
          title: Text(
            displayStringForOption(value),
            style: const TextStyle(color: Colors.black),
          ),
        );
      },
      onSelected: onSelected,
      suggestionsCallback: suggestionsCallback,
      loadingBuilder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
      emptyBuilder: (context) => Center(
        child: _buildErrorWidget(),
      ),
      errorBuilder: (context, error) {
        return Center(
          child: _buildErrorWidget(),
        );
      },
      itemSeparatorBuilder: (context, index) => const Divider(height: 1),
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errorMessage,
          style: const TextStyle(color: Colors.black),
        ),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText),
        ),
      ],
    );
  }
}
