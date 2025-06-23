// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:newsee/AppData/app_forms.dart';
// import 'package:newsee/feature/landholding/domain/modal/LandData.dart';
// import 'package:newsee/feature/landholding/presentation/bloc/land_holding_bloc.dart';
// import 'package:newsee/feature/masters/domain/modal/lov.dart';
// import 'package:newsee/feature/personaldetails/presentation/bloc/personal_details_bloc.dart';
// import 'package:newsee/widgets/searchable_drop_down.dart';
// import 'package:reactive_forms/reactive_forms.dart';
// import 'package:newsee/widgets/custom_text_field.dart';
// import 'package:newsee/widgets/drop_down.dart';
// import 'package:newsee/widgets/radio.dart';
// import 'package:newsee/widgets/integer_text_field.dart';

// class LandInfoFormPage extends StatelessWidget {
//   final String title;

//   final form = AppForms.CROP_DETAILS_FORM;

//   LandInfoFormPage({super.key, required this.title});

//   void handleSubmit(BuildContext context, LandHoldingState state) {
//     if (form.valid) {
//       final landFormData = LandData.fromForm(form.value);
//       context.read<LandHoldingBloc>().add(
//         LandDetailsSaveEvent(landData: landFormData),
//       );
//     } else {
//       form.markAllAsTouched();
//     }
//   }

//   void showBottomSheet(BuildContext context, LandHoldingState state) {
//     final entries = state.landData ?? [];

//     showModalBottomSheet(
//       context: context,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//       ),
//       builder:
//           (_) => SizedBox(
//             height: 300,
//             child:
//                 entries.isEmpty
//                     ? const Center(child: Text('No saved entries.'))
//                     : ListView.separated(
//                       padding: const EdgeInsets.all(16),
//                       itemCount: entries.length,
//                       separatorBuilder: (_, __) => const Divider(),
//                       itemBuilder: (ctx, index) {
//                         final item = entries[index];
//                         return ListTile(
//                           title: Text(item.applicantName),
//                           subtitle: Text(item.locationOfFarm),
//                           trailing: const Icon(
//                             Icons.arrow_forward_ios,
//                             size: 16,
//                           ),
//                           onTap: () {
//                             Navigator.pop(context);
//                             context.read<LandHoldingBloc>().add(
//                               LandDetailsLoadEvent(landData: item),
//                             );
//                           },
//                         );
//                       },
//                     ),
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title)),
//       body: BlocProvider(
//         create: (_) => LandHoldingBloc()..add(LandHoldingInitEvent()),
//         child: BlocConsumer<LandHoldingBloc, LandHoldingState>(
//           listener: (context, state) {
//             if (state.status == SaveState.success) {
//               form.reset();
//             }
//             if (state.selectedLandData != null) {
//               form.patchValue(state.selectedLandData!.toMap());
//             }
//           },
//           builder: (context, state) {
//             return ReactiveForm(
//               formGroup: form,
//               child: SafeArea(
//                 child: Stack(
//                   children: [
//                     SingleChildScrollView(
//                       padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: 12),
//                           Card(
//                             elevation: 4,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             child: Padding(
//                               padding: const EdgeInsets.all(16),
//                               child: Column(
//                                 children: [
//                                   Dropdown(
//                                     controlName: 'applicantName',
//                                     label: 'Applicant Name / Guarantor',
//                                     items: [
//                                       '--Select--',
//                                       'Ravi Kumar',
//                                       'Sita Devi',
//                                       'Vikram R',
//                                     ],
//                                   ),
//                                   CustomTextField(
//                                     controlName: 'locationOfFarm',
//                                     label: 'Location of Farm',
//                                     mantatory: true,
//                                   ),
//                                   Dropdown(
//                                     controlName: 'state',
//                                     label: 'State',
//                                     items: [
//                                       '--Select--',
//                                       'Tamil Nadu',
//                                       'Kerala',
//                                       'Karnataka',
//                                     ],
//                                   ),
//                                   CustomTextField(
//                                     controlName: 'taluk',
//                                     label: 'Taluk',
//                                     mantatory: true,
//                                   ),
//                                   IntegerTextField(
//                                     controlName: 'firka',
//                                     label:
//                                         'Firka (as per Adangal/Chitta/Patta)',
//                                     mantatory: true,
//                                   ),
//                                   IntegerTextField(
//                                     controlName: 'totalAcreage',
//                                     label: 'Total Acreage (in Acres)',
//                                     mantatory: true,
//                                   ),
//                                   IntegerTextField(
//                                     controlName: 'irrigatedLand',
//                                     label:
//                                         'Out of Total acreage, how much is the Irrigated Land (in Acres)',
//                                     mantatory: true,
//                                   ),
//                                   RadioButton(
//                                     label: 'Lands situated in compact blocks',
//                                     controlName: 'compactBlocks',
//                                     optionOne: 'Yes',
//                                     optionTwo: 'No',
//                                   ),
//                                   RadioButton(
//                                     label:
//                                         'Do the particulars of the holdings given in the application tally with the particulars given in village officers certificate',
//                                     controlName: 'villageOfficerCertified',
//                                     optionOne: 'Yes',
//                                     optionTwo: 'No',
//                                   ),
//                                   RadioButton(
//                                     label: 'Land owned by the Applicant',
//                                     controlName: 'landOwnedByApplicant',
//                                     optionOne: 'Yes',
//                                     optionTwo: 'No',
//                                   ),
//                                   IntegerTextField(
//                                     controlName: 'distanceFromBranch',
//                                     label: 'Distance from Branch (in Kms)',
//                                     mantatory: true,
//                                   ),
//                                   Dropdown(
//                                     controlName: 'district',
//                                     label: 'District',
//                                     items: [
//                                       '--Select--',
//                                       'Chennai',
//                                       'Madurai',
//                                       'Coimbatore',
//                                     ],
//                                   ),
//                                   CustomTextField(
//                                     controlName: 'village',
//                                     label: 'Village',
//                                     mantatory: true,
//                                   ),
//                                   IntegerTextField(
//                                     controlName: 'surveyNo',
//                                     label: 'Survey No.',
//                                     mantatory: true,
//                                   ),
//                                   // Dropdown(
//                                   //   controlName: '',
//                                   //   label: 'Nature of Right',
//                                   //   items: [
//                                   //     '--Select--',
//                                   //     'Owned',natureOfRight
//                                   //     'Leaseholder',
//                                   //     'Ancestral',
//                                   //   ],
//                                   // ),
//                                   SearchableDropdown<Lov>(
//                                     controlName: 'natureOfRight',
//                                     label: 'Nature of Right',
//                                     items:
//                                         state.lovlist!
//                                             .where(
//                                               (v) =>
//                                                   v.Header == 'NatureOfRight',
//                                             )
//                                             .toList(),
//                                     onChangeListener: (Lov val) {
//                                       form.controls['natureOfRight']
//                                           ?.updateValue(val.optvalue);
//                                     },
//                                     selItem: () {
//                                       final value =
//                                           form.control('natureOfRight').value;
//                                       return state.lovlist!
//                                           .where(
//                                             (v) => v.Header == 'NatureOfRight',
//                                           )
//                                           .firstWhere(
//                                             (lov) => lov.optvalue == value,
//                                             orElse:
//                                                 () => Lov(
//                                                   Header: 'NatureOfRight',
//                                                   optDesc: '',
//                                                   optvalue: '',
//                                                   optCode: '',
//                                                 ),
//                                           );
//                                     },
//                                   ),
//                                   // Dropdown(
//                                   //   controlName: 'irrigationFacilities',
//                                   //   label: 'Nature of Irrigation facilities',
//                                   //   items: [
//                                   //     '--Select--',
//                                   //     'Canal',
//                                   //     'Well',
//                                   //     'Tube Wells',
//                                   //   ],
//                                   // ),
//                                   SearchableDropdown<Lov>(
//                                     controlName: 'irrigationFacilities',
//                                     label: 'Nature of Irrigation facilities',
//                                     items:
//                                         state.lovlist!
//                                             .where(
//                                               (v) =>
//                                                   v.Header == 'NatureOfIrrFac',
//                                             )
//                                             .toList(),
//                                     onChangeListener: (Lov val) {
//                                       form.controls['irrigationFacilities']
//                                           ?.updateValue(val.optvalue);
//                                     },
//                                     selItem: () {
//                                       final value =
//                                           form
//                                               .control('irrigationFacilities')
//                                               .value;
//                                       return state.lovlist!
//                                           .where(
//                                             (v) => v.Header == 'NatureOfIrrFac',
//                                           )
//                                           .firstWhere(
//                                             (lov) => lov.optvalue == value,
//                                             orElse:
//                                                 () => Lov(
//                                                   Header: 'NatureOfIrrFac',
//                                                   optDesc: '',
//                                                   optvalue: '',
//                                                   optCode: '',
//                                                 ),
//                                           );
//                                     },
//                                   ),
//                                   RadioButton(
//                                     label:
//                                         'Are the Holdings in any way affected by land ceiling enactments',
//                                     controlName: 'affectedByCeiling',
//                                     optionOne: 'Yes',
//                                     optionTwo: 'No',
//                                   ),
//                                   RadioButton(
//                                     label: 'Whether Land Agriculturally Active',
//                                     controlName: 'landAgriActive',
//                                     optionOne: 'Yes',
//                                     optionTwo: 'No',
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 5,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: ElevatedButton.icon(
//                           onPressed: () => handleSubmit(context, state),
//                           icon: const Icon(Icons.save, color: Colors.white),
//                           label: const Text(
//                             'Save',
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color.fromARGB(
//                               212,
//                               5,
//                               8,
//                               205,
//                             ),
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 32,
//                               vertical: 14,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // FAB with badge on top
//                     Positioned(
//                       bottom: 10,
//                       right: 10,
//                       child: Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           FloatingActionButton(
//                             heroTag: 'view_button',
//                             backgroundColor: Colors.white,
//                             tooltip: 'View Saved Data',
//                             onPressed: () => showBottomSheet(context, state),
//                             child: const Icon(
//                               Icons.remove_red_eye,
//                               color: Colors.blue,
//                               size: 28,
//                             ),
//                           ),
//                           if (state.landData != null)
//                             Positioned(
//                               top: -10,
//                               right: -4,
//                               child: Container(
//                                 constraints: const BoxConstraints(
//                                   minWidth: 16,
//                                   minHeight: 16,
//                                 ),
//                                 alignment: Alignment.center,
//                                 padding: const EdgeInsets.all(2),
//                                 decoration: const BoxDecoration(
//                                   color: Colors.red,
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Text(
//                                   '${state.landData?.length ?? 0}',
//                                   style: const TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 10,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
