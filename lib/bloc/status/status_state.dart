part of 'status_bloc.dart';

@immutable
abstract class StatusState {}

class InitialStatusState extends StatusState {
  @override
  String toString() => "InitialStatusState{}";
}

class LoadingStatusState extends StatusState {
  @override
  String toString() => "LoadingStatusState{}";
}

class LoadedStatusState extends StatusState {
  final String status;

  LoadedStatusState(this.status);
  @override
  String toString() => "LoadedStatusState{status: $status}";
}
