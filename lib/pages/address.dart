import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/addressdetails/presentation/bloc/address_details_bloc.dart';
import 'package:newsee/feature/masters/domain/modal/lov.dart';
import 'package:newsee/feature/masters/domain/modal/statecitymaster.dart';
import 'package:newsee/widgets/alpha_text_field.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/drop_down.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:newsee/widgets/searchable_drop_down.dart';
import 'package:reactive_forms/reactive_forms.dart';

class Address extends StatelessWidget {
  final String title;

  Address(String s, {required this.title, super.key});

  final form = FormGroup({
    'addresstype': FormControl<String>(validators: [Validators.required]),
    'address1': FormControl<String>(validators: [Validators.required]),
    'address2': FormControl<String>(validators: [Validators.required]),
    'address3': FormControl<String>(validators: [Validators.required]),
    'state': FormControl<String>(validators: [Validators.required]),
    'city': FormControl<String>(validators: [Validators.required]),
    'district': FormControl<String>(validators: [Validators.required]),
    'pincode': FormControl<String>(validators: [Validators.required]),
  });

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

  List<Statecitymaster> getStates(List<Statecitymaster> master) {
    List<Statecitymaster> stateMaster = [];
    for (final m in master) {
      if (stateMaster.isNotEmpty) {
        if (!stateMaster.contains(m)) {
          stateMaster.add(m);
        }
      } else {
        stateMaster.add(m);
      }
    }
    return stateMaster;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address Details"),
        automaticallyImplyLeading: false,
      ),
//<<<<<<< aadharValidationIntegration
      body: ReactiveForm(
        formGroup: form,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Dropdown(
                  controlName: 'addresstype',
                  label: 'Address Type',
                  items: ['Present', 'Permanent'],
                ),

                CustomTextField(controlName: 'address1',label: 'Address 1'),
                CustomTextField(controlName: 'address2',label: 'Address 2'),
                CustomTextField(controlName: 'address3',label: 'Address 3'),
                SearchableDropdown(
                  controlName: 'state',
                  label: 'State',
                  items: ['Tamil Nadu', 'Kerala'],
                ),
                SearchableDropdown(

                  controlName: 'city',
                  label: 'City',
                  items: ['Chennai','Madurai'],
                ),
                SearchableDropdown(
                  controlName: 'district',
                  label: 'District',
                  items: ['Sholinganallur','Navalur'],
                ),
                IntegerTextField('pincode', 'Pin Code'),
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
                      print("Address Details value ${form.value}");
                      if (form.valid) {
                        final tabController = DefaultTabController.of(context);
                        if (tabController.index < tabController.length - 1) {
                          tabController.animateTo(tabController.index + 1);
                        }
                      } else {
                        form.markAllAsTouched();
                      }
                    },
                    child: Text('Next'),
//=======
      body: BlocConsumer<AddressDetailsBloc, AddressDetailsState>(
        listener: (context, state) {
          print(
            'addressdetail::BlocConsumer:listen => ${state.lovList} ${state.addressData} ${state.status?.name}',
          );
          if (state.status == SaveStatus.success) {
            goToNextTab(context);
          }
        },
        builder:
            (context, state) => ReactiveForm(
              formGroup: form,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SearchableDropdown(
                        controlName: 'addresstype',
                        label: 'Address Type',
                        items:
                            state.lovList!
                                .where((v) => v.Header == 'AddressType')
                                .toList(),
                        onChangeListener:
                            (Lov val) => form.controls['addresstype']
                                ?.updateValue(val.optvalue),
                      ),
                      CustomTextField(
                        controlName: 'address1',
                        label: 'Address 1',
                      ),
                      CustomTextField(
                        controlName: 'address2',
                        label: 'Address 2',
                      ),
                      CustomTextField(
                        controlName: 'address3',
                        label: 'Address 3',
                      ),
                      SearchableDropdown(
                        controlName: 'state',
                        label: 'State',
                        items: getStates(state.stateCityMaster!),
                      ),
                      SearchableDropdown(
                        controlName: 'city',
                        label: 'City',
                        items: ['Chennai', 'Madurai'],
                      ),
                      SearchableDropdown(
                        controlName: 'district',
                        label: 'District',
                        items: ['Sholinganallur', 'Navalur'],
                      ),
                      IntegerTextField('pincode', 'Pin Code'),
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
                            print("Address Details value ${form.value}");
                            if (form.valid) {
                              final tabController = DefaultTabController.of(
                                context,
                              );
                              if (tabController.index <
                                  tabController.length - 1) {
                                tabController.animateTo(
                                  tabController.index + 1,
                                );
                              }
                            } else {
                              form.markAllAsTouched();
                            }
                          },
                          child: Text('Next'),
                        ),
                      ),
                    ],
//>>>>>>> main
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
