import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'department_controller.dart';
import 'employee_controller.dart';

class RouteConfig {
  static final route = Router()
    ..get('/departments', DepartmentController().getALlDepartments,) //get all departments
    ..get('/department/<id>', DepartmentController().getSingleDepartment) //get single department
    ..put('/department', DepartmentController().updateDepartment) //update department
    ..post('/department', DepartmentController().addDepartment) //add department
    ..delete('/department/<id>', DepartmentController().deleteDepartment) //delete department
    ..get('/employees', EmployeeController().getALlEmployees) //get all employee
    ..get('/employee/<id>', EmployeeController().getSingleEmployee) //get single employee
    ..put('/employee', EmployeeController().updateEmployee) //update employee
    ..post('/employee', EmployeeController().addEmployee) //add employee
    ..delete('/employee/<id>', EmployeeController().deleteEmployee) //delete employee
    ..all('/<ignored|.*>', (Request request) => Response(404));
}
