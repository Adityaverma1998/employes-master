import 'package:employes_master/domain/entities/employee.dart';
import 'package:employes_master/domain/usecase/employee/get_employee_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetEmployeesUseCase getEmployees;

  HomeBloc(this.getEmployees) : super(const HomeState()) {
    on<LoadHomeDataEvent>(_onLoad);
  }

  Future<void> _onLoad(LoadHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isLoading: true));

    final result = await getEmployees();

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, error: failure.message));
      },
      (employees) {
        final now = DateTime.now();

        /// Total Employees
        final total = employees.length;

        /// Current Month Joined
        final joinedThisMonth = employees.where((e) {
          final doj = DateTime.parse(e.doj);
          return doj.month == now.month && doj.year == now.year;
        }).length;

        /// Monthly Payroll
        final payroll = employees.fold<double>(0.0, (sum, e) => sum + e.salary);

        /// Today's Birthdays
        final birthdays = employees.where((e) {
          final dob = DateTime.parse(e.dob);
          return dob.day == now.day && dob.month == now.month;
        }).toList();

        /// Greeting
        final greeting = _getGreeting();

        emit(
          state.copyWith(
            isLoading: false,
            greeting: greeting,
            totalEmployees: total,
            currentMonthJoined: joinedThisMonth,
            monthlyPayroll: payroll,
            todayBirthdays: birthdays,
          ),
        );
      },
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning, Admin";
    if (hour < 17) return "Good Afternoon, Admin";
    return "Good Evening, Admin";
  }
}
