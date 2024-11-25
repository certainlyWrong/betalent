import 'package:betalent/app/utils/dio_config.dart';
import 'package:result_dart/result_dart.dart';

import '../models/employee_model.dart';
import 'datasource.dart';

class RemoteDataSource implements DataSource {
  @override
  AsyncResult<List<EmployeeModel>, DataSourceError> get employees async {
    try {
      final (response, isCache) =
          await fetchData("http://localhost:5555/employees");

      if (response.statusCode == 200 || isCache) {
        final List<EmployeeModel> employees = [];
        for (var element in response.data) {
          employees.add(EmployeeModel.fromMap(element));
        }
        return employees.toSuccess();
      } else {
        return DataSourceError("Error to get employees").toFailure();
      }
    } catch (e) {
      return DataSourceError("Error to get employees").toFailure();
    }
  }
}
