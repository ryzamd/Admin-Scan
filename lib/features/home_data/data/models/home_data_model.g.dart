// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      mwhId: json['mwhId'] != null ? (json['mwhId'] as num).toInt() : 0,
      mName: json['mName'] != null ? json['mName'] as String : '',
      mDate: json['mDate'] != null ? json['mDate'] as String : '',
      mVendor: json['mVendor'] != null ? json['mVendor'] as String : '',
      mPrjcode: json['mPrjcode'] != null ? json['mPrjcode'] as String : '',
      mQty: json['mQty'] != null ? (json['mQty'] as num).toDouble() : 0.0,
      mUnit: json['mUnit'] != null ? json['mUnit'] as String : '',
      mDocnum: json['mDocnum'] != null ? json['mDocnum'] as String : '',
      mItemcode: json['mItemcode'] != null ? json['mItemcode'] as String : '',
      cDate: json['cDate'] != null ? json['cDate'] as String : '',
      code: json['code'] != null ? json['code'] as String : '',
      qcQtyIn: json['qcQtyIn'] != null ? (json['qcQtyIn'] as num).toDouble() : 0.0,
      qcQtyOut: json['qcQtyOut'] != null ? (json['qcQtyOut'] as num).toDouble() : 0.0,
      zcWarehouseQtyImport: json['zcWarehouseQtyImport'] != null ? (json['zcWarehouseQtyImport'] as num).toDouble() : 0.0,
      zcWarehouseQtyExport: json['zcWarehouseQtyExport'] != null ? (json['zcWarehouseQtyExport'] as num).toDouble() : 0.0,
      qtyState: json['qtyState'] != null ? json['qtyState'] as String : '',
      staff: json['staff'] != null ? json['staff'] as String? : '',
      qcCheckTime: json['qcCheckTime'] != null ? json['qcCheckTime'] as String? : '',
      qcScanTime: json['qcScanTime'] != null ? json['qcScanTime'] as String? : '',
      zcWarehouseTimeInt: json['zcWarehouseTimeInt'] != null ? json['zcWarehouseTimeInt'] as String? : '',
      zcWarehouseTimeOut: json['zcWarehouseTimeOut'] != null ? json['zcWarehouseTimeOut'] as String? : '',
      zcOutWarehouseUnit: json['zcOutWarehouseUnit'] != null ? json['zcOutWarehouseUnit'] as String? : '',
      zcUpInQtyTime: json['zcUpInQtyTime'] != null ? json['zcUpInQtyTime'] as String? : '',
      qcUpInQtyTime: json['qcUpInQtyTime'] != null ? json['qcUpInQtyTime'] as String? : '',
      zcInQcQtyTime: json['zcInQcQtyTime'] != null ? json['zcInQcQtyTime'] as String? : '',
      adminAllDataTime: json['adminAllDataTime'] != null ? json['adminAllDataTime'] as String? : '',
      codeBonded: json['codeBonded'] != null ? json['codeBonded'] as String? : '',
    );

Map<String, dynamic> _$HomeDataModelToJson(HomeDataModel instance) =>
    <String, dynamic>{
      'mwhId': instance.mwhId,
      'mName': instance.mName,
      'mDate': instance.mDate,
      'mVendor': instance.mVendor,
      'mPrjcode': instance.mPrjcode,
      'mQty': instance.mQty,
      'mUnit': instance.mUnit,
      'mDocnum': instance.mDocnum,
      'mItemcode': instance.mItemcode,
      'cDate': instance.cDate,
      'code': instance.code,
      'qcQtyIn': instance.qcQtyIn,
      'qcQtyOut': instance.qcQtyOut,
      'zcWarehouseQtyImport': instance.zcWarehouseQtyImport,
      'zcWarehouseQtyExport': instance.zcWarehouseQtyExport,
      'qtyState': instance.qtyState,
      'staff': instance.staff,
      'qcCheckTime': instance.qcCheckTime,
      'qcScanTime': instance.qcScanTime,
      'zcWarehouseTimeInt': instance.zcWarehouseTimeInt,
      'zcWarehouseTimeOut': instance.zcWarehouseTimeOut,
      'zcOutWarehouseUnit': instance.zcOutWarehouseUnit,
      'zcUpInQtyTime': instance.zcUpInQtyTime,
      'qcUpInQtyTime': instance.qcUpInQtyTime,
      'zcInQcQtyTime': instance.zcInQcQtyTime,
      'adminAllDataTime': instance.adminAllDataTime,
      'codeBonded': instance.codeBonded,
    };
