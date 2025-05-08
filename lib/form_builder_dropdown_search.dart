import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuilderDropdownSearch<T> extends StatefulWidget {
  const FormBuilderDropdownSearch({
    required this.name,
    required this.items,
    this.autoValidateMode,
    this.enabled = true,
    this.focusNode,
    this.onSaved,
    this.validator,
    this.decoration,
    this.initialValue,
    this.onChanged,
    this.valueTransformer,
    this.onReset,
    this.dropdownBuilder,
    this.itemAsString,
    this.filterFn,
    this.compareFn,
    this.dropdownSearchDecoration,
    this.dropdownSearchTextAlign,
    this.dropdownSearchTextAlignVertical,
    this.onBeforeChange,
    this.popupProps = const PopupProps.menu(
      showSearchBox: true,
      fit: FlexFit.loose,
    ),
    this.clearButtonProps,
    this.dropdownSearchTextStyle,
    this.dropdownButtonProps,
    super.key,
  });

  /// Name of the field
  final String name;

  /// Auto validate mode
  final AutovalidateMode? autoValidateMode;

  /// Function to be called when the value is changed
  final ValueChanged<T?>? onChanged;

  /// Function to be called when the value is saved
  final ValueChanged<T?>? onSaved;

  /// Function to be called when the value is reset
  final VoidCallback? onReset;

  /// Function to be called when the value is changed
  final ValueTransformer<T?>? valueTransformer;

  /// True if the field is enabled
  final bool enabled;

  /// Focus node for the field
  final FocusNode? focusNode;

  /// Validator to be applied to the form field
  final String? Function(T?)? validator;

  /// Decoration to be applied to the form field
  final InputDecoration? decoration;

  /// Initial value of the field
  final T? initialValue;

  ///function that returns item from API
  final DropdownSearchOnFind<T> items;

  ///to customize list of items UI
  final DropdownSearchBuilder<T>? dropdownBuilder;

  ///customize the fields the be shown
  final DropdownSearchItemAsString<T>? itemAsString;

  ///	custom filter function
  final DropdownSearchFilterFn<T>? filterFn;

  ///function that compares two object with the same type to detected if it's the selected item or not
  final DropdownSearchCompareFn<T>? compareFn;

  ///dropdownSearch input decoration
  final InputDecoration? dropdownSearchDecoration;

  /// How the text in the decoration should be aligned horizontally.
  final TextAlign? dropdownSearchTextAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? dropdownSearchTextAlignVertical;

  /// callback executed before applying value change
  final BeforeChange<T>? onBeforeChange;

  ///custom dropdown popup properties
  final PopupProps<T> popupProps;

  ///custom dropdown clear button icon properties
  final ClearButtonProps? clearButtonProps;

  /// style on which to base the label
  final TextStyle? dropdownSearchTextStyle;

  ///custom dropdown icon button properties
  final DropdownButtonProps? dropdownButtonProps;

  @override
  State<FormBuilderDropdownSearch<T>> createState() =>
      FormBuilderDropdownSearchState<T>();
}

class FormBuilderDropdownSearchState<T>
    extends State<FormBuilderDropdownSearch<T>> {
  /// Key for the DropdownSearch widget
  final GlobalKey<DropdownSearchState<T>> bottomSheetKey =
      GlobalKey<DropdownSearchState<T>>();

  @override
  Widget build(BuildContext context) => FormBuilderField<T>(
        name: widget.name,
        autovalidateMode: widget.autoValidateMode,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        onReset: widget.onReset,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        validator: widget.validator,
        valueTransformer: widget.valueTransformer,
        initialValue: widget.initialValue,
        builder: (state) => DropdownSearch<T>(
          key: bottomSheetKey,
          items: widget.items,
          validator: widget.validator,
          suffixProps: DropdownSuffixProps(
            clearButtonProps:
                widget.clearButtonProps ?? const ClearButtonProps(),
            dropdownButtonProps:
                widget.dropdownButtonProps ?? const DropdownButtonProps(),
          ),
          compareFn: widget.compareFn,
          enabled: widget.enabled,
          dropdownBuilder: widget.dropdownBuilder,
          decoratorProps: DropDownDecoratorProps(
            decoration: widget.decoration?.copyWith(
                  errorText: state.hasError ? state.errorText : null,
                ) ??
                InputDecoration()
                    .applyDefaults(
                      Theme.of(context).inputDecorationTheme,
                    )
                    .copyWith(
                      errorText: state.hasError ? state.errorText : null,
                    ),
            textAlign: widget.dropdownSearchTextAlign,
            textAlignVertical: widget.dropdownSearchTextAlignVertical,
            baseStyle: widget.dropdownSearchTextStyle,
          ),
          filterFn: widget.filterFn,
          itemAsString: widget.itemAsString,
          onBeforeChange: widget.onBeforeChange,
          onChanged: state.didChange,
          popupProps: widget.popupProps,
          selectedItem: state.value,
        ),
      );

  void openDropDownSearch() {
    bottomSheetKey.currentState?.openDropDownSearch();
  }

  void closeDropDownSearch() {
    bottomSheetKey.currentState?.closeDropDownSearch();
  }

  GlobalKey<DropdownSearchState<T>> get dropdownSearchState => bottomSheetKey;
}
