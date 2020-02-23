part of 'status_bloc.dart';

@immutable
abstract class StatusEvent {}

abstract class SaveStatusDelegate {
  void onSuccess(String message);
  void onError(String message);
}

class SaveStatus extends StatusEvent {
  final String status;

  SaveStatus(this.status);
  @override
  String toString() => "SaveStatus{status: $status}";
}
