
import 'package:employes_master/data/data_source/local/models/employee_entity.dart';
import 'package:employes_master/domain/entities/employee.dart';

// ─── Entity → Domain ──────────────────────────────────────────────────────────
extension EmployeeMapper on EmployeeEntity {
  Employee toDomain() {
    return Employee(
      empCode:    empCode,
      empName:    empName,
      mobile:     mobile,
      dob:        dob,
      doj:        doj,
      salary:     salary,
      address:    address,
      remark:     remark,
      // 🔥 sync fields mapped to domain-friendly types
      firebaseId: firebaseId,
      isSynced:   isSynced == 1,
      isDeleted:  isDeleted == 1,
      updatedAt:  DateTime.fromMillisecondsSinceEpoch(updatedAt),
    );
  }

  // ─── Entity → Firebase payload ─────────────────────────────────────────────
  // Intentionally excludes empCode (local PK) and isSynced (local concern)
  // firebaseId is NOT sent as a field — it IS the document ID in Firestore
  Map<String, dynamic> toFirebaseMap() => {
    'empName':   empName,
    'mobile':    mobile,
    'dob':       dob,
    'doj':       doj,
    'salary':    salary,
    'address':   address,
    'remark':    remark,
    'isDeleted': isDeleted,   // int 0/1 — Firebase needs to know for pull sync
    'updatedAt': updatedAt,   // used for conflict resolution (last-write-wins)
  };
}

// ─── Domain → Entity ──────────────────────────────────────────────────────────
extension EmployeeToEntity on Employee {
  EmployeeEntity toEntity() {
    return EmployeeEntity(
      empCode:    empCode,
      empName:    empName,
      mobile:     mobile,
      dob:        dob,
      doj:        doj,
      salary:     salary,
      address:    address,
      remark:     remark,
      // 🔥 sync fields — convert back from domain types to SQLite types
      firebaseId: firebaseId,
      isSynced:   isSynced ? 1 : 0,
      isDeleted:  isDeleted ? 1 : 0,
      updatedAt:  updatedAt.millisecondsSinceEpoch,
    );
  }
}