import 'package:flywit/services/FlightService.dart';
import 'package:flywit/bloc/BlocBase.dart';
import 'package:flywit/models/BlocModel.dart';
import 'package:flywit/models/ErrorModel.dart';
import 'package:flywit/models/SearchDataModel.dart';
import 'package:rxdart/rxdart.dart';

class SearchFlightBloc implements BlocBase
{
  
  PublishSubject<BlocModel> searchController = PublishSubject();
  Sink<BlocModel> get inBlocModel => searchController.sink;
  Stream<BlocModel> get outBlocModel => searchController.stream;
  FlightService flightService = FlightService();
  SearchDataModel searchDataModel;
  ErrorModel errorModel;
  
  search(Map<String, String> params)
  {
    /// notify listeners about the processing state
    inBlocModel.add(BlocModel(processing: true));
    flightService.searchFlights(params).then((value){
      print(value);
      inBlocModel.add(BlocModel(model: value, processing: false, errorModel: errorModel));
    });
  }

  getAccessToken()
  {
    flightService.getAccessToken();
  }
  
  
  @override
  void dispose() {
    searchController.close();
  }
}