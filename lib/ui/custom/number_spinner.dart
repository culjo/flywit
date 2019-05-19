import 'package:flutter/material.dart';

class NumberSpinner extends StatefulWidget {

  final ValueChanged<num> onValueChanged;
  final num initialValue;
  final num max;
  final num min;

  NumberSpinner( {this.initialValue = 0, this.max = 99, this.min = 0, this.onValueChanged} );

  @override
  State<StatefulWidget> createState() => _NumberSpinnerState();

}


class _NumberSpinnerState extends State<NumberSpinner> {

  num value;

  @override
  void initState() {
    super.initState();
    value  = widget.initialValue;
  }

  void decrement() {
    if (value > widget.min) { this.value--; }
    widget.onValueChanged(value);
    setState(() {});

  }

  void increment() {
    if (value < widget.max) { this.value++; }
    setState(() {
    });
    widget.onValueChanged(value);

  }

  @override
  Widget build(BuildContext context) {


    return Container(
      alignment: Alignment.center,
      width: 74.0,
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(
          3.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.all(
                5.0,
              ),
              child: Icon(
                Icons.remove,
                size: 18.0,
              ),
            ),
            onTap: this.decrement,
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: .0,
            ),
            child: Text(
              this.value.toString(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(
                5.0,
              ),
              child: Icon(
                Icons.add,
                size: 18.0,
              ),
            ),
            onTap: this.increment,
          ),
        ],
      ),
    );
  }

}