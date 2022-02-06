part of 'purchase_details_tab_view_bloc.dart';

@immutable
abstract class PurchaseDetailsTabViewState extends Equatable {
  const PurchaseDetailsTabViewState();

  @override
  List<Object?> get props => [];
}

class LoadingState extends PurchaseDetailsTabViewState {
  const LoadingState();
}

class LoadedState extends PurchaseDetailsTabViewState {
  const LoadedState(this.purchaseDetails, this.filterBy, this.filteredPurchaseDetails);

  const LoadedState.initial() :
    purchaseDetails = const <PurchaseDetail>[],
    filterBy = null,
    filteredPurchaseDetails = const <PurchaseDetail>[];

  LoadedState copyWith({
    bool? isLoading, 
    List<PurchaseDetail>? purchaseDetails,
    OptionalParameter<DealType?>? filterBy,
    List<PurchaseDetail>? filteredPurchaseDetails
  }) {
    return LoadedState(
      purchaseDetails ?? this.purchaseDetails,
      OptionalParameter.resolve(filterBy, this.filterBy),
      filteredPurchaseDetails ?? this.filteredPurchaseDetails
    );
  }

  @override
  List<Object?> get props => [...purchaseDetails, filterBy, ...filteredPurchaseDetails];


  
  final List<PurchaseDetail> purchaseDetails;
  final DealType? filterBy;
  final List<PurchaseDetail> filteredPurchaseDetails;
}

class ErrorState extends PurchaseDetailsTabViewState {
  const ErrorState();
}