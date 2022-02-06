import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goindiastocks_internship_assignment/models/purchase_detail.dart';
import 'package:goindiastocks_internship_assignment/screens/trading_history_screen/purchase_details_tab_view/bloc/purchase_details_tab_view_bloc.dart';
import 'package:goindiastocks_internship_assignment/screens/trading_history_screen/purchase_details_tab_view/deal_type_tab/deal_type_tab.dart';

import '../../../enums/bulk_or_block.dart';
import '../../../enums/purchase_type.dart';
import '../purchase_detail_card.dart';

class PurchaseDetailsTabView extends StatefulWidget {
  const PurchaseDetailsTabView({ Key? key, required this.type }) : super(key: key);

  @override
  _PurchaseDetailsTabViewState createState() => _PurchaseDetailsTabViewState();


  final BulkOrBlock type;
}

class _PurchaseDetailsTabViewState extends State<PurchaseDetailsTabView> {
  @override
  void initState() {
    super.initState();

    _controller = new PurchaseDetailsTabViewBloc();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider<PurchaseDetailsTabViewBloc>(
      create: (context) => _controller..add(new WidgetLoadedEvent(widget.type)),
      child: BlocBuilder<PurchaseDetailsTabViewBloc, PurchaseDetailsTabViewState>(
        buildWhen: (previous, current) => previous.runtimeType != current.runtimeType,
        builder: (context, state) {
          if(state is LoadingState)
            return _buildLoadingIndicator();

          if(state is ErrorState)
            return _buildErrorMessage();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 48.0,
                  child: _buildDealTypeFilter()
                ),
      
                const SizedBox(height: 16.0),
      
                TextField(
                  controller: _controller.clientNameController, 
                  decoration: const InputDecoration(hintText: 'Search Client Name')
                ),
      
                const SizedBox(height: 16.0),
      
                const Divider(color: Colors.white, thickness: 4.0),
                
                const SizedBox(height: 16.0),
      
                _buildPurchaseDetailCards()
              ]
            )
          );
        }
      )
    );
  }

  Widget _buildErrorMessage() {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Text('Error loading details', style: new TextStyle(color: theme.errorColor))
    );
  }

  Widget _buildDealTypeFilter() {
    bool buildWhen(PurchaseDetailsTabViewState previous, PurchaseDetailsTabViewState current) {
      if(previous is LoadedState && current is LoadedState)
          return previous.filterBy != current.filterBy;
        else
          throw new Error(); 
    }

    return BlocBuilder<PurchaseDetailsTabViewBloc, PurchaseDetailsTabViewState>(
      buildWhen: buildWhen,
      builder: (context, state) {
        final LoadedState loadedState = state as LoadedState;

        return DealTypeTab(
          value: loadedState.filterBy,
          onChange: (value) => _controller.add(new ChangedDealTypeEvent(value))
        );
      }
    );
  }

  Widget _buildLoadingIndicator() {
    return const Center( child: CircularProgressIndicator.adaptive() );
  }

  Widget _buildPurchaseDetailCards() {
    return BlocBuilder<PurchaseDetailsTabViewBloc, PurchaseDetailsTabViewState>(
      builder: (context, state) {
        final LoadedState loadedState = state as LoadedState;      

        List<PurchaseDetail> purchaseDetails = loadedState.filteredPurchaseDetails;

        return Expanded(
          child: ListView.builder(
            itemCount: purchaseDetails.length,
            itemBuilder: (context, index) => PurchaseDetailCard(purchaseDetail: purchaseDetails[index])
          )
        );
      },
    );
  }



  late final PurchaseDetailsTabViewBloc _controller;
}