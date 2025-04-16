// lib/features/admin/domain/entities/admin_action_entity.dart
import 'package:equatable/equatable.dart';

/// Base entity for admin action results
class AdminActionEntity extends Equatable {
  final int? mwhId;
  final String? message;
  final String? mName;
  final String? mDate;
  final String? mVendor;
  final String? mPrjcode;
  final double? mQty;
  final String? mUnit;
  final String? mDocnum;
  final String? mItemcode;
  final String? cDate;
  final String? code;
  final double? qcQtyIn;
  final double? qcQtyOut;
  final double? zcWarehouseQtyImport;
  final double? zcWarehouseQtyExport;
  final String? qtyState;
  final String? staff;
  final String? qcCheckTime;
  final String? qcScanTime;
  final String? zcWarehouseTimeInt;
  final String? zcWarehouseTimeOut;
  final String? zcOutWarehouseUnit;
  final String? zcUpInQtyTime;
  final String? qcUpInQtyTime;
  final String? zcInQcQtyTime;
  final String? adminAllDataTime;
  final String? codeBonded;

  const AdminActionEntity({
    this.mwhId,
    this.message,
    this.mName,
    this.mDate,
    this.mVendor,
    this.mPrjcode,
    this.mQty,
    this.mUnit,
    this.mDocnum,
    this.mItemcode,
    this.cDate,
    this.code,
    this.qcQtyIn,
    this.qcQtyOut,
    this.zcWarehouseQtyImport,
    this.zcWarehouseQtyExport,
    this.qtyState,
    this.staff,
    this.qcCheckTime,
    this.qcScanTime,
    this.zcWarehouseTimeInt,
    this.zcWarehouseTimeOut,
    this.zcOutWarehouseUnit,
    this.zcUpInQtyTime,
    this.qcUpInQtyTime,
    this.zcInQcQtyTime,
    this.adminAllDataTime,
    this.codeBonded,
  });

  @override
  List<Object?> get props => [
    mwhId,
    message,
    mName,
    mDate,
    mVendor,
    mPrjcode,
    mQty,
    mUnit,
    mDocnum,
    mItemcode,
    cDate,
    code,
    qcQtyIn,
    qcQtyOut,
    zcWarehouseQtyImport,
    zcWarehouseQtyExport,
    qtyState,
    staff,
    qcCheckTime,
    qcScanTime,
    zcWarehouseTimeInt,
    zcWarehouseTimeOut,
    zcOutWarehouseUnit,
    zcUpInQtyTime,
    qcUpInQtyTime,
    zcInQcQtyTime,
    adminAllDataTime,
    codeBonded,
  ];
}
