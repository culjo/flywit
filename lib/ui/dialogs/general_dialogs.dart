import 'package:flutter/material.dart';

class GeneralDialog {

}

class FlightDialog {


  Future<Null> destinationDialog(BuildContext context) {

    return showDialog<Null>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context)
              .copyWith(dialogBackgroundColor: Colors.blue.shade50),
          child: new SimpleDialog(

            contentPadding: const EdgeInsets.all(20.0),
            children: <Widget>[
              new Text(
                "Lekan" ?? '',
                textAlign: TextAlign.center,
                style: new TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor),
              ),
              SizedBox(height: 20.0,),

              new Container(
                padding: const EdgeInsets.all(5.0),
                child: new Text(
                  'Cos Wnna',
                  textAlign: TextAlign.center,
                  style: new TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
              ),

              SizedBox(height: 30.0,),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('OK'),
                color: Theme.of(context).primaryColor,
                textColor: Colors.white70,
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6.0)),
              )
            ],
          ),
        );
      },
    );

  }


}