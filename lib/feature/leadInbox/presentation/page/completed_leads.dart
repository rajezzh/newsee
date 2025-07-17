/*
  @author     : gayathri.b 12/06/2025
  @desc       : Stateless widget that renders a list of completed leads using BLoC.
                It dispatches a SearchLeadEvent on initialization and listens to state changes.
                Based on the state (loading, success, or failure), it renders:
                - Shimmer loading cards while waiting,    
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsee/AppData/app_constants.dart';
import 'package:newsee/Utils/utils.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:newsee/feature/leadInbox/presentation/bloc/lead_bloc.dart';
import 'package:newsee/widgets/lead_tile_card-shimmer.dart';
import 'package:newsee/widgets/lead_tile_card.dart';

class CompletedLeads extends StatelessWidget {
  final String searchQuery;

  const CompletedLeads({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeadBloc()..add(SearchLeadEvent()),
      child: BlocBuilder<LeadBloc, LeadState>(
        builder: (context, state) {
          Future<void> onRefresh() async {
            context.read<LeadBloc>().add(SearchLeadEvent());
          }

          if (state.status == LeadStatus.loading) {
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

          if (state.status == LeadStatus.failure) {
            return renderWhenNoItems(onRefresh, state);
          }

          final allLeads =
              state.leadResponseModel
                  ?.expand((model) => model.finalList)
                  .toList();

          // logic for search functionaluty , when user type search query
          // in searchbar
          List<Map<String, dynamic>>? filteredLeads = onSearchLeadInbox(
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
    LeadState state,
    List<Map<String, dynamic>> filteredLeads,
    Future<void> Function() onRefresh,
    BuildContext context,
  ) {
    final currentPage = state.currentPage - 1;
    // final startIndex = currentPage * AppConstants.PAGINATION_ITEM_PER_PAGE;
    // final endIndex = ((currentPage + 1) * AppConstants.PAGINATION_ITEM_PER_PAGE)
    //     .clamp(0, filteredLeads.length);
    // // this is the selected index

    // final paginatedLeads = filteredLeads.sublist(startIndex, endIndex);

    //
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: filteredLeads.length,
              itemBuilder: (context, index) {
                final lead = filteredLeads[index];
                return LeadTileCard(
                  title: lead['lleadfrstname'] ?? 'N/A',
                  subtitle: lead['lleadid'] ?? 'N/A',
                  icon: Icons.person,
                  color: Colors.teal,
                  type:
                      lead['lleadexistingcustomer'] == "N"
                          ? 'New Customer'
                          : 'Existing Customer',
                  product: lead['lfProdId'] ?? 'N/A',
                  phone: lead['lleadmobno'] ?? 'N/A',
                  createdon: lead['lpdCreatedOn'] ?? 'N/A',
                  location: lead['lleadprefbrnch'] ?? 'N/A',
                  loanamount: lead['lldLoanamtRequested']?.toString() ?? '',
                  onTap: () {},
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: NumberPaginator(
              numberPages: filteredLeads.length,
              initialPage: currentPage,
              onPageChange: (int index) {
                // check if the
                context.read<LeadBloc>().add(SearchLeadEvent(pageNo: index));
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
    LeadState state,
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
}
