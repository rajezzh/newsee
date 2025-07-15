/*
  @author     : gayathri.b 12/06/2025
  @desc       : Stateless widget that renders a list of completed leads using BLoC.
                It dispatches a SearchLeadEvent on initialization and listens to state changes.
                Based on the state (loading, success, or failure), it renders:
                - Shimmer loading cards while waiting,    
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:newsee/feature/leadInbox/domain/modal/lead_request.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/group_proposal_inbox.dart';
import 'package:newsee/feature/proposal_inbox/presentation/bloc/proposal_inbox_bloc.dart';
import 'package:newsee/widgets/bottom_sheet.dart';
import 'package:newsee/widgets/options_sheet.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:newsee/feature/leadInbox/presentation/bloc/lead_bloc.dart';
import 'package:newsee/widgets/lead_tile_card-shimmer.dart';
import 'package:newsee/widgets/lead_tile_card.dart';

class ProposalInbox extends StatelessWidget {
  final String searchQuery;
  var currentPage = 1;
  ProposalInbox({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProposalInboxBloc()..add(
                SearchProposalInboxEvent(
                  request: LeadInboxRequest(userid: '', token: ''),
                ),
              ),
      child: BlocBuilder<ProposalInboxBloc, ProposalInboxState>(
        builder: (context, state) {
          Future<void> onRefresh() async {
            context.read<ProposalInboxBloc>().add(
                  SearchProposalInboxEvent(
                    request: LeadInboxRequest(userid: '', token: ''),
                  ),
                );
          }

          if (state.status == ProposalInboxStatus.loading) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return LeadTileCardShimmer(
                    icon: Icons.person,
                    color: Colors.teal,
                  );
                },
              ),
            );
          }

          if (state.status == ProposalInboxStatus.failure) {
            return renderWhenNoItems(onRefresh, state);
          }

          // final allLeads =
          //     state.proposalResponseModel
          //         ?.expand((model) => model.proposalDetails)
          //         .toList();

          // // logic for search functionaluty , when user type search query
          // // in searchbar
          // List<Map<String, dynamic>>? filteredLeads = onSearchApplicationInbox(
          //   items: allLeads,
          //   searchQuery: searchQuery,
          // );

          final List<GroupProposalInbox>? allLeads = state.proposalResponseModel;

          // logic for search functionaluty , when user type search query
          // in searchbar
          List<GroupProposalInbox>? filteredLeads = onSearchApplicationInbox(
            items: allLeads,
            searchQuery: searchQuery,
          );
          if (filteredLeads == null || filteredLeads.isEmpty) {
            return renderWhenNoItems(onRefresh, state);
          } else {
            // final totalPages = (filteredLeads.length / itemsPerPage).ceil();
            return renderItems(state, filteredLeads, onRefresh, context);
          }

          // comments
        },
      ),
    );
  }

  RefreshIndicator renderItems(
    ProposalInboxState state,
    List<GroupProposalInbox> filteredLeads,
    Future<void> Function() onRefresh,
    BuildContext context,
  ) {
    final currentPage = state.currentPage;
    print("currentPage: $currentPage");
    final int pageCount = 20;
    final int totalNumberOfApplication = state.totalProposalApplication!.toInt();
    final int numberOfpages = (totalNumberOfApplication / pageCount).ceil();

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredLeads.length,
              itemBuilder: (context, index) {
                final proposal = filteredLeads[index].finalList;
                return LeadTileCard(
                  title:
                      proposal['applicantName']?.toString().isNotEmpty == true
                          ? proposal['applicantName']
                          : 'Name is Empty',
                  subtitle: proposal['propNo'] ?? 'N/A',
                  icon: Icons.person,
                  color: Colors.teal,
                  type: proposal['proposalStatus'] ?? 'N/A',
                  product: proposal['schemeName'] ?? 'N/A',
                  phone: proposal['propRefNo'] ?? 'N/A',
                  createdon: proposal['createdOn'] ?? 'N/A',
                  location: proposal['branchName'] ?? 'N/A',
                  loanamount: proposal['loanAmount']?.toString() ?? '',
                  onTap: () => _showBottomSheet(context, proposal),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: NumberPaginator(
              numberPages: numberOfpages,
              initialPage: currentPage,
              onPageChange: (int index) {
                context.read<ProposalInboxBloc>().add(
                  SearchProposalInboxEvent(
                    request: LeadInboxRequest(
                      userid: '', 
                      token: '',
                      pageNo: index,
                      pageCount: 20
                    ),
                  ),
                );
              },

              child: const SizedBox(
                width: 250,
                height: 35,
                child: Row(
                  children: [
                    PrevButton(),
                    Expanded(child: NumberContent()),
                    NextButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  RefreshIndicator renderWhenNoItems(
    Future<void> Function() onRefresh,
    ProposalInboxState state,
  ) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: [
          const SizedBox(height: 200),
          Center(
            child: Text(
              state.errorMessage ?? AppConstants.GLOBAL_NO_DATA_FOUND,
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> proposal) {
    openBottomSheet(context, 0.6, 0.4, 0.9, (context, scrollController) {
      return SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 12),
            OptionsSheet(
              icon: Icons.visibility,
              title: "Land Details",
              subtitle: "View your Land Details here",
              status: 'Completed',
              onTap: () {
                context.pushNamed(
                  'landholdings',
                  extra: {
                    'applicantName': proposal['applicantName'],
                    'proposalNumber': proposal['propNo'],
                  },
                );
              },
            ),
            OptionsSheet(
              icon: Icons.visibility,
              title: "Crop Details",
              subtitle: "View your Crop Details here",
              status: 'Pending',
              onTap: () {
                context.pushNamed('cropdetails', extra: proposal['propNo']);
              },
            ),
            OptionsSheet(
              icon: Icons.description,
              title: "Document Upload",
              subtitle: "Pre-Sanctioned Documents Upload",
              status: 'Pending',
              onTap: () {
                context.pushNamed('document', extra: proposal['propNo']);
              },
            ),
          ],
        ),
      );
    });
  }
}
