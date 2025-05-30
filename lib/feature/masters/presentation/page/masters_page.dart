import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_api_constants.dart';
import 'package:newsee/feature/masters/data/repository/master_repo_impl.dart';
import 'package:newsee/feature/masters/domain/modal/master_request.dart';
import 'package:newsee/feature/masters/domain/modal/master_response.dart';
import 'package:newsee/feature/masters/domain/modal/master_types.dart';
import 'package:newsee/feature/masters/presentation/bloc/masters_bloc.dart';
import 'package:newsee/pages/master-download.dart';
import 'package:newsee/widgets/download_progress_widget.dart';

class MastersPage extends StatelessWidget {
  const MastersPage({super.key});
  debugMasters(BuildContext context, MastersState state) {
    print(
      '${state.masterResponse?.masterType.name}  MasterDownload Status => ${state.status}',
    );
  }

  navigateto(context) {
    context.pushNamed('home');
  }
                    


  @override
  Widget build(BuildContext context) {
    final double scrwidth = MediaQuery.of(context).size.width;
    final double scrheight = MediaQuery.of(context).size.height;
    double totalMaster = MasterTypes.values.length.toDouble() - 1;
    print("totalMaster-> $totalMaster");
    double progress = 0.0;

    updateDownloadProgress(double completed) {
      progress = completed / totalMaster;
      print("progress-before> $progress");
      progress = double.parse(progress.toStringAsPrecision(3));
      print("progress-After> $progress");
      return progress;
    }

    return Scaffold(
      body: BlocProvider(
        create:
            (context) => MastersBloc(
              masterRepo: MasterRepoImpl(),
              initState: MastersState(
                status: MasterdownloadStatus.init,
                masterResponse: MasterResponse(
                  master: [],
                  masterType: MasterTypes.lov,
                ),
              ),
            )..add(
              MasterFetch(
                request: MasterRequest(
                  setupVersion: '4',
                  setupmodule: 'AGRI',
                  setupTypeOfMaster: ApiConstants.master_key_lov,
                ),
              ),
            ),
        child: BlocListener<MastersBloc, MastersState>(
          listener: (context, state) {
            if (state.status == MasterdownloadStatus.failue) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMsg ?? 'Master Download Failed...'),
                ),
              );
            } else {
              switch (state.masterResponse?.masterType){
                case MasterTypes.lov:
                  break;
                case MasterTypes.products:
                  // lov master completed , fetching products
                  // set completedMasters to 1
                  progress = 0.0;
                  updateDownloadProgress(1);
                  print('progress completed => $progress');
                  context.read<MastersBloc>().add(
                    MasterFetch(
                      request: MasterRequest(
                        setupVersion: '4',
                        setupmodule: 'AGRI',
                        setupTypeOfMaster: ApiConstants.master_key_products,
                      ),
                    ),
                  );

                case MasterTypes.productschema:
                  // products master completed , fetching productschema
                  // set completedMasters to 2
                  updateDownloadProgress(2);
                  print('progress completed => $progress');
                  context.read<MastersBloc>().add(
                    MasterFetch(
                      request: MasterRequest(
                        setupVersion: '4',
                        setupmodule: 'AGRI',
                        setupTypeOfMaster: ApiConstants.master_key_productschema,
                      ),
                    ),
                  );
                case MasterTypes.success: 
                  updateDownloadProgress(3);
                  print('progress completed => $progress');
                  Future.delayed(
                    Duration(milliseconds: 3000),
                    
                    );
                  navigateto(context);
                  
                default:
                  break;
              }
            }
          },
          child: BlocBuilder<MastersBloc, MastersState>(
            builder: (context, state) {
              final bool isLoading =
                  state.status == MasterdownloadStatus.loading;
              final MasterTypes currentMaster =
                  state.masterResponse?.masterType ?? MasterTypes.lov;

              return DownloadProgressWidget(
                downloadProgress: progress,
                scrwidth: scrwidth,
                scrheight: scrheight,
              );
            },
          ),
        ),
      ),
    );
  }
}
