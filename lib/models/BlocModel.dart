
import 'package:flywit/models/ErrorModel.dart';

class BlocModel<T>
{
  /// [T] any object
  T model;

  /// indicates if the stream is in a process state
  bool processing;

  ///[ErrorModel]
  ///
  ErrorModel errorModel;

  BlocModel({this.model, this.processing, this.errorModel});
}