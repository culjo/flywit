import 'package:flutter/material.dart';
import 'package:flywit/ui/dialogs/general_dialogs.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: .0,
          title: Text("Flywit"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 2.0,
          tooltip: 'Search',
          child: Icon(Icons.flight),

        ),
        body: Container(
          color: Colors.blueGrey.shade50,
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 460.0,
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  height: 100.0,
//                  color: Colors.red.shade50,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              onTap: (){
                                FlightDialog().destinationDialog(context);
                              },
                              child: Container(
                                child: Row(
                                  children: <Widget>[

                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 13.0, left: 4.0),
                                      child: Icon(
                                        Icons.my_location,
                                        size: 14.0,
                                        color: Colors.red,
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "From",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 12.0,
                                            color: Colors.blueGrey.shade400,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Text(
                                          "Lagos-Murtala Mohamed",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.only(right: 13.0, left: 4.0),
                                    child: Icon(
                                      Icons.location_on,
                                      size: 14.0,
                                      color: Colors.lightBlue,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "To",
                                        style: TextStyle(
//                                          fontWeight: FontWeight.bold,
                                          fontSize: 12.0,
                                          color: Colors.blueGrey.shade400,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Text(
                                        "Lagos-Murtala Mohamed",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.only(right: 10.0),
                          color: Colors.grey.shade50,
                          child: IconButton(
                            icon: Icon(Icons.import_export),
                            color: Colors.black54,
                            onPressed: () {},
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      size: 22.0,
                      color: Colors.black54,
                    ),
                    SizedBox(width: 10.0),
                    Expanded(child: buildFlightDate("Departure")),
//                    Expanded(child: buildFlightDate("Return")),
                  ],
                ),
                Divider(height: 30.0),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.airline_seat_recline_extra,
                        size: 22.0,
                        color: Colors.black54,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Cabin",
                              style: TextStyle(
                                color: Colors.blueGrey.shade400,
                                fontWeight: FontWeight.normal,
                                fontSize: 12.0,
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "ECONOMY",
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        size: 22.0,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      child: Icon(
                        Icons.person,
                        size: 22.0,
                        color: Colors.black54,
                      ),
                    ),
                    buildPassenger("Adult (12+)"),
                    buildPassenger("Children (2-12)"),
                    buildPassenger("Infants (0-2)"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildFlightDate(String title) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
              color: Colors.grey.shade400,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "MAY",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Friday",
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 6.0,
              ),
              Text(
                "24",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPassenger(String title) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: Colors.blueGrey.shade400,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          buildNumberSpinner()
        ],
      ),
    );
  }

  Widget buildNumberSpinner() {
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
                Icons.add,
                size: 18.0,
              ),
            ),
            onTap: () {},
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: .0,
            ),
            child: Text(
              "99",
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
                Icons.remove,
                size: 18.0,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
