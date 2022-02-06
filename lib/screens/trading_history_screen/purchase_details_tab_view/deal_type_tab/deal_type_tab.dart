import 'package:flutter/material.dart';
import '../../../../app_colors.dart';
import '../../../../enums/purchase_type.dart';

class DealTypeTab extends StatefulWidget {
  const DealTypeTab({ Key? key, required this.value, this.onChange }) : super(key: key);

  @override
  _DealTypeTabState createState() => _DealTypeTabState();


  final DealType? value;
  final void Function(DealType? value)? onChange;
}

class _DealTypeTabState extends State<DealTypeTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: _buildButton(null, 'All', const Color(0xFF9AABDD))
        ),
        
        const SizedBox(width: 8.0),

        Expanded(
          child: _buildButton(DealType.buy, 'Buy', AppColors.buy)
        ),
        
        const SizedBox(width: 8.0),
        
        Expanded(
          child: _buildButton(DealType.sell, 'Sell', AppColors.sell)
        )
      ]
    );
  }

  Widget _buildButton(DealType? value, String label, Color color) {
    final bool isSelected = value == widget.value;

    final MaterialStateProperty<OutlinedBorder>? shape;
    if(isSelected) {
      final RoundedRectangleBorder border = RoundedRectangleBorder(
        side: const BorderSide(width: 3.0), 
        borderRadius: BorderRadius.circular(16.0)
      );
      shape = MaterialStateProperty.all<OutlinedBorder>(border);
    }
    else
      shape = null;
    
    final ButtonStyle style = new ButtonStyle( 
      backgroundColor: MaterialStateProperty.all<Color>(color),
      shape: shape
    );

    return ElevatedButton(
      child: Text(label, textScaleFactor: 1.5, style: TextStyle(color: (isSelected) ? Colors.black : null )),
      onPressed: () => widget.onChange?.call(value),
      style: style
    );
  }  
}