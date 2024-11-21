import 'package:result_dart/result_dart.dart';

import '../models/employee_model.dart';

class DataSourceError extends Error {
  final String message;

  DataSourceError(this.message);
}

abstract interface class DataSource {
  AsyncResult<List<EmployeeModel>, DataSourceError> get employees;
}
