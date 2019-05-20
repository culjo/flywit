import 'package:flutter/material.dart';
import 'package:flywit/bloc/SearchFlightBloc.dart';
import 'package:flywit/data/SessionManager.dart';
import 'package:flywit/ui/custom/number_spinner.dart';
import 'package:flywit/ui/custom/page_slide_transition.dart';
import 'package:flywit/ui/dialogs/general_dialogs.dart';
import 'package:flywit/ui/flights/flight_results.dart';
import 'package:intl/intl.dart';


enum CabinType {
  Economy,
  PremiumEconomy,
  Business,
  FirstClass
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State {

  SearchFlightBloc searchFlightBloc;

  Map<String, String> params = {
    "origin": "NYC",
    "destination": "MAD",
    "departureDate": "2019-08-01",
    "travelClass": "ECONOMY",
    "adults": "1",
    "currency": "ngn",
    "max": "20"
  };

  String cabin = "";
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    SessionManager.init();
    searchFlightBloc = SearchFlightBloc();
    // Todo: Remove getting token from here
    WidgetsBinding.instance.addPostFrameCallback((context) {
      searchFlightBloc.getAccessToken();
    });

    params["departureDate"] = "${DateTime.now().year}-${appendZero(DateTime.now().month)}-${DateTime.now().day}";
    print(params["departureDate"]);
  }

  void submitSearch() {
    searchFlightBloc.outBlocModel.listen((data) {

    }, onError: (error) {}, );
  }

  @override
  Widget build(BuildContext context) {

    var screenHeight = MediaQuery.of(context).size.height;
    print("Screen Height is: ");
    print(screenHeight);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: .0,
        title: Text("Flywit"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, PageSlideTransition(widget: FlightResultsScreen(params)));
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) { return FlightResultsScreen(); }));
        },
        elevation: 2.0,
        tooltip: 'Search',
        child: Icon(Icons.flight),
      ),
      body: Container(
        color: Colors.blueGrey.shade50,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[

            screenHeight > 560 ? Container(
              margin: EdgeInsets.only(bottom: 50.0,),
              child: Image.asset("images/logo.png", width: 130.0, fit: BoxFit.contain,),
            ) : Container(),

            Container(
              height: screenHeight > 560 ? 460.0 : 450.0,
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
                                onTap: () {
                                  FlightDialog().destinationDialog(context);
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: 13.0, left: 4.0),
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
                                            params["origin"],
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
                              InkWell(
                                onTap: () {
                                  FlightDialog().destinationDialog(context);
                                },
                                child: Container(
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
                                            params["destination"],
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
                              onPressed: () {

                                var origin = params["origin"];
                                params["origin"] = params["destination"];
                                params["destination"] = origin;
                                setState(() {});

                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  InkWell(
                    onTap: () {
                      // FlightDialog().selectedDate(context);

                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019, DateTime.now().month, DateTime.now().day),
                        lastDate: DateTime(2030)
                      ).then((datetime) {
                        //print(datetime);
                        params["departureDate"] = "${datetime.year}-${appendZero(datetime.month)}-${datetime.day}";

                        setState(() {
                          selectedDate = datetime;
                        });
                      });

                    },
                    child: Row(
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
                  ),
                  Divider(height: 30.0),

                  InkWell(
                    onTap: () {
                      FlightDialog().cabinDialog(context).then((cabin) {
                        setState(() {
                          params["travelClass"] = cabin;
                        });
                      });
                    },
                    child: Container(
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
                                  params["travelClass"].toUpperCase(),
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
                      buildPassenger("Adult (12+)", (value){
                        print(value);
                        params["adults"] = value.toString();
                      }, min: 1, initialValue: 1),
                      buildPassenger("Children (2-12)", (value) {
                        print(value);
                      }),
                      buildPassenger("Infants (0-2)", (value) {
                        print(value);
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ],
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
                    DateFormat.MMM().format(selectedDate),
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    DateFormat.EEEE().format(selectedDate),
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
                DateFormat.d().format(selectedDate),
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

  Widget buildPassenger(String title, ValueChanged<num> onChanged, {min = 0, initialValue = 0}) {
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
          SizedBox(height: 5.0),
          NumberSpinner(initialValue: initialValue, min: min, onValueChanged: onChanged,)
        ],
      ),
    );
  }

  String appendZero(num val) {
    return (val < 10) ? "0$val" : val.toString();
  }

}
