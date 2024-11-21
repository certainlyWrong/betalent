import 'package:result_dart/result_dart.dart';

import '../datasources/datasource.dart';
import '../models/employee_model.dart';

class EmployersService {
  final DataSource _dataSource;

  EmployersService(this._dataSource);

  AsyncResult<List<EmployeeModel>, DataSourceError> get employees =>
      _dataSource.employees;
}
