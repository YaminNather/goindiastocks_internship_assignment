import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:goindiastocks_internship_assignment/models/purchase_detail.dart';
import 'package:goindiastocks_internship_assignment/repositories/bulk_block_details_repository.dart';
import 'package:goindiastocks_internship_assignment/utils/optional_parameter.dart';
import 'package:flutter/material.dart';

import '../../../../enums/bulk_or_block.dart';
import '../../../../enums/purchase_type.dart';

part 'purchase_details_tab_view_event.dart';
part 'purchase_details_tab_view_state.dart';

class PurchaseDetailsTabViewBloc extends Bloc<PurchaseDetailsTabViewEvent, PurchaseDetailsTabViewState> {
  PurchaseDetailsTabViewBloc() : super(const LoadingState()) {
    on<WidgetLoadedEvent>(_onWidgetLoadedEvent);
    on<ChangedDealTypeEvent>(_onChangedDealTypeEvent);
    on<TextChangedEvent>(_onTextChangedEvent);
  }

  Future<void> _onWidgetLoadedEvent(WidgetLoadedEvent event, Emitter<PurchaseDetailsTabViewState> emit) async {
    final List<PurchaseDetail> purchaseDetails;

    try {
      if(event.bulkOrBlock == BulkOrBlock.bulk)
        purchaseDetails = await _bulkBlockDetailsRepository.getBulkDetails();
      else
        purchaseDetails = await _bulkBlockDetailsRepository.getBlockDetails();
    }
    catch(e) {
      print(e);
      emit(const ErrorState());
      return;
    }

    emit(new LoadedState(purchaseDetails, null, purchaseDetails));

    clientNameController.addListener( () => add(TextChangedEvent(clientNameController.text)) );
  }

  Future<void> _onChangedDealTypeEvent(ChangedDealTypeEvent event, Emitter<PurchaseDetailsTabViewState> emit) async {
    final LoadedState loadedState = state as LoadedState;

    final List<PurchaseDetail> filteredPurchaseDetails = _filterPurchaseDetails(
      loadedState.purchaseDetails,
      event.value,
      clientNameController.text
    );


    LoadedState newState = loadedState.copyWith(
      filterBy: new OptionalParameter<DealType?>(event.value), 
      filteredPurchaseDetails: filteredPurchaseDetails
    );
    emit(newState);
  }

  Future<void> _onTextChangedEvent(TextChangedEvent event, Emitter<PurchaseDetailsTabViewState> emit) async {
    final LoadedState loadedState = state as LoadedState;
    
    List<PurchaseDetail> filteredPurchaseDetails = _filterPurchaseDetails(
      loadedState.purchaseDetails, 
      loadedState.filterBy, 
      event.value
    );

    emit(loadedState.copyWith(filteredPurchaseDetails: filteredPurchaseDetails));
  }

  List<PurchaseDetail>  _filterPurchaseDetails(
    List<PurchaseDetail> purchaseDetails, 
    DealType? dealType, 
    String searchTerm
  ) {
    List<PurchaseDetail> r = _filterPurchaseDetailsByDealType(purchaseDetails, dealType);
    
    if(searchTerm.isNotEmpty)
      r = _filterPurchaseDetailsByName(r, searchTerm);

    return r;
  }

  List<PurchaseDetail> _filterPurchaseDetailsByDealType(List<PurchaseDetail> purchaseDetails, DealType? dealType) {
    if(dealType == null)
      return purchaseDetails;

    List<PurchaseDetail> r = <PurchaseDetail>[];
    for(final PurchaseDetail purchaseDetail in purchaseDetails) {
      if(purchaseDetail.dealType == dealType)
        r.add(purchaseDetail);
    }

    return r;
  }  

  List<PurchaseDetail> _filterPurchaseDetailsByName(List<PurchaseDetail> purchaseDetails, String searchTerm) {
    final List<PurchaseDetail> r = <PurchaseDetail>[];

    for(final PurchaseDetail purchaseDetail in purchaseDetails) {
      if(purchaseDetail.clientName.toLowerCase().contains(searchTerm.toLowerCase()))
        r.add(purchaseDetail);
    }

    return r;
  }




  final TextEditingController clientNameController = new TextEditingController();

  final BulkBlockDetailsRepository _bulkBlockDetailsRepository = new BulkBlockDetailsRepository();
}
