import 'dart:async';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flywit/bloc/SearchFlightBloc.dart';
import 'package:flywit/models/BlocModel.dart';
import 'package:flywit/models/ErrorModel.dart';
import 'package:flywit/models/SearchDataModel.dart';

class FlightResultsScreen extends StatefulWidget {
  Map<String, String> searchParams;

  FlightResultsScreen(this.searchParams);

  @override
  State<StatefulWidget> createState() => _FlightResultState();
}

class _FlightResultState extends State<FlightResultsScreen> {

  Color primary, accent;
  ScrollController scrollController = ScrollController();
  SearchFlightBloc searchFlightBloc;
  StreamSubscription searchResultSub;
  ValueNotifier<BlocModel> resultListener =
      ValueNotifier(BlocModel(processing: true));

  NumberFormat numberFormat = NumberFormat('#,##0.00');


  @override
  void initState() {
    searchFlightBloc = SearchFlightBloc();
    searchFlightBloc.search(widget.searchParams);
    super.initState();
    searchResultSub = searchFlightBloc.outBlocModel.listen(onSearchResult);
  }

  onSearchResult(BlocModel model) {
    print("result is back here $model");
    resultListener.value = model;
  }

  @override
  Widget build(BuildContext context) {
    primary = Theme.of(context).primaryColor;
    accent = Theme.of(context).accentColor;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.blueGrey.shade50,
          body: CustomScrollView(
            controller: scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: false,
                snap: true,
                floating: true,
                centerTitle: true,
                title: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Text(
                        widget.searchParams["origin"],
                        style: TextStyle(fontSize: 14.0),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(
                            Icons.flight_takeoff,
                            size: 18.0,
                            color: Colors.white,
                          )),
                      Text(widget.searchParams["destination"],
                          style: TextStyle(fontSize: 14.0)),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                  child: ValueListenableBuilder(
                      valueListenable: resultListener,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                      ),
                      builder: (context, BlocModel result, Widget child) {
                        if (result.processing)
                          return Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ));
                        else if (result.model is ErrorModel) {
                          ErrorModel errorModel = result.model;
                          return Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(
                              child: Text("${errorModel.errors[0].detail}"),
                            ),
                          );
                        } else {
                          SearchDataModel searchDataModel =
                          result.model as SearchDataModel;

                          return ListView.builder(
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: searchDataModel.data.length,
                            itemBuilder: (context, index) {
                              return buildListItem(searchDataModel, index);
                            },
                          );
                        }
                      }))
            ],
          )),
    );
  }

  Widget buildListItem(SearchDataModel model, num index) {
    SearchData data = model.data[index];
    FlightSegment flightSegment = data.offerItems[0].services[0].segments[0].flightSegment;
    DateTime departTime = DateTime.parse(flightSegment.departure.at);
    DateTime arrivalTime = DateTime.parse(flightSegment.arrival.at);
//    String passengers =

    return Card(
      elevation: .0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.0)),
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(
                      right: 20.0,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${DateFormat.Hm().format(departTime)} - ${DateFormat.Hm().format(arrivalTime)}",
                          style: TextStyle(color: primary),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          "${flightSegment.departure.iataCode} - ${flightSegment.arrival.iataCode} ${model.dictionaries['carriers'][flightSegment.carrierCode]}",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        flightSegment.duration,
                        style: TextStyle(
                          color: accent,
                        ),
                      ),
                      Text(
                        "${data.offerItems[0].services[0].segments[0].pricingDetailPerAdult.availability} Left",
                        style: TextStyle(
                          fontSize: 10.0,
                          color: accent,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 1.0,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
//                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 20.0),
                    child: Image.asset("images/paysmallsmall.png", height: 36.0, width: 36.0, fit: BoxFit.contain,),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "Refundable".toUpperCase(),
                        style: TextStyle(
                            fontSize: 10.0, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "\u20A6 ${numberFormat.format(num.parse(data.offerItems[0].price.total))}",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchResultSub.cancel();
    super.dispose();
  }
}
