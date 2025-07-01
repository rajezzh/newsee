import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:newsee/feature/proposal_inbox/domain/modal/proposal_inbox_request.dart';
import 'package:newsee/feature/proposal_inbox/presentation/bloc/proposal_inbox_bloc.dart';
import 'package:newsee/widgets/bottom_sheet.dart';
import 'package:newsee/widgets/lead_tile_card-shimmer.dart';
import 'package:newsee/widgets/options_sheet.dart';
import '../../../../widgets/lead_tile_card.dart';

class PendingLeads extends StatelessWidget {
  final String searchQuery;
  PendingLeads({super.key, required this.searchQuery});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              ProposalInboxBloc()..add(
                SearchProposalInboxEvent(
                  request: ProposalInboxRequest(userid: "AGRI1124"),
                ),
              ),

      child: BlocBuilder<ProposalInboxBloc, ProposalInboxState>(
        builder: (context, state) {
          Future<void> onRefresh() async {
            context.read<ProposalInboxBloc>().add(
              SearchProposalInboxEvent(
                request: ProposalInboxRequest(userid: "AGRI1124"),
              ),
            );
          }

          if (state.status == ProposalInboxStatus.loading) {
            // return const Center(child: ShimmerLoader(cardHeight: 120,itemCount: 5));
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return LeadTileCardShimmer(
                    title: 'dfsdfsfdsfsd',
                    subtitle: 'dfsdfsfdsfsd',
                    icon: Icons.person,
                    color: Colors.teal,
                    type: 'dfsdfsfdsfsd',
                    product: 'dfsdfsfdsfsd',
                    phone: 'dfsdfsfdsfsd',
                    createdon: 'dfsdfsfdsfsd',
                    location: 'dfsdfsfdsfsd',
                    loanamount: 'dfsdfsfdsfsd',
                  );
                },
              ),
            );
          }
          if (state.status == ProposalInboxStatus.failure) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                children: [
                  SizedBox(height: 200),
                  Center(
                    child: Text(
                      " ${state.errorMessage ?? 'Something went wrong'}",
                    ),
                  ),
                ],
              ),
            );
          }
          final allProposalInboxLeads =
              state.proposalResponseModel
                  ?.expand((model) => model.proposalDetails)
                  .toList();

          final filterProposalInboxLeads =
              allProposalInboxLeads?.where((proposal) {
                final name = (proposal['applicantName'] ?? '').toLowerCase();
                final id = (proposal['propNo'] ?? '').toLowerCase();
                final branchCode = (proposal['branchCode'] ?? '').toLowerCase();
                final loan = (proposal['loanAmount'] ?? '').toString();
                return name.contains(searchQuery.toLowerCase()) ||
                    id.contains(searchQuery.toLowerCase()) ||
                    branchCode.contains(searchQuery.toLowerCase()) ||
                    loan.contains(searchQuery.toString());
              }).toList();

          if (filterProposalInboxLeads == null ||
              filterProposalInboxLeads.isEmpty) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text("No leads found.")),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.builder(
              itemCount: filterProposalInboxLeads.length,
              itemBuilder: (context, index) {
                final proposal = filterProposalInboxLeads[index];
                return LeadTileCard(
                  title:
                      proposal['applicantName'].toString().isNotEmpty
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
                  onTap: () {
                    openBottomSheet(
                      context, 0.6, 0.4, 0.9, (
                        context,
                        scrollController,
                      ) {
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
                                  context.pushNamed('landholdings', extra: proposal['propNo']);
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
                                  context.pushNamed('document');
                                },
                              ),
                            ],
                          ),
                        );
                      }
                    );
                  },
                );
              },
            )
          );
        }
      ),
    );
  }
}
