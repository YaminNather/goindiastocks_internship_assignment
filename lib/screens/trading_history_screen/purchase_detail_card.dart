import 'package:flutter/material.dart';
import 'package:goindiastocks_internship_assignment/app_colors.dart';
import 'package:goindiastocks_internship_assignment/models/purchase_detail.dart';
import 'package:intl/intl.dart';
import 'package:money2/money2.dart';
import '../../enums/purchase_type.dart';

class PurchaseDetailCard extends StatefulWidget {
  const PurchaseDetailCard({ Key? key, required this.purchaseDetail }) : super(key: key);

  @override
  _PurchaseDetailCardState createState() => _PurchaseDetailCardState();

  final PurchaseDetail purchaseDetail;
}

class _PurchaseDetailCardState extends State<PurchaseDetailCard> {
  @override
  Widget build(BuildContext context) {
    final Color purchaseTypeIndicatorColor;    
    if(widget.purchaseDetail.dealType == DealType.buy)
      purchaseTypeIndicatorColor = AppColors.buy;
    else
      purchaseTypeIndicatorColor = AppColors.sell;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 32.0, 16.0),
        child: Row(
          children: <Widget>[
            _buildVerticalLine(purchaseTypeIndicatorColor),

            const SizedBox(width: 8.0),

            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.purchaseDetail.clientName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis
                          )
                        ),

                        const SizedBox(width: 8.0),

                        _buildDate()
                      ]
                    )
                  ),

                  const SizedBox(height: 16.0),
                  
                  _buildCenterRow(purchaseTypeIndicatorColor),
                  
                  const SizedBox(height: 16.0),

                  Text(
                    'Value ${_currencyFormatter.format(widget.purchaseDetail.value).toString()}', 
                    style: TextStyle(color: Colors.blue.shade900, fontWeight: FontWeight.bold)
                  )
                ]
              ),
            )
          ]
        ),
      )
    );
  }

  Widget _buildVerticalLine(Color color) {
    return SizedBox(
      width: 4.0, height: 104.0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color, 
          borderRadius: BorderRadius.circular(8.0)
        )
      )
    );
  }

  Widget _buildDate() {
    final ThemeData theme = Theme.of(context);

    return Text(
      DateFormat('d MMM y').format(widget.purchaseDetail.dealDate),
      style: TextStyle(color: theme.textTheme.bodyText2!.color!.withOpacity(0.7))
    );
  }

  Widget _buildCenterRow(Color color) {
    final String dealType = (widget.purchaseDetail.dealType == DealType.buy) ? 'Bought' : 'Sold';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$dealType ${_numberFormatter.format(widget.purchaseDetail.quantity)} shares',
          style: TextStyle(color: color, fontWeight: FontWeight.bold)
        ),
        
        Text(
          ' @ ${_currencyFormatter.format(widget.purchaseDetail.tradePrice)}', 
          style: const TextStyle(fontWeight: FontWeight.bold)
        ),
      ]
    );
  }


  static final NumberFormat _numberFormatter = new NumberFormat(null, 'en_IN');
  static final NumberFormat _currencyFormatter = new NumberFormat.compactCurrency(locale: 'en_IN', name: 'Rs ', decimalDigits: 0);
}