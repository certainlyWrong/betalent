import 'dart:async';

import '../models/employee_model.dart';
import '../services/employers_service.dart';

/// States
sealed class HomeState {}

final class HomeStateLoading extends HomeState {}

final class HomeStateError extends HomeState {
  final String message;

  HomeStateError(this.message);
}

final class HomeStateIdle extends HomeState {
  final List<EmployeeModel> employees;

  HomeStateIdle(this.employees);
}

class HomeBloc {
  final _state = StreamController<HomeState>();

  final EmployersService _service;

  HomeBloc(
    this._service,
  );

  Stream<HomeState> get state => _state.stream.asBroadcastStream();

  dispose() {
    _state.close();
  }

  fetch() {
    _state.add(HomeStateLoading());

    _service.employees.then((result) {
      result.fold((success) {
        _state.add(HomeStateIdle(success));
      }, (error) {
        _state.add(HomeStateError(error.message));
      });
    });
  }
}
