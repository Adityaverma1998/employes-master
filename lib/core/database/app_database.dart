import 'dart:async';

import 'package:employes_master/data/data_source/local/dao/employee_dao.dart';
import 'package:employes_master/data/data_source/local/models/employee_entity.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [EmployeeEntity])
abstract class AppDatabase extends FloorDatabase {
  EmployeeDao get employeeDao;
}
