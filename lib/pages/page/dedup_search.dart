import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:newsee/feature/aadharvalidation/data/repository/aadhar_validate_impl.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_request.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';
import 'package:newsee/feature/aadharvalidation/domain/repository/aadharvalidate_repo.dart';
import 'package:newsee/feature/aadharvalidation/presentation/bloc/aadhar_bloc.dart';
import 'package:newsee/feature/aadharvalidation/presentation/bloc/aadhar_event.dart';
import 'package:newsee/feature/aadharvalidation/presentation/bloc/aadhar_state.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/drop_down.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DedupeSearch extends StatelessWidget {
  final FormGroup dedupeForm = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'firstname': FormControl<String>(validators: [Validators.required]),
    'lastname': FormControl<String>(validators: [Validators.required]),
    'mobilenumber': FormControl<String>(validators: [Validators.required]),
    'pan': FormControl<String>(validators: [Validators.required]),
    'aadhaar': FormControl<String>(validators: [Validators.required]),
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => AadharBloc(
            aadharRepo: AadharValidateImpl(),
            initState: AadharState(
              status: AadharValidateStatus.init,
              aadharvalidateResponse: AadharvalidateResponse(),
            ),
          ),
      child: BlocBuilder<AadharBloc, AadharState>(
        builder: (context, state) {
          final aadharBloc = context.read<AadharBloc>();

          return ReactiveForm(
            formGroup: dedupeForm,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Dropdown(
                      controlName: 'title',
                      label: 'Title',
                      items: ['Mr', 'Mrs', 'Miss', 'Others'],
                    ),
                    CustomTextField('firstname', 'First Name'),
                    CustomTextField('lastname', 'Last Name'),
                    IntegerTextField('mobilenumber', 'Mobile Number'),
                    CustomTextField('pan', 'PAN Number'),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: IntegerTextField('aadhaar', 'Aadhaar Number'),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              3,
                              9,
                              110,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            final aadhaarValue =
                                dedupeForm.control('aadhaar').value;
                            // if (aadhaarValue != null &&
                            //     aadhaarValue.toString().length == 12) {
                            aadharBloc.add(
                              ValiateAadharEvent(
                                request: AadharvalidateRequest(
                                  aadhaarNumber: "12345678909",
                                ),
                              ),
                            );
                            print(state.aadharvalidateResponse);
                            // } else {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text("Invalid Aadhaar Number"),
                            //     ),
                            //   );
                            // }
                          },
                          child: const Text("Validate"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 3, 9, 110),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (dedupeForm.valid) {
                          // Perform search logic here
                        } else {
                          dedupeForm.markAllAsTouched();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please fill all required fields."),
                            ),
                          );
                        }
                      },
                      child: const Text("Search"),
                    ),
                    if (state.status == AadharValidateStatus.loading)
                      const Center(child: CircularProgressIndicator())
                    else if (state.status == AadharValidateStatus.success)
                      Text(
                        "Validation Successful: ${state.aadharvalidateResponse}",
                        style: const TextStyle(color: Colors.green),
                      )
                    else if (state.status == AadharValidateStatus.failue)
                      Text(
                        "Error: ${state.errorMsg ?? "Validation Failed"}",
                        style: const TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
