import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/cif/data/repository/cif_repository.dart';
import 'package:newsee/feature/cif/presentation/bloc/cif_bloc.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:intl/intl.dart';

class CIFSearch extends StatelessWidget {
  final FormGroup cifForm;
  final tabController;
  CIFSearch({super.key, required this.cifForm, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CifBloc(cifRepo: CifRepositoryImpl(), initState: CifState(status: CifStatus.initial)),
      child: BlocListener<CifBloc, CifState>(
        listener: (context, state) => {
          
          if (state.status == CifStatus.success) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                final DateFormat parser = DateFormat("MMM dd, yyyy, hh:mm:ss a");
                DateTime date = parser.parse(state.cifResponseModel?.lpretLeadDetails['lleaddob']);
                
                // Format to desired output
                final DateFormat formatter = DateFormat('dd-MM-yyyy');
                String formattedDate = formatter.format(date);
                return Dialog(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6, 
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      padding: const EdgeInsets.all(16),
                      children: [
                        Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoRow(context, Icons.person, "Name", 
                                [
                                  state.cifResponseModel?.lpretLeadDetails['lleadfrstname'] ?? '',
                                  state.cifResponseModel?.lpretLeadDetails['lleadmidname'] ?? '',
                                  state.cifResponseModel?.lpretLeadDetails['lleadlastname'] ?? '',
                                ].where((val) => val.isNotEmpty).join(' ')
                                  
                                ),
                                _buildInfoRow(context, Icons.date_range, "DOB", formattedDate),
                                _buildInfoRow(context, Icons.call, "Mobile", state.cifResponseModel?.lpretLeadDetails['lleadmobno']),
                                _buildInfoRow(context, Icons.chrome_reader_mode_rounded, "PAN", state.cifResponseModel?.lpretLeadDetails['lleadpanno']),
                                _buildInfoRow(context, Icons.elevator_rounded, "AAdhaar", state.cifResponseModel?.lpretLeadDetails['lleadadharno']),
                                _buildInfoRow(context, Icons.home, "Address", 
                                  [
                                    state.cifResponseModel?.lpretLeadDetails['lleadaddress'] ?? '',
                                    state.cifResponseModel?.lpretLeadDetails['lleadaddresslane1'] ?? '',
                                    state.cifResponseModel?.lpretLeadDetails['lleadaddresslane2'] ?? ''
                                  ].where((val) => val.isNotEmpty).join(' ')
                                ),
                                _buildInfoRow(context, Icons.format_list_numbered_rtl_rounded, "Pinocode", state.cifResponseModel?.lpretLeadDetails['lleadpinno']),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              cifForm.reset();
                              Navigator.pop(context);
                              Navigator.pop(context);
                              if (tabController.index < tabController.length - 1) {
                                tabController.animateTo(tabController.index + 1);
                              }
                            },
                            icon: Icon(Icons.send, color: Colors.white),
                            label: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(text: 'OK')
                                ],
                              ),
                            ),
                            style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(Size(double.infinity, 50),),
                              backgroundColor: MaterialStateProperty.all( const Color.fromARGB(255, 75, 33, 83)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                );
              },
            )
          } else if (state.status == CifStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            )
          }
        },
        child: BlocBuilder<CifBloc, CifState>(
          builder: (context, state) {
            return ReactiveForm(
                formGroup: cifForm,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 0,0,0),
                          child: Text("Cif Search", 
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            IntegerTextField('cifid', 'CIF ID'),
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
                                if (cifForm.valid) {
                                  final Map<String, dynamic> req = {
                                  "cifid": cifForm.control('cifid').value
                                };
                                context.read<CifBloc>().add(SearchCifEvent(request: req));
                                } else {
                                  print("Click function passed go here, ${cifForm.valid}");
                                  cifForm.markAllAsTouched();
                                }
                                
                              }, 
                              child: state.status == CifStatus.loading ? CircularProgressIndicator() : Text("Search")
                            )
                          ],
                        )
                      ]
                    )
                  )
                )
            );
          }
          ),
      )
      
    );
  }
}


Widget _buildInfoRow(BuildContext context, IconData icon, String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Icon(icon, color: Colors.teal),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.2,
          child: Text(
            "$label: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Text(value, style: const TextStyle(fontSize: 13)),
        )
        // Icon(icon, color: Colors.teal),
        // const SizedBox(width: 12),
        // Text(
        //   "$label: ",
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(width: 10),
        // Expanded(
        //   child: Text(value, style: const TextStyle(fontSize: 13)),
        // ),
      ],
    ),
  );
}