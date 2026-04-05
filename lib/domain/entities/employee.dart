class Employee {
  final int? empCode;
  final String empName;
  final String mobile;
  final String dob;
  final String doj;
  final double salary;
  final String? address;
  final String? remark;

  Employee({
    this.empCode,
    required this.empName,
    required this.mobile,
    required this.dob,
    required this.doj,
    required this.salary,
    this.address,
    this.remark,
  });

  Employee copyWith({
    int? empCode,
    String? empName,
    String? mobile,
    String? dob,
    String? doj,
    double? salary,
    String? address,
    String? remark,
  }) {
    return Employee(
      empCode: empCode ?? this.empCode,
      empName: empName ?? this.empName,
      mobile: mobile ?? this.mobile,
      dob: dob ?? this.dob,
      doj: doj ?? this.doj,
      salary: salary ?? this.salary,
      address: address ?? this.address,
      remark: remark ?? this.remark,
    );
  }
}
