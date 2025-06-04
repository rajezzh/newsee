import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/feature/dedupe/presentation/page/bloc/dedupe_bloc.dart';
import 'package:newsee/feature/dedupe/presentation/page/cif_search.dart';
import 'package:newsee/feature/dedupe/presentation/page/customertype.dart';
import 'package:newsee/feature/dedupe/presentation/page/dedup_search.dart';

class DedupeView extends StatelessWidget {
  final String title;
  DedupeView(String d, {required this.title, super.key});
  
  openModelSheet(context) {
    final double screenwidth = MediaQuery.of(context).size.width;
    final double screenheight = MediaQuery.of(context).size.height;
    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    sheetAnimationStyle: AnimationStyle(duration: Duration(milliseconds: 500)),
    builder:
      (BuildContext context) => SingleChildScrollView(
        child: Container(
          //It uses a gradient background
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: [
          //       const Color.fromARGB(126, 1, 1, 129),
          //       const Color.fromARGB(64, 1, 1, 129),
          //     ],
          //   ),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          padding: EdgeInsets.all(10),
          width: screenwidth * 1,
          height: screenheight * 0.9,
          child: CustomerType(),
        ),
      ),
    );
  }

  // existingCustomer(context) {
  //   final double screenwidth = MediaQuery.of(context).size.width;
  //   final double screenheight = MediaQuery.of(context).size.height;
  //   showModalBottomSheet(
  //   context: context,
  //   builder:
  //     (BuildContext context) => SingleChildScrollView(
  //       child: Container(
  //         //It uses a gradient background
  //         // decoration: BoxDecoration(
  //         //   gradient: LinearGradient(
  //         //     colors: [
  //         //       const Color.fromARGB(126, 1, 1, 129),
  //         //       const Color.fromARGB(64, 1, 1, 129),
  //         //     ],
  //         //   ),
  //         //   borderRadius: BorderRadius.circular(10),
  //         // ),
  //         padding: EdgeInsets.all(10),
  //         width: screenwidth * 1.0,
  //         height: screenheight * 0.6,
  //         child: CIFSearch(),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dedupe Page")),
      
      body: BlocProvider(
        create: (_) => DedupeBloc(
          initState: DedupeState(
            status: DedupeFetchStatus.init
          )
        ),
        child: Center(
        // child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
          // children: [
            child: ElevatedButton(
              onPressed: () { openModelSheet(context); }, 
              child: Text("Dedupe Search")
            ),
          //   ElevatedButton(
          //     onPressed: () { existingCustomer(context); },
          //     child: Text("Existing Customer")
          //   )
          // ],
        // ),
        // child: CustomerType(),
        )
      )
    ); 
  }
}