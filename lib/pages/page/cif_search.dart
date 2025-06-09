import 'package:flutter/material.dart';
import 'package:newsee/pages/page/customer_response_page.dart';
import 'package:newsee/widgets/custom_text_field.dart';
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 3, 9, 110),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  print("cif id value ${dedupeForm.value}");
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
                        ),
                      );
                    },
                  );
                },
                child: Text("Search"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
