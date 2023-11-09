import 'package:employee_list/app/data/db/employee_data.dart';
import 'package:employee_list/app/data/db/employee_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EmployeeListCubit extends Cubit<ListDataState> {
  final EmployeeDatabase db = EmployeeDatabase.instance;
  EmployeeListCubit() : super(IsLoadingState());

  getEmployeeList() async {
    emit(IsLoadingState());
    try {
      List<Employee> activeList = await db.readAllActiveEmployees();
      List<Employee> inActiveList = await db.readAllNonActiveEmployees();
      if (activeList.isEmpty && inActiveList.isEmpty) {
        emit(IsEmptyState());
      } else {
        emit(HasDataState(inActiveList: inActiveList, activeList: activeList));
      }
    } on Exception {
      emit(HasErrorState());
    }
  }
}

class ListDataState {}

class HasDataState extends ListDataState {
  final List<Employee> activeList;
  final List<Employee> inActiveList;

  HasDataState({required this.activeList, required this.inActiveList});
}

class HasErrorState extends ListDataState {}

class IsLoadingState extends ListDataState {}

class IsEmptyState extends ListDataState {}
