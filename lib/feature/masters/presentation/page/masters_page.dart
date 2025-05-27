import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppData/app_api_constants.dart';
import 'package:newsee/feature/masters/data/repository/master_repo_impl.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_types.dart';
import 'package:newsee/feature/masters/presentation/bloc/masters_bloc.dart';

class MastersPage extends StatelessWidget {
  const MastersPage({super.key});
  debugMasters(BuildContext context, MastersState state) {
    print('MasterDownload Status => ${state.status}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create:
            (context) => MastersBloc(
              masterRepo: MasterRepoImpl(),
              initState: MastersState(status: MasterdownloadStatus.init),
            ),
        child: BlocListener<MastersBloc, MastersState>(
          listener: (context, state) {
            print("Current master state is: =>  $state");
            switch (state.status) {
              case  MasterdownloadStatus.success:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${state.masterResponse?.masterType} master is fetched successfully')),
                );

                if (state.masterResponse?.masterType == MasterTypes.lov) {
                  context.read<MastersBloc>().add(
                    MasterFetch(
                      request: MasterRequest(
                        setupVersion: '4',
                        setupmodule: 'AGRI',
                        setupTypeOfMaster:
                          ApiConstants.master_key_productschema,
                      ),
                    ),
                  );
                } else if(state.masterResponse?.masterType == MasterTypes.productschema) {
                  context.read<MastersBloc>().add(
                    MasterFetch(
                      request: MasterRequest(
                        setupVersion: '4',
                        setupmodule: 'AGRI',
                        setupTypeOfMaster:
                          ApiConstants.master_key_products,
                      ),
                    ),
                  );
                } else {
                 
                }
                
              case MasterdownloadStatus.loading:
                print('MasterStatus.loading...');


              case MasterdownloadStatus.init:
                print('MasterStatus.init...');

              case MasterdownloadStatus.failue:
                print('MasterStatus.error...');
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.errorMsg ?? 'Login Failed...')),
                );

              case MasterdownloadStatus.refetch:
                print('MasterStatus.refetching...');
            }
          },
          child: BlocBuilder<MastersBloc, MastersState>(
            builder: (context, state) {
              final bool isLoading = state.status == MasterdownloadStatus.loading;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 2, 59, 105),
                        ),
                        foregroundColor: WidgetStatePropertyAll(Colors.white),
                        minimumSize: WidgetStatePropertyAll(Size(230, 40)),
                      ),
                      onPressed:
                          isLoading
                              ? null
                              : () {
                                context.read<MastersBloc>().add(
                                  MasterFetch(
                                    request: MasterRequest(
                                      setupVersion: '4',
                                      setupmodule: 'AGRI',
                                      setupTypeOfMaster:
                                        ApiConstants.master_key_lov,
                                    ),
                                  ),
                                );
                                debugMasters(context, state);
                              },
                      child:
                          isLoading
                              ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0,
                                ),
                              )
                              : const Text("Download Masters"),
                    ),
                  ),
                ],
              );
            },
          ),
        )
      ),
    );
  }
}
