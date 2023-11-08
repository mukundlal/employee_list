import 'package:employee_list/app/data/db/employee_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EmployeeDatabase {
  static final EmployeeDatabase instance = EmployeeDatabase._init();
  static Database? _database;


  EmployeeDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('employees.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        role TEXT NOT NULL,
        start_date TEXT NOT NULL,
        end_date TEXT,
        is_employee_active INTEGER NOT NULL
      )
    ''');
  }

  Future<int> create(Employee employee) async {
    final db = await instance.database;
    return await db.insert('employees', employee.toMap());
  }

  Future<Employee?> readEmployee(int id) async {
    final db = await instance.database;
    final maps = await db.query('employees', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Employee.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Employee>> readAllEmployees() async {
    final db = await instance.database;
    const orderBy = 'name';
    final result = await db.query('employees', orderBy: orderBy);
    return result.map((json) => Employee.fromMap(json)).toList();
  }

  Future<int> update(Employee employee) async {
    final db = await instance.database;
    return await db.update(
      'employees',
      employee.toMap(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
