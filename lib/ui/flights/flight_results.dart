import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flywit/bloc/SearchFlightBloc.dart';
import 'package:flywit/models/BlocModel.dart';
import 'package:flywit/models/ErrorModel.dart';

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
  ValueNotifier<BlocModel> resultListener = ValueNotifier(BlocModel(processing: true));

  @override
  void initState() {
    searchFlightBloc = SearchFlightBloc();
    searchFlightBloc.search(widget.searchParams);
    super.initState();
    searchResultSub = searchFlightBloc.outBlocModel.listen(onSearchResult);
  }

  onSearchResult(BlocModel model)
  {
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
              title: Text("Flight result"),

            ),

            SliverToBoxAdapter(
              child: ValueListenableBuilder(
                valueListenable: resultListener,
                child: CircularProgressIndicator(),
                builder: (context, BlocModel result, Widget child){
                  if(result.processing)
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: CircularProgressIndicator(),));
                  else if(result.model is ErrorModel) {
                    ErrorModel errorModel = result.model;
                    return Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text(
                          "${errorModel.errors[0].detail}"),
                      ),
                    );
                  } else
                    return ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return buildListItem();
                      },
                    );

                }
              )
            )
          ],
        )
      ),
    );
  }

  Widget buildListItem() {
    return Card(
      elevation: .0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
        2.0,
      )),
      margin: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(
                20.0
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 20.0,),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("14:20 - 04:00", style: TextStyle(color: primary),),
                        SizedBox(height: 4.0),
                        Text("LOS - DXB Egyptair", style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold, color: Colors.grey),),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text("10h 40m", style: TextStyle(color: accent,),),
                      Text("1 stop", style: TextStyle(fontSize: 10.0, color: accent, ),),
                    ],
                  )
                ],
              ),
            ),
            Divider(height: 1.0,),
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 12.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    color: Colors.grey,
                    margin: EdgeInsets.only(right: 20.0),
                  ),
                  Column(
                    children: <Widget>[Text("Refundable".toUpperCase(), style: TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),),],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text("\u20A6 1,390,831", style: TextStyle(fontSize: 20.0, color: Colors.black54, fontWeight: FontWeight.bold,),),
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
