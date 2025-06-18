import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppData/app_forms.dart';
import 'package:newsee/Model/address_data.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:newsee/feature/aadharvalidation/domain/modal/aadharvalidate_response.dart';
import 'package:newsee/feature/addressdetails/presentation/bloc/address_details_bloc.dart';
import 'package:newsee/feature/cif/domain/model/user/cif_response.dart';
import 'package:newsee/feature/dedupe/presentation/bloc/dedupe_bloc.dart';
import 'package:newsee/feature/loader/presentation/bloc/global_loading_bloc.dart';
import 'package:newsee/feature/loader/presentation/bloc/global_loading_event.dart';
import 'package:newsee/feature/masters/domain/modal/geography_master.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/statecitymaster.dart';
import 'package:newsee/widgets/custom_loading.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:newsee/widgets/loader.dart';
import 'package:newsee/widgets/searchable_drop_down.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Address extends StatelessWidget {
  final String title;

  Address({required this.title, super.key});

  final permanantForm = FormGroup({
    'addressType': FormControl<String>(validators: [Validators.required]),
    'address1': FormControl<String>(validators: [Validators.required]),
    'address2': FormControl<String>(validators: [Validators.required]),
    'address3': FormControl<String>(validators: [Validators.required]),
    'state': FormControl<String>(validators: [Validators.required]),
    'cityDistrict': FormControl<String>(validators: [Validators.required]),
    'area': FormControl<String>(validators: [Validators.required]),
    'pincode': FormControl<String>(
      validators: [Validators.required, Validators.minLength(6)],
    ),
  });

  final presentform = AppForms.PRESENT_ADDRESS_FORM;

  void showSnack(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void goToNextTab(BuildContext context) {
    showSnack(context, message: 'Address Details Saved Successfully');
    final tabController = DefaultTabController.of(context);
    if (tabController.index < tabController.length - 1) {
      tabController.animateTo(tabController.index + 1);
    }
  }

  void mapCifResponse(CifResponse val, FormGroup form) {
    try {
      form.control('address1').updateValue(val.lleadaddress!);
      form.control('address2').updateValue(val.lleadaddresslane1!);
      form.control('address3').updateValue(val.lleadaddresslane2!);
      form.control('pincode').updateValue(val.lleadpinno!);
    } catch(error) {
      print('address.dart - mapCifResponse => $error');
    }
  }

  void mapAadhaarResponse(AadharvalidateResponse val, FormGroup form) {
    try {
      String fullAddress = '${val.house} ${val.street} ${val.locality} ${val.vtcName} ${val.postOfficeName}';
      print("fullAddress $fullAddress");
      print("fullAddresslength ${fullAddress.length}");
      String? lineOne = addressSplit(fullAddress);
      print("lineOne $lineOne");
      print("lineOne.length ${lineOne!.length}");
      form.control('address1').updateValue(lineOne);
      String? lineTwo = addressSplit(fullAddress.substring(lineOne.length));
      print("lineTwo $lineTwo");
      print("lineTwo.length ${lineTwo!.length}");
      form.control('address2').updateValue(lineTwo);
      int twolinelength = lineOne.length + lineTwo.length + 1;
      print("twolinelength $twolinelength");
      if (fullAddress.length > twolinelength) {
        String? lineThree = addressSplit(
          fullAddress.substring(lineOne.length + lineTwo.length),
        );
        print("lineThree $lineThree");
        form.control('address3').updateValue(lineThree);
      }
      form.control('pincode').updateValue(val.pincode);
    } catch(error) {
      print('address.dart - mapCifResponse => $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalLoadingBloc = context.read<GlobalLoadingBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Details"),
        automaticallyImplyLeading: false,
      ),
      body: BlocConsumer<AddressDetailsBloc, AddressDetailsState>(
        listener: (context, state) {
          print(
            'addressdetail::BlocConsumer:listen => ${state.lovList} ${state.addressData} ${state.status?.name}',
          );
          print('addressdetail-status => ${state.status}');
          print('addressdetail-addressData => ${state.addressData}');
          print('addressdetail-presentAddrData => ${state.presentAddrData}');
          if (state.status == SaveStatus.success && state.addressData != null && state.presentAddrData != null) {
            goToNextTab(context);
          } else if (state.status == SaveStatus.success && state.addressData != null) {
            showSnack(context, message: 'Permanent Address Details Saved Successfully');
          }
          if (state.status == SaveStatus.mastersucess ||
              state.status == SaveStatus.failure) {
            globalLoadingBloc.add(HideLoading());
          }
        },
        builder: (context, state) {
          DedupeState? dedupeState;
          if (state.cityMaster != null && state.cityMaster!.isEmpty) {
            permanantForm.controls['city']?.updateValue(null);
          }
          if (state.presentCityMaster != null && state.presentCityMaster!.isEmpty) {
            presentform.controls['city']?.updateValue(null);
          }
          if (state.status == SaveStatus.init) {
            dedupeState = context.watch<DedupeBloc>().state;
            if (dedupeState.cifResponse != null) {
              CifResponse cifResponse =  dedupeState.cifResponse!;
              mapCifResponse(cifResponse, permanantForm);
            } else if (dedupeState.aadharvalidateResponse != null) {
              AadharvalidateResponse aadhaarResponse = dedupeState.aadharvalidateResponse!;
              mapAadhaarResponse(aadhaarResponse, permanantForm);
            }
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                // alignment: Alignment.topLeft,
                children: [
                  SizedBox(
                    child: Text("Permanent Address"),
                  ),
                  SizedBox(
                    child: ReactiveForm(
                      formGroup: permanantForm,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SearchableDropdown(
                                controlName: 'addressType',
                                label: 'Address Type',
                                items:
                                    state.lovList!
                                        .where((v) => v.Header == 'AddressType')
                                        .toList(),
                                onChangeListener:
                                    (Lov val) => permanantForm.controls['addressType']
                                        ?.updateValue(val.optvalue),
                                selItem: () {
                                  if (state.addressData != null) {
                                    Lov? lov = state.lovList?.firstWhere(
                                      (lov) =>
                                          lov.Header == 'AddressType' &&
                                          lov.optvalue ==
                                              state.addressData?.addressType,
                                    );
                                    permanantForm.controls['addressType']?.updateValue(
                                      lov?.optvalue,
                                    );
                                    return lov;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CustomTextField(
                                controlName: 'address1',
                                label: 'Address 1',
                                mantatory: true,
                              ),
                              CustomTextField(
                                controlName: 'address2',
                                label: 'Address 2',
                                mantatory: true,
                              ),
                              CustomTextField(
                                controlName: 'address3',
                                label: 'Address 3',
                                mantatory: true,
                              ),
                              SearchableDropdown(
                                controlName: 'state',
                                label: 'State',
                                items: state.stateCityMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  permanantForm.controls['state']?.updateValue(val.code);
                                  globalLoadingBloc.add(
                                    ShowLoading(message: "Fetching city..."),
                                  );
                                  context.read<AddressDetailsBloc>().add(
                                    OnStateCityChangeEvent(stateCode: val.code),
                                  );
                                },
                                selItem: () {
                                //   if (dedupeState?.cifResponse != null) {
                                //     print("dedupeState?.cifResponse true here");
                                //     String? statecode = dedupeState?.cifResponse?.lleadstate;
                                //     print("dedupeState?.cifResponse statecode => $statecode");
                                //     GeographyMaster? statelist = state.stateCityMaster?.firstWhere(
                                //       (lov) => lov.code == statecode,
                                //     );
                                //     String val = statelist?.value as String;
                                //     print("dedupeState?.cifResponse statelist => $statelist");
                                //     permanantForm.controls['state']?.updateValue(val);
                                //     globalLoadingBloc.add(
                                //       ShowLoading(message: "Fetching city..."),
                                //     );
                                //     context.read<AddressDetailsBloc>().add(
                                //       OnStateCityChangeEvent(stateCode: val, formname: 'permanent'),
                                //     );
                                    
                                //     return statelist;
                                //   } else if (dedupeState?.aadharvalidateResponse != null) {
                                //     String? statecode = dedupeState?.aadharvalidateResponse?.state.toUpperCase();
                                //     print("aadharvalidateResponse-statecode $statecode");
                                //     GeographyMaster? statelist = state.stateCityMaster?.firstWhere(
                                //       (lov) => lov.value == statecode,
                                //     );
                                //     String val = statelist?.value as String;
                                //     print("dedupeState?.aadharvalidateResponse statelist => $statelist");
                                //     permanantForm.controls['state']?.updateValue(val);
                                //     globalLoadingBloc.add(
                                //       ShowLoading(message: "Fetching city..."),
                                //     );
                                //     context.read<AddressDetailsBloc>().add(
                                //       OnStateCityChangeEvent(stateCode: val, formname: 'permanent'),
                                //     );
                                    
                                //     return statelist;
                                //   } else if (state.addressData != null) {
                                //     GeographyMaster? statelist = state.stateCityMaster?.firstWhere(
                                //       (lov) => lov.code == '',
                                //     );
                                //     permanantForm.controls['state']?.updateValue(statelist?.value);
                                //     return statelist;
                                //   } else {
                                //     return null;
                                //   }
                                },
                              ),
                              SearchableDropdown(
                                controlName: 'cityDistrict',
                                label: 'City',
                                items: state.cityMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  permanantForm.controls['cityDistrict']?.updateValue(
                                    val.code,
                                  );
                                  globalLoadingBloc.add(
                                    ShowLoading(message: "Fetching district..."),
                                  );
                                  context.read<AddressDetailsBloc>().add(
                                    OnStateCityChangeEvent(
                                      stateCode:
                                          permanantForm.controls['state']?.value as String,
                                      cityCode: val.code
                                    ),
                                  );
                                },
                                selItem: () => null,
                              ),
                              SearchableDropdown(
                                controlName: 'area',
                                label: 'District',
                                items: state.districtMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  permanantForm.controls['area']?.updateValue(val.code);
                                },
                                selItem: () => null,
                              ),
                              IntegerTextField(
                                controlName: 'pincode',
                                label: 'Pin Code',
                                mantatory: true,
                                maxlength: 6,
                                minlength: 6,
                              ),
                              SizedBox(height: 20),
                              // ElevatedButton(onPressed: () {}, child: Text("ADD")),
                              // SizedBox(height: 50),
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
                                    print("Permanent Address Details value ${permanantForm.value}");
                                    if (permanantForm.valid) {
                                      AddressData addressData = AddressData.fromMap(
                                        permanantForm.value,
                                      );
                                      print("permananentAddressData $addressData");
                                      context.read<AddressDetailsBloc>().add(
                                        AddressDetailsSaveEvent(
                                          addressData: addressData,
                                        ),
                                      );
                                    } else {
                                      permanantForm.markAllAsTouched();
                                    }
                                  },
                                  child: Text('Next'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // if (state.status == SaveStatus.loading)
                  //   const Center(child: CustomLoading()),
                  SizedBox(height: 50,),
                  SizedBox(
                    child: Text("Present Address"),
                  ),
                  SizedBox(
                    child: ReactiveForm(
                      formGroup: presentform,
                      child: SafeArea(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SearchableDropdown(
                                controlName: 'addressType',
                                label: 'Address Type',
                                items:
                                    state.lovList!
                                        .where((v) => v.Header == 'AddressType')
                                        .toList(),
                                onChangeListener:
                                    (Lov val) => presentform.controls['addressType']
                                        ?.updateValue(val.optvalue),
                                selItem: () {
                                  if (state.presentAddrData != null) {
                                    Lov? lov = state.lovList?.firstWhere(
                                      (lov) =>
                                          lov.Header == 'AddressType' &&
                                          lov.optvalue ==
                                              state.addressData?.addressType,
                                    );
                                    presentform.controls['addressType']?.updateValue(
                                      lov?.optvalue,
                                    );
                                    return lov;
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              CustomTextField(
                                controlName: 'address1',
                                label: 'Address 1',
                                mantatory: true,
                              ),
                              CustomTextField(
                                controlName: 'address2',
                                label: 'Address 2',
                                mantatory: true,
                              ),
                              CustomTextField(
                                controlName: 'address3',
                                label: 'Address 3',
                                mantatory: true,
                              ),
                              SearchableDropdown(
                                controlName: 'state',
                                label: 'State',
                                items: state.stateCityMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  presentform.controls['state']?.updateValue(val.code);
                                  globalLoadingBloc.add(
                                    ShowLoading(message: "Fetching city..."),
                                  );
                                  context.read<AddressDetailsBloc>().add(
                                    OnPresentStateCityChangeEvent(stateCode: val.code,),
                                  );
                                },
                                selItem: () => null,
                              ),
                              SearchableDropdown(
                                controlName: 'cityDistrict',
                                label: 'City',
                                items: state.presentCityMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  presentform.controls['cityDistrict']?.updateValue(
                                    val.code,
                                  );
                                  globalLoadingBloc.add(
                                    ShowLoading(message: "Fetching district..."),
                                  );
                                  context.read<AddressDetailsBloc>().add(
                                    OnPresentStateCityChangeEvent(
                                      stateCode:
                                          presentform.controls['state']?.value as String,
                                      cityCode: val.code
                                    ),
                                  );
                                },
                                selItem: () => null,
                              ),
                              SearchableDropdown(
                                controlName: 'area',
                                label: 'District',
                                items: state.presentDistrictMaster!,
                                onChangeListener: (GeographyMaster val) {
                                  presentform.controls['area']?.updateValue(val.code);
                                },
                                selItem: () => null,
                              ),
                              IntegerTextField(
                                controlName: 'pincode',
                                label: 'Pin Code',
                                mantatory: true,
                                maxlength: 6,
                                minlength: 6,
                              ),
                              SizedBox(height: 20),
                              // ElevatedButton(onPressed: () {}, child: Text("ADD")),
                              // SizedBox(height: 50),
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
                                    print("Present Address Details value ${presentform.value}");
                                    if (presentform.valid) {
                                      AddressData presentAddressData = AddressData.fromMap(
                                        presentform.value,
                                      );
                                      print("presentAddressData $presentAddressData");
                                      context.read<AddressDetailsBloc>().add(
                                        PresentAddressDetailsSaveEvent(
                                          presentaddressData: presentAddressData,
                                        ),
                                      );
                                    } else {
                                      presentform.markAllAsTouched();
                                    }
                                  },
                                  child: Text('Next'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
