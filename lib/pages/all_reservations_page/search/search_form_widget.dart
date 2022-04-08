import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class SearchFormWidget extends StatelessWidget {
   SearchFormWidget({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width,
      // height: 100,
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(

                decoration: const InputDecoration(
                  label: Text('Customer'),
                  icon:  Icon(Icons.person),
                ),
                name: 'email',
                validator: FormBuilderValidators.compose([
                  // FormBuilderValidators.required(context),
                  // FormBuilderValidators.email(context),
                ]),
              ),

              DateTimePicker(
                  initialDate: DateTime.now() ,
                  type: DateTimePickerType.date,
                  dateMask: 'dd MMM, yyyy',
                  // controller: _timeController,
                  //initialValue: _initialValue,
                  firstDate: DateTime(2018),
                  lastDate: DateTime(2100),
                  icon: const Icon(Icons.event),
                  dateLabelText: 'Date',
                  onChanged: (day) {

                  }),


               const SizedBox(height: 20,)

              // ElevatedButton(
              //   onPressed: () {
              //     if (_formKey.currentState!.saveAndValidate()) {
              //       print(_formKey.currentState!.value['email']);
              //       print(_formKey.currentState!.value['password']);
              //     }
              //   },
              //   child: const Text('Save'),
              // ),
            ],
          ),
        ),
      ),

    );
  }
}
