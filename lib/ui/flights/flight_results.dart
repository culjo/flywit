import 'package:flutter/material.dart';

class FlightResultsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }
}

class _FlightResultState extends State<FlightResultsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return buildListItem();
          },
        ),
      ),
    );
  }

  Widget buildListItem() {
    return Card(
      child: ,
    );
  }


}
