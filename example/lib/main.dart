import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_dropdown_search/form_builder_dropdown_search.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Form Builder Dropdown Search Example'),
        ),
        body: _ExampleForm(),
      ),
    );
  }
}

class _ExampleForm extends StatefulWidget {
  const _ExampleForm();

  @override
  State<_ExampleForm> createState() => __ExampleFormState();
}

class __ExampleFormState extends State<_ExampleForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  final _nestedFormKey = GlobalKey<FormBuilderDropdownSearchState>();

  @override
  Widget build(BuildContext context) => FormBuilder(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            FormBuilderDropdownSearch<String>(
              name: 'dropdown_search',
              items: (_, __) => ['Item 1', 'Item 2', 'Item 3'],
              decoration: const InputDecoration(labelText: 'Dropdown Search'),
              onChanged: (value) {
                print('Selected value: $value');

                _nestedFormKey.currentState?.openDropDownSearch();
              },
              validator: (p0) => p0 == null ? 'Required' : null,
            ),
            const SizedBox(
              height: 40,
            ),
            FormBuilderDropdownSearch<String>(
              key: _nestedFormKey,
              name: 'nested_dropdown_search',
              items: (_, __) => ['Item 4', 'Item 5', 'Item 6'],
              decoration: const InputDecoration(labelText: 'Dropdown Search 2'),
              onChanged: (value) {
                print('Selected value: $value');
              },
              validator: (p0) => p0 == null ? 'Required' : null,
            ),
            ElevatedButton(
              onPressed: () {
                // Validate the form and save the values
                final isValid =
                    _formKey.currentState?.saveAndValidate() ?? false;

                print(isValid);

                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  print('Form submitted successfully');
                } else {
                  print('Form submission failed');
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      );
}
