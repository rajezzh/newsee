import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_detection/keyboard_detection.dart';
import 'package:newsee/core/api/AsyncResponseHandler.dart';
import 'package:newsee/core/api/failure.dart';
import 'package:newsee/feature/dedupe/data/datasource/dedupe_serach_datasource.dart';
import 'package:newsee/feature/dedupe/data/repository/dedupe_search_repo_impl.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperequest.dart';
import 'package:newsee/feature/dedupe/domain/model/deduperesponse.dart';
import 'package:newsee/feature/dedupe/presentation/page/bloc/dedupe_bloc.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/widgets/custom_text_field.dart';
import 'package:newsee/widgets/drop_down.dart';
import 'package:newsee/widgets/integer_text_field.dart';
import 'package:reactive_forms/reactive_forms.dart';

class DedupeSearch extends StatefulWidget {
  @override
  State<DedupeSearch> createState() => DedupeSearchState();
}

class DedupeSearchState extends State<DedupeSearch> {
  bool keyboardVisible = false;
  final dedupeForm = FormGroup({
    'title': FormControl<String>(validators: [Validators.required]),
    'firstname': FormControl<String>(validators: [Validators.required]),
    'lastname': FormControl<String>(validators: [Validators.required]),
    'mobilenumber': FormControl<String>(validators: []),
    'pan': FormControl<String>(validators: []),
    'aadhaar': FormControl<String>(validators: [Validators.required]),

  });

  @override
  Widget build(BuildContext context) {
    
    print("KeyboardDetectionController is keyboardVisible $keyboardVisible");
    return BlocProvider.value(
      value: DedupeBloc(initState: DedupeState(status: DedupeFetchStatus.init)),
      child: BlocListener<DedupeBloc, DedupeState>(
        listener: (context, state) => {
          if (state.status == DedupeFetchStatus.success) {
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
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: EdgeInsets.all(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Dedupe Result", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
                            Divider(thickness: 1, height: 24),
                        
                            // Row 1
                            Row(
                              children: [
                                _buildKeyValue("CBS", "true"),
                                SizedBox(width: 20),
                                _buildKeyValue("Remarks", state.dedupeResponse?.remarks as String),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                );
              },
            )
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("fsfsfsdfsdfsdfsdfsf")),
            )
          }
        },
        child: BlocBuilder<DedupeBloc, DedupeState>(
          builder: (context, state) {
          return ReactiveForm(
          formGroup: dedupeForm,
          child: 
          // Scaffold(
          //   body:  
            SafeArea(
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
                  IntegerTextField('aadhaar', 'Aadhaar Number'),
                  ElevatedButton(
                    onPressed: () async {
                      if (dedupeForm.valid) {
                        final DedupeRequest request = DedupeRequest(
                          firstname: dedupeForm.control('firstname').value, 
                          lastname: dedupeForm.control('lastname').value, 
                          aadharCard: dedupeForm.control('aadhaar').value,
                          panCard: dedupeForm.control('pan').value,
                          mobileno: dedupeForm.control('mobilenumber').value
                        );
                        context.read<DedupeBloc>().add(FetchDedupeEvent(request: request));
                      } else {
                        dedupeForm.markAllAsTouched();
                      }
                    }, 
                    child: state.status == DedupeFetchStatus.loading ? CircularProgressIndicator(strokeWidth: 2,) : Text("Search")
                  )
                ],
              )
            ) 
          )
          // )
        );
          }
        )
      )
    );
    // KeyboardDetection(
      // controller: KeyboardDetectionController(
      //   onChanged: (value) {
      //     print("KeyboardDetectionController is keyboardVisibleState $value");
      //     if (value == KeyboardState.visible) {
      //       setState(() {
      //          keyboardVisible = true;
      //       });
      //     } else {
      //       setState(() {
      //          keyboardVisible = false;
      //       });
      //     }
      //   }
      // ), 
      // child: 
      // Scaffold(
      //   appBar: keyboardVisible ? null : AppBar(title: Text("Dedupe Search")),
      //   body: 
        
    //   )
    // );
    
  }

}

Widget _buildKeyValue(String key, String val) {
    return SizedBox(
      // width: 140, // fixed width for alignment
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$key: ",
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[800]),
          ),
          Text( val,
            style: TextStyle(color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }