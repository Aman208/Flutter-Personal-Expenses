import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double amount;
  final double perAmountofTotal;

  const ChartBar(this.label, this.amount, this.perAmountofTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx , constraints){
      return Column( 
      children: <Widget>[
        Container(height : constraints.maxHeight*0.15 ,child: FittedBox( child: Text(amount.toStringAsFixed(0)) , fit:BoxFit.cover )),
         SizedBox(
      height: constraints.maxHeight* 0.05,
    ),
       Container(
      height: constraints.maxHeight * 0.6,
      width: 15,
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
              color: Color.fromRGBO(220, 220, 220, 1),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          FractionallySizedBox(
            heightFactor: perAmountofTotal ,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    ),
        SizedBox(
      height: constraints.maxHeight* 0.05,
    ),
     Container( height :constraints.maxHeight* 0.15, child: Text(label)),
      ],
    );
    },);
  }
}
