part of 'purchase_details_tab_view_bloc.dart';

@immutable
abstract class PurchaseDetailsTabViewEvent extends Equatable {
  const PurchaseDetailsTabViewEvent();


  @override
  List<Object> get props => [];
}

class WidgetLoadedEvent extends PurchaseDetailsTabViewEvent {
  const WidgetLoadedEvent(this.bulkOrBlock);


  final BulkOrBlock bulkOrBlock;
}

class ChangedDealTypeEvent extends PurchaseDetailsTabViewEvent {
  const ChangedDealTypeEvent(this.value);

  final DealType? value;
}

class TextChangedEvent extends PurchaseDetailsTabViewEvent {
  const TextChangedEvent(this.value);


  final String value;
}