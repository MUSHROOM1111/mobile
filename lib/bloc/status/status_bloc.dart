import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'status_event.dart';
part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  @override
  StatusState get initialState => InitialStatusState();
  @override
  Stream<StatusState> mapEventToState(StatusEvent event) async* {
    if (event is SaveStatus) {
      yield* _mapSaveStatusState(event);
    }
  }

  Stream<StatusState> _mapSaveStatusState(SaveStatus event) async* {
    try {
      var status = event.status;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("order_status", status);
      print("here _mapSaveStatusState");
      yield LoadedStatusState(status);

      // yield SaveCounterState(count);
      // yield state;
      // event.delegate.onSuccess("save successfully");
    } catch (e) {
      // yield ErrorCounterState(e.toString());
    }
  }
}
