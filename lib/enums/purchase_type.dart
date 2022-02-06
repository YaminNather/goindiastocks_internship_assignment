import 'package:json_annotation/json_annotation.dart';

enum DealType {
  @JsonValue("BUY") 
  buy, 
  
  @JsonValue("SELL")
  sell
}

String dealTypeToDatabaseForm(final DealType dealType) {
  if(dealType == DealType.buy)
    return "BUY"; 
  else
    return "SELL";    
}

DealType dealTypeFromDatabaseForm(final String dealTypeString) {
  if(dealTypeString == "BUY")
    return DealType.buy;
  else if(dealTypeString == "SELL")
    return DealType.sell;
  else
    throw new Error();
}