import 'package:flutter/material.dart';
class EmptyTransaction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: constraints.maxHeight * 0.7,
                    child:  Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.fill,
                    )),
              ],
            );
          });
}
}