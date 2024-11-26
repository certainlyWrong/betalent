import 'dart:async';
import 'dart:developer';

import 'package:intl/intl.dart';

import '../models/employee_model.dart';
import '../services/employees_service.dart';
import '../services/search_service.dart';

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
  final EmployeesService _employeeService;
  final SearchService _searchService;

  final List<EmployeeModel> employees = [];

  final _stateStream = StreamController<HomeState>.broadcast();

  HomeBloc({
    required EmployeesService employeeService,
    required SearchService searchService,
  })  : _employeeService = employeeService,
        _searchService = searchService {
    _stateStream.add(HomeStateLoading());
  }

  Stream<HomeState> get state => _stateStream.stream;

  dispose() {
    _stateStream.close();
  }

  void fetch() {
    _stateStream.add(HomeStateLoading());
    _employeeService.employees.then((result) {
      result.fold((success) {
        employees.clear();
        _searchService.clear();
        for (var element in success) {
          _searchService.addSearch(
            success.indexOf(element),
            "${element.name} ${element.job} ${element.phone} "
            "${DateFormat('dd/MM/yyyy').format(element.admissionDate)}",
          );
        }

        employees.addAll(success);
        _stateStream.add(HomeStateIdle(success));
      }, (error) {
        _stateStream.add(HomeStateError(error.message));
      });
    });
  }

  Future<void> search(String text) async {
    if (text.isEmpty) {
      log("Empty search", name: "HomeBloc");
      _stateStream.add(HomeStateIdle(employees));
    } else {
      final result = _searchService.search(text);
      final searchResult = result.map((index) => employees[index]).toList();
      _stateStream.add(HomeStateIdle(searchResult));
    }
  }
}
