import 'dart:convert';
import 'dart:io';

import '../models/purchase_details.dart';
import 'package:http/http.dart' as http;


class BulkBlockDetailsRepository {
  Future<List<PurchaseDetail>> getBulkDetails() => _getPurchaseDetails('Bulk_Deal');

  Future getBlockDetails() => _getPurchaseDetails('Block_Deal');

  Future<List<PurchaseDetail>> _getPurchaseDetails(final String dealType) async {
    final Map<String, dynamic> newQueryParameters = <String, dynamic>{
      ..._uri.queryParameters,
      'DealType': dealType
    };
    final Uri finalUri = _uri.replace(queryParameters: newQueryParameters);    

    final http.Response response = await http.get(finalUri);

    if(response.statusCode < 200 && response.statusCode >299)
      throw new HttpException(response.body, uri: finalUri);
    
    final List<dynamic> jsonData = jsonDecode(response.body)['Data'];
    final List<PurchaseDetail> r = jsonData.map<PurchaseDetail>(
      (element) => PurchaseDetail.fromJson(element)
    ).toList();

    return r;
  }



  static final Uri _uri = Uri.parse('https://www.goindiastocks.com/api/service/GetBulkBlockDeal?fincode=100114');
}