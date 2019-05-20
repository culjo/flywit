import 'package:flutter/material.dart';
import 'package:flywit/ui/dialogs/boss_dialog.dart' as bossDialog;

class GeneralDialog {}

class FlightDialog {
  takeOver(
    BuildContext context,
  ) {
    bossDialog.showBossDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return SimpleDialog();
        });
  }

  Future<String> destinationDialog(BuildContext context) {
    return bossDialog.showBossDialog<String>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Color(0xFFFAFAFA)),
          child: new bossDialog.SimpleDialog(
            contentPadding: const EdgeInsets.symmetric(horizontal: 0.0),
            titlePadding: EdgeInsets.all(10.0),
            title: Container(
              child: TextFormField(
                controller: TextEditingController(text: ""),
                style: TextStyle(
                  fontSize: 13.0,
                ),
                decoration: InputDecoration(
                  hintText: "Select Destination",
                  contentPadding: EdgeInsets.all(
                    18.0,
                  ),
                  prefixIcon: Icon(
                    Icons.flight_takeoff,
                    size: 18.0,
                  ),
                  suffixIcon: Icon(
                    Icons.clear,
                    size: 14.0,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
            children: <Widget>[
              new Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: new Text(
                  'Results...',
                  textAlign: TextAlign.center,
                  style: new TextStyle(
                      fontSize: 12.0, color: Theme.of(context).accentColor),
                ),
              ),
              SizedBox(
                height: 0.0,
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "NYC");
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "New York (NYC)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "New york city(JFK)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "MAD");
                },
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Madrid (MAD)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Text(
                        "Barajas (MAD)",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10.0,
              ),

            ],
          ),
        );
      },
    );
  }

  Future<String> cabinDialog(BuildContext context) {
    return bossDialog.showBossDialog(
        context: context,
        builder: (context) {
          return bossDialog.SimpleDialog(
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Economy");
                },
                child: Container(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: const Text('Economy')),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Premium Economy");
                },
                child: Container(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: const Text('Premium Economy')),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Business");
                },
                child: Container(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: const Text('Business')),
              ),
              Divider(),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "First Class");
                },
                child: Container(
                    padding: EdgeInsets.all(
                      10.0,
                    ),
                    child: const Text('First Class')),
              )
            ],
          );
        });
  }

  /*Widget selectedDate(BuildContext context) {

    return showDialog(context: context, builder: (context) {

      return showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        // DateTime(2018),
        lastDate: DateTime(2030),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
      );

    });

  }*/


}


/*
* Container(
                height: 200.0,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text("Item $index"),
                    );
                  },
                ),
              ),
* */
