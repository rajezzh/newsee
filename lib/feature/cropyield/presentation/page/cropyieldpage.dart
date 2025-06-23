import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:newsee/feature/cropyield/presentation/bloc/cropyieldpage_bloc.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CropYieldPage extends StatelessWidget{

   final form = FormGroup({
    'sameAsLandHolding': FormControl<bool>(validators: []),
    'irrigated': FormControl<String>(validators: [Validators.required]),
    'rainfed': FormControl<String>(validators: [Validators.required]),
    'acresCropsCultiated': FormControl<String>(validators: [Validators.required]),
    'noOfCrops': FormControl<String>(validators: [Validators.required]),
    'locationOfForms': FormControl<String>(validators: [Validators.required]),
    'distanceFrombranch': FormControl<String>(validators: [Validators.required]),
    // 'state': FormControl<String>(validators: [Validators.required]),
    // 'district': FormControl<String>(validators: [Validators.required]),
    'taluk': FormControl<String>(validators: [Validators.required]),
    'village': FormControl<String>(validators: [Validators.required]),
    'firka': FormControl<String>(validators: [Validators.required]),
    'surveyNo': FormControl<String>(validators: [Validators.required]),
    // 'natureOfRight': FormControl<String>(validators: [Validators.required]),
    'cropsDetails': FormArray<Map<String, dynamic>>([])
  });

  FormGroup CropForm() {
    return FormGroup({
      'season': FormControl<String>(validators: [Validators.required]),
      'cropname': FormControl<String>(validators: [Validators.required]),
      'acrescultivated': FormControl<String>(validators: [Validators.required]),
      'typeofland': FormControl<String>(validators: [Validators.required]),
      'scaleoffincance': FormControl<String>(validators: [Validators.required]),
      'reqasperscaleoffinace': FormControl<String>(validators: [Validators.required]),
      'notifiedcrop': FormControl<String>(validators: [Validators.required]),
      'premiumperacre': FormControl<String>(validators: [Validators.required]),
      'premiumcollected': FormControl<String>(validators: [Validators.required]),
    });
  }

  final PageController _pageController = PageController();

  addCropDetails(context) {
    
    final noOfCrops = form.control('noOfCrops').value;

    if (noOfCrops != null) {
      final totNoOfcrops = int.parse('$noOfCrops');
      final cropsDetailslength = form.control('cropsDetails').value.length;
      if(totNoOfcrops > cropsDetailslength) {
        final addressArray = form.control('cropsDetails') as FormArray;
        print("addressArray $addressArray");
        addressArray.add(CropForm());
        print('Addresses length: ${addressArray.controls.length}');
        print('Form value: ${form.value}');
        Future.delayed(Duration(milliseconds: 100), () {
          _pageController.animateToPage(
            addressArray.controls.length - 1,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      } else {
        showSnack(
          context,
          message:
              'Maximum Crops Details is Added',
        );
      }
    } else {
      showSnack(
        context,
        message:
            'Please enter number of crops cultivated',
      );
    }
    
  }

  removeCropDetails(index) {
    final addressArray = form.control('cropsDetails') as FormArray;
    print("addressArray $addressArray");
    addressArray.removeAt(index);
    print('Addresses length: ${addressArray.controls.length}');
    print('Form value: ${form.value}');
    Future.delayed(Duration(milliseconds: 100), () {
      int newIndex = (_pageController.page ?? 0).round();
      if (newIndex >= addressArray.controls.length) {
        newIndex = addressArray.controls.length;
      }
      if (newIndex >= 0) {
        _pageController.animateToPage(
          newIndex + 1,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReactiveForm(
        formGroup: form,
        child: BlocProvider(
          create: (_) => CropyieldpageBloc(),
          child: BlocConsumer<CropyieldpageBloc, CropyieldpageState>(
            listener: (context, state) {
              if (state.status == CropPageStatus.success) {
                print("state-cropdetails ${state.cropdetails}");
                showSnack(
                  context,
                  message: 'Crop Details Saved Successfully',
                );
              }
            },
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20,left: 05),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: ReactiveCheckbox(
                                formControlName: 'sameAsLandHolding',
                                onChanged: (control) {
                                  print("check box change value is => ${control.value}");
                                  // context.read<AddressDetailsBloc>().add(SameAsPermanentInPresentEvent(sameAspresent: control.value));
                                },
                              ),
                            ),  
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  'Whether the crop is cultivated in the same Agriculture land holding Details',
                                  softWrap: true,
                                  style: TextStyle(fontSize: 15),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      IntegerTextField(
                        controlName: 'irrigated',
                        label: 'No of Crops Irrigated',
                        mantatory: true,
                      ),
                      IntegerTextField(
                        controlName: 'rainfed',
                        label: 'No of Crops Rainfed',
                        mantatory: true,
                      ),
                      IntegerTextField(
                        controlName: 'acresCropsCultiated',
                        label: 'No of acres crops cultivated',
                        mantatory: true,
                      ),
                      IntegerTextField(
                        controlName: 'noOfCrops',
                        label: 'No of crops cultivated / Proposed Crops',
                        mantatory: true,
                      ),
                      CustomTextField(
                        controlName: 'locationOfForms',
                        label: 'Location of the Farm',
                        mantatory: true,
                      ),
                      IntegerTextField(
                        controlName: 'distanceFrombranch',
                        label: 'Distance from Branch',
                        mantatory: true,
                      ),
                      CustomTextField(
                        controlName: 'taluk',
                        label: 'Taluk',
                        mantatory: true,
                      ),
                      CustomTextField(
                        controlName: 'village',
                        label: 'Village',
                        mantatory: true,
                      ),
                      CustomTextField(
                        controlName: 'firka',
                        label: 'Firka(as per in Adangal/Chitta/Patta)',
                        mantatory: true,
                      ),
                      CustomTextField(
                        controlName: 'surveyNo',
                        label: 'Survey Number',
                        mantatory: true,
                      ),
                      // SearchableDropdown(
                      //   controlName: 'natureOfRight',
                      //   label: 'Nature of Right',
                      //   items:
                      //       state.lovList!
                      //           .where((v) => v.Header == 'AddressType')
                      //           .toList(),
                      //   onChangeListener:
                      //       (Lov val) => form.controls['natureOfRight']
                      //           ?.updateValue(val.optvalue),
                      //   selItem: () {
                      //     if (state.status == SaveStatus.presenttreset) {
                      //       form.controls['addressType']
                      //           ?.updateValue(null);
                      //       return null;
                      //     }
                      //     else if (state.presentAddrData != null) {
                      //       Lov? lov = state.lovList?.firstWhere(
                      //         (lov) =>
                      //             lov.Header == 'AddressType' &&
                      //             lov.optvalue ==
                      //                 state.presentAddrData?.addressType,
                      //       );
                      //       form.controls['addressType']?.updateValue(
                      //         lov?.optvalue,
                      //       );
                      //       return lov;
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: Text('Crop Details')
                          ),  
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Ink(
                              decoration: ShapeDecoration(
                                color: Colors.lightBlue,
                                shape: CircleBorder(),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add,),
                                onPressed: () { 
                                  addCropDetails(context); 
                                },
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: ReactiveFormArray(
                          formArrayName: 'cropsDetails',
                          builder: (context, formArray, child) {
                            final cropsControls = formArray.controls;
                            return cropsControls.isEmpty ? SizedBox.shrink() :
                              Column(
                                children: [
                                  SizedBox(
                                    height: 1050,
                                    child: PageView.builder(
                                      controller: _pageController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: cropsControls.length,
                                      itemBuilder: (context, index) {
                                        print("form-full fiedls ${form.value}");
                                        return Card(
                                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                                      child: Text('Crops Details - ${index + 1}')
                                                    ),  
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                                                      child: Ink(
                                                        decoration: ShapeDecoration(
                                                          color: Colors.lightBlue,
                                                          shape: CircleBorder(),
                                                        ),
                                                        child: IconButton(
                                                          icon: Icon(Icons.cancel,),
                                                          onPressed: () { removeCropDetails(index); },
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.season',
                                                  label: 'Seson',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.cropname',
                                                  label: 'Crop name',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.acrescultivated',
                                                  label: 'Acre of cultivated',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.typeofland',
                                                  label: 'Type of Land',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.scaleoffincance',
                                                  label: 'Scale of finance',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.reqasperscaleoffinace',
                                                  label: 'Request as per scale of finance',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.notifiedcrop',
                                                  label: 'Notified crop',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.premiumperacre',
                                                  label: 'Premium per acre',
                                                  mantatory: true,
                                                ),
                                                CustomTextField(
                                                  controlName: '$index.premiumcollected',
                                                  label: 'Premium Collected',
                                                  mantatory: true,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SmoothPageIndicator(
                                    controller: _pageController,
                                    count: cropsControls.length,
                                    // effect: WormEffect(),
                                    effect:  SlideEffect(    
                                      spacing:  8.0,    
                                      radius:  4.0,    
                                      dotWidth:  24.0,    
                                      dotHeight:  16.0,    
                                      paintStyle:  PaintingStyle.stroke,    
                                      strokeWidth:  1.5,    
                                      dotColor:  Colors.grey,    
                                      activeDotColor:  Colors.indigo    
                                    ), 
                                  )
                                ]
                              );
                          },
                        ),
                      ),
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
                            final noOfCrops = int.parse('${form.control('noOfCrops').value}');
                            print("noOfCrops $noOfCrops");
                            print("noOfCrops-runtimeType ${noOfCrops.runtimeType}");
                            final cropslength = form.control('cropsDetails').value.length;
                            print("cropslength $cropslength");
                            print("cropslength-runtimeType ${cropslength.runtimeType}");
                            if (noOfCrops == cropslength) {
                              if (form.valid) {
                                print("CropYield form data ${form.value}");
                                context.read<CropyieldpageBloc>().add(CropFormSaveEvent(request: form.value));
                              } else {
                                form.markAllAsTouched();
                                showSnack(
                                  context,
                                  message:
                                      'Please Check Error Message and Enter Valid Data',
                                );
                              }
                            } else {
                              showSnack(
                                context,
                                message:
                                    'Please Add $noOfCrops Crops Details',
                              );
                            }
                            
                          },
                          child: Text('Save'),
                        ),
                      ),
                    ]
                  ),
                ),
              );
            }
          ),
        )
      ),
    );
  }
}