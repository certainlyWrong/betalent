import 'package:result_dart/result_dart.dart';

import '../datasources/datasource.dart';
import '../models/employee_model.dart';

class EmployeesService {
  final DataSource _dataSource;

  EmployeesService(this._dataSource);

  AsyncResult<List<EmployeeModel>, DataSourceError> get employees =>
      _dataSource.employees;
}
