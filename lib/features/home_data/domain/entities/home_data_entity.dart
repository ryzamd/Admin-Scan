import 'package:equatable/equatable.dart';

class HomeDataEntity extends Equatable {
  final int mwhId;
  final String mName;
  final String mDate;
  final String mVendor;
  final String mPrjcode;
  final double mQty;
  final String mUnit;
  final String mDocnum;
  final String mItemcode;
  final String cDate;
  final String code;
  final double qcQtyIn;
  final double qcQtyOut;
  final double zcWarehouseQtyImport;
  final double zcWarehouseQtyExport;
  final String qtyState;
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

  const HomeDataEntity({
    required this.mwhId,
    required this.mName,
    required this.mDate,
    required this.mVendor,
    required this.mPrjcode,
    required this.mQty,
    required this.mUnit,
    required this.mDocnum,
    required this.mItemcode,
    required this.cDate,
    required this.code,
    required this.qcQtyIn,
    required this.qcQtyOut,
    required this.zcWarehouseQtyImport,
    required this.zcWarehouseQtyExport,
    required this.qtyState,
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