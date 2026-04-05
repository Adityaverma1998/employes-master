part of 'home_bloc.dart';

class HomeState {
  final bool isLoading;
  final String greeting;
  final int totalEmployees;
  final int currentMonthJoined;
  final double monthlyPayroll;
  final List<Employee> todayBirthdays;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.greeting = '',
    this.totalEmployees = 0,
    this.currentMonthJoined = 0,
    this.monthlyPayroll = 0.0,
    this.todayBirthdays = const [],
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    String? greeting,
    int? totalEmployees,
    int? currentMonthJoined,
    double? monthlyPayroll,
    List<Employee>? todayBirthdays,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      greeting: greeting ?? this.greeting,
      totalEmployees: totalEmployees ?? this.totalEmployees,
      currentMonthJoined: currentMonthJoined ?? this.currentMonthJoined,
      monthlyPayroll: monthlyPayroll ?? this.monthlyPayroll,
      todayBirthdays: todayBirthdays ?? this.todayBirthdays,
      error: error,
    );
  }
}
