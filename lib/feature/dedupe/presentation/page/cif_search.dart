import 'package:flutter/material.dart';
import 'package:newsee/pages/customer_response_page.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:popover/popover.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CIFSearch extends StatelessWidget {

  final dedupeForm = FormGroup({
    'cifid': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: dedupeForm,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField('cifid', 'CIF ID'),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7, 
                          width: MediaQuery.of(context).size.width,
                          child: CustomerResponsePage(),
                        )
                        
                      );
                    },
                  );
                }, 
                child: Text("Search")
              )
            ],
          )
        )
      )
    );
  }
}