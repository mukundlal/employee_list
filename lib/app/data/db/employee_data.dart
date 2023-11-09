class Employee {
  int? id;
  String name;
  String role;
  String startDate;
  String? endDate;
  bool isEmployeeActive;

  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.startDate,
    this.endDate,
    required this.isEmployeeActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'start_date': startDate,
      'end_date': endDate,
      'is_employee_active': endDate?.isNotEmpty??true
          ? 0
          : isEmployeeActive
              ? 1
              : 0,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> data) {
    return Employee(
      id: data['id'],
      name: data['name'],
      role: data['role'],
      startDate: data['start_date'],
      endDate: data['end_date'],
      isEmployeeActive: data['is_employee_active'] == 1,
    );
  }
}
