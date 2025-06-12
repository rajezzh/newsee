import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/Model/personal_data.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_request.dart';
import 'package:newsee/feature/cif/presentation/bloc/cif_bloc.dart';
import 'package:newsee/feature/dedupe/presentation/bloc/dedupe_bloc.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/personaldetails/presentation/bloc/personal_details_bloc.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:newsee/widgets/searchable_drop_down.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Personal extends StatelessWidget {
  final String title;

  Personal(String s, {required this.title, super.key});

  final form = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'firstName': FormControl<String>(validators: [Validators.required]),
    'middleName': FormControl<String>(validators: [Validators.required]),
    'lastName': FormControl<String>(validators: [Validators.required]),
    'dob': FormControl<String>(validators: [Validators.required]),
    'primaryMobileNumber': FormControl<String>(
      validators: [Validators.required],
    ),
    'secondaryMobileNumber': FormControl<String>(
      validators: [Validators.required],
    ),
    'email': FormControl<String>(validators: [Validators.email]),
    'panNumber': FormControl<String>(validators: [Validators.required]),
    'aadhaar': FormControl<String>(validators: []),
    'aadharRefNo': FormControl<String>(validators: [Validators.required]),
    'loanAmountRequested': FormControl<String>(
      validators: [Validators.required],
    ),
    'natureOfActivity': FormControl<String>(validators: [Validators.required]),
  });

  bool refAadhaar = false;

  void showSnack(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void goToNextTab(BuildContext context) {
    showSnack(context, message: 'Personal Details Saved Successfully');
    final tabController = DefaultTabController.of(context);
    if (tabController.index < tabController.length - 1) {
      tabController.animateTo(tabController.index + 1);
    }
  }

  mapAadhaarData(val) {
    try {
      if (val != null) {
        form.control('aadharRefNo').updateValue(val?.referenceId);
        refAadhaar = true;
        if (val.name != null) {
          String fullname = val?.name;
          List getNameArray = fullname.split(' ');
          if (getNameArray.length > 2) {
            String fullname = getNameArray.sublist(2).join();
            form.control('firstName').updateValue(getNameArray[0]);
            form.control('middleName').updateValue(getNameArray[1]);
            form.control('lastName').updateValue(fullname);
          } else if (getNameArray.length == 2) {
            form.control('firstName').updateValue(getNameArray[0]);
            form.control('lastName').updateValue(getNameArray[1]);
          } else if (getNameArray.length == 1) {
            form.control('firstName').updateValue(getNameArray[0]);
          } 
        }
        // form.control('title').updateValue(state.aadhaarData?.gender ? state.aadhaarData?.gender : form.control('title').value);
        form.control('dob').updateValue(val?.dateOfBirth!);
        form.control('primaryMobileNumber').updateValue(val?.mobile!);
        form.control('email').updateValue(val?.email!);
      }
    } catch(error) {
      print("autoPopulateData-catch-error $error");
    }
  }

  mapCifDate(val) {
    try {
      form.control('firstName').updateValue(val['lleadfrstname']!);
      form.control('middleName').updateValue(val['lleadmidname']!);
      form.control('lastName').updateValue(val['lleadlastname']!);
      form.control('dob').updateValue(getDateFormat(val['lleaddob']!));
      form.control('primaryMobileNumber').updateValue(val['lleadmobno']!);
      form.control('email').updateValue(val['lleademailid']!);
      form.control('panNumber').updateValue(val['lleadpanno']!);
      form.control('aadharRefNo').updateValue(val['lleadadharno']!);  
      form.control('title').updateValue(val['lleadtitle']!);    
    } catch(error) {
      print("autoPopulateData-catch-error $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<PersonalDetailsBloc, PersonalDetailsState>(
        listener: (context, state) {
          print(
            'personaldetail::BlocConsumer:listen => ${state.lovList} ${state.personalData} ${state.status?.name}',
          );
          if (state.status == SaveStatus.success) {
            goToNextTab(context);
          } else if (state.status == SaveStatus.datafetch && state.aadhaarData != null) {
            mapAadhaarData(state.aadhaarData);
          } else if (state.status == SaveStatus.datafetch && state.lovList != null) {
            final cifState = context.read<CifBloc>().state;
            if (cifState.cifResponseModel != null && cifState.cifResponseModel!.lpretLeadDetails.isNotEmpty) {
              mapCifDate(cifState.cifResponseModel?.lpretLeadDetails);
            }
            final dedupeState = context.read<DedupeBloc>().state;
            if (dedupeState.aadharvalidateResponse != null) {
              mapAadhaarData(dedupeState.aadharvalidateResponse);
            } else if (dedupeState.dedupeResponse!.remarksFlag ) {
            }
          }
        },
        builder:
            (context, state)  {              
              return ReactiveForm(
                formGroup: form,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SearchableDropdown(
                          controlName: 'title',
                          label: 'Title',
                          items:
                              state.lovList!
                                  .where((v) => v.Header == 'Title')
                                  .toList(),
                          onChangeListener:
                              (Lov val) => form.controls['title']?.updateValue(
                                val.optvalue,
                              ),
                        ),
                        CustomTextField(
                          controlName: 'firstName',
                          label: 'First Name',
                          mantatory: true,
                        ),
                        CustomTextField(
                          controlName: 'middleName',
                          label: 'Middle Name',
                          mantatory: true,
                        ),
                        CustomTextField(
                          controlName: 'lastName',
                          label: 'Last Name',
                          mantatory: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: ReactiveTextField<String>(
                            formControlName: 'dob',
                            validationMessages: {
                              ValidationMessage.required:
                                  (error) => 'Date of Birth is required',
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Date Of Birth',
                              suffixIcon: Icon(Icons.calendar_today),
                            ),
                            onTap: (control) async {
                              final DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().subtract(
                                  Duration(days: 365 * 18),
                                ),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now(),
                              );
                              if (pickedDate != null) {
                                final formatted =
                                    "${pickedDate.day.toString().padLeft(2, '0')}/"
                                    "${pickedDate.month.toString().padLeft(2, '0')}/"
                                    "${pickedDate.year}";
                                form.control('dob').value = formatted;
                              }
                            },
                          ),
                        ),
                        IntegerTextField(
                          controlName: 'primaryMobileNumber',
                          label: 'Primary Mobile Number',
                          mantatory: true,
                          maxlength: 10,
                          minlength: 10,
                        ),
                        IntegerTextField(
                          controlName: 'secondaryMobileNumber',
                          label: 'Secondary Mobile Number',
                          mantatory: true,
                          maxlength: 10,
                          minlength: 10,
                        ),
                        CustomTextField(
                          controlName: 'email', 
                          label: 'Email Id',
                          mantatory: true,
                        ),
                        CustomTextField(
                          controlName: 'panNumber',
                          label: 'Pan No',
                          mantatory: true,
                        ),
                        refAadhaar ? 
                        IntegerTextField(
                          controlName: 'aadharRefNo', 
                          label: 'Aadhaar No',
                          mantatory: true,
                          maxlength: 12,
                          minlength: 12,
                        ) :
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IntegerTextField(
                                controlName: 'aadhaar',
                                label: 'Aadhaar Number',
                                mantatory: true,
                                maxlength: 12,
                                minlength: 12,
                              ),
                            ),
                            const SizedBox(width: 8),
                            // if (state.?.remarksFlag == false)
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
                                  final AadharvalidateRequest
                                  aadharvalidateRequest = AadharvalidateRequest(
                                    aadhaarNumber:
                                        form.control('aadhaar').value,
                                  );
                                  context.read<PersonalDetailsBloc>().add(
                                    AadhaarValidateEvent(
                                      request: aadharvalidateRequest,
                                    ),
                                  );
                                  print(state.aadhaarData);
                                },
                                child: state.status == SaveStatus.loading ? CircularProgressIndicator() : const Text("Validate"),
                              ),
                          ],
                        ),
                        IntegerTextField(
                          controlName: 'loanAmountRequested',
                          label: 'Loan Amount Required',
                          mantatory: true,
                        ),
                        SearchableDropdown(
                          controlName: 'natureOfActivity',
                          label: 'Nature of Activity',
                          items:
                              state.lovList!
                                  .where((v) => v.Header == 'NatureOfActivity')
                                  .toList(),
                          onChangeListener:
                              (Lov val) => form.controls['natureOfActivity']
                                  ?.updateValue(val.optvalue),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 3, 9, 110),
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              print("personal Details value ${form.value}");

                              if (form.valid) {
                                PersonalData personalData = PersonalData.fromMap(
                                  form.value,
                                );
                                context.read<PersonalDetailsBloc>().add(
                                  PersonalDetailsSaveEvent(
                                    personalData: personalData,
                                  ),
                                );
                              } else {
                                form.markAllAsTouched();
                                showSnack(
                                  context,
                                  message:
                                      'Please Check Error Message and Enter Valid Data',
                                );
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     content: Text(
                                //       'Please Check Error Message and Enter Valid Data ',
                                //     ),
                                //   ),
                                // );
                              }
                            },
                            child: Text('Next'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
      ),
    );
  }
}
