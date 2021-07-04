import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class TodoAddScreen extends StatefulWidget {
  @override
  _TodoAddScreenState createState() => _TodoAddScreenState();
}

class _TodoAddScreenState extends State<TodoAddScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  bool _ageHasError = false;
  bool _genderHasError = false;

  var genderOptions = ['Male', 'Female', 'Other'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                // enabled: false,
                autovalidateMode: AutovalidateMode.disabled,
                initialValue: {
                  'movie_rating': 5,
                  'best_language': 'Dart',
                  'age': '13',
                  'gender': 'Male'
                },
                skipDisabled: true,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderDateTimePicker(
                      onSaved: (DateTime? value) {},
                      name: 'date',
                      initialValue: DateTime.now(),
                      inputType: InputType.time,
                      decoration: InputDecoration(
                        labelText: 'Appointment Time',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _formKey.currentState!.fields['date']
                                  ?.didChange(null);
                            }),
                      ),
                      initialTime: TimeOfDay(hour: 8, minute: 0),
                      locale: Locale.fromSubtags(languageCode: 'pt-br'),
                    ),
                    FormBuilderDateRangePicker(
                      onSaved: (DateTimeRange? value) {},
                      name: 'date_range',
                      firstDate: DateTime(1970),
                      lastDate: DateTime(2030),
                      format: DateFormat('yyyy-MM-dd'),
                      decoration: InputDecoration(
                        labelText: 'Date Range',
                        helperText: 'Helper text',
                        hintText: 'Hint text',
                        suffixIcon: IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              _formKey.currentState!.fields['date_range']
                                  ?.didChange(null);
                            }),
                      ),
                    ),
                    FormBuilderSlider(
                      name: 'slider',
                      onSaved: (double? value) {},
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.min(context, 6),
                      ]),
                      min: 0.0,
                      max: 10.0,
                      initialValue: 7.0,
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration: const InputDecoration(
                        labelText: 'Number of things',
                      ),
                    ),
                    FormBuilderRangeSlider(
                      onSaved: (RangeValues? value) {},
                      name: 'range_slider',
                      // validator: FormBuilderValidators.compose([FormBuilderValidators.min(context, 6)]),
                      min: 0.0,
                      max: 100.0,
                      initialValue: RangeValues(4, 7),
                      divisions: 20,
                      activeColor: Colors.red,
                      inactiveColor: Colors.pink[100],
                      decoration:
                          const InputDecoration(labelText: 'Price Range'),
                    ),
                    FormBuilderCheckbox(
                      onSaved: (bool? value) {},
                      name: 'accept_terms',
                      initialValue: false,
                      title: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'I have read and agree to the ',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: 'Terms and Conditions',
                              style: TextStyle(color: Colors.blue),
                              // Flutter doesn't allow a button inside a button
                              // https://github.com/flutter/flutter/issues/31437#issuecomment-492411086
                              /*
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print('launch url');
                            },
                          */
                            ),
                          ],
                        ),
                      ),
                      validator: FormBuilderValidators.equal(
                        context,
                        true,
                        errorText:
                            'You must accept terms and conditions to continue',
                      ),
                    ),
                    FormBuilderTextField(
                      onSaved: (String? value) {},
                      autovalidateMode: AutovalidateMode.always,
                      name: 'age',
                      decoration: InputDecoration(
                        labelText: 'Age',
                        suffixIcon: _ageHasError
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.check, color: Colors.green),
                      ),
                      onChanged: (String? val) {
                        setState(() {
                          _ageHasError = !(_formKey.currentState?.fields['age']
                                  ?.validate() ??
                              false);
                        });
                      },
                      // valueTransformer: (text) => num.tryParse(text),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(context),
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.max(context, 70),
                      ]),
                      // initialValue: '12',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    FormBuilderDropdown<String>(
                      // autovalidate: true,
                      onSaved: (String? value) {},
                      name: 'gender',
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        suffix: _genderHasError
                            ? const Icon(Icons.error)
                            : const Icon(Icons.check),
                      ),
                      // initialValue: 'Male',
                      allowClear: true,
                      hint: Text('Select Gender'),
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      items: genderOptions
                          .map((String? gender) => DropdownMenuItem(
                                value: gender,
                                child: Text(gender ?? ''),
                              ))
                          .toList(),
                      onChanged: (String? val) {
                        setState(() {
                          _genderHasError = !(_formKey
                                  .currentState?.fields['gender']
                                  ?.validate() ??
                              false);
                        });
                      },
                      valueTransformer: (String? val) => val.toString(),
                    ),
                    FormBuilderRadioGroup<String>(
                      onSaved: (String? value) {},
                      decoration: const InputDecoration(
                        labelText: 'My chosen language',
                      ),
                      initialValue: null,
                      name: 'best_language',
                      validator: FormBuilderValidators.compose(
                          [FormBuilderValidators.required(context)]),
                      options:
                          ['Dart', 'Kotlin', 'Java', 'Swift', 'Objective-C']
                              .map((lang) => FormBuilderFieldOption(
                                    value: lang,
                                    child: Text(lang),
                                  ))
                              .toList(growable: false),
                      controlAffinity: ControlAffinity.trailing,
                    ),
                    FormBuilderSegmentedControl(
                      onSaved: (int? value) {},
                      decoration: const InputDecoration(
                        labelText: 'Movie Rating (Archer)',
                      ),
                      name: 'movie_rating',
                      // initialValue: 1,
                      // textStyle: TextStyle(fontWeight: FontWeight.bold),
                      options: List.generate(5, (i) => i + 1)
                          .map((number) => FormBuilderFieldOption(
                                value: number,
                                child: Text(
                                  number.toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ))
                          .toList(),
                    ),
                    FormBuilderSwitch(
                      onSaved: (bool? value) {},
                      title: const Text('I Accept the tems and conditions'),
                      name: 'accept_terms_switch',
                      initialValue: true,
                    ),
                    FormBuilderCheckboxGroup(
                      onSaved: (List<String>? value) {},
                      decoration: const InputDecoration(
                          labelText: 'The language of my people'),
                      name: 'languages',
                      // initialValue: const ['Dart'],
                      options: const [
                        FormBuilderFieldOption(value: 'Dart'),
                        FormBuilderFieldOption(value: 'Kotlin'),
                        FormBuilderFieldOption(value: 'Java'),
                        FormBuilderFieldOption(value: 'Swift'),
                        FormBuilderFieldOption(value: 'Objective-C'),
                      ],
                      separator: const VerticalDivider(
                        width: 10,
                        thickness: 5,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Theme.of(context).colorScheme.secondary,
                      onPressed: () {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          print(_formKey.currentState?.value);
                        } else {
                          print(_formKey.currentState?.value);
                          print('validation failed');
                        }
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        _formKey.currentState?.reset();
                      },
                      // color: Theme.of(context).colorScheme.secondary,
                      child: Text(
                        'Reset',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
