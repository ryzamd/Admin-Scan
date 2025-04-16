// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      mwhId: (json['mwhId'] as num).toInt(),
      mName: json['mName'] as String,
      mDate: json['mDate'] as String,
      mVendor: json['mVendor'] as String,
      mPrjcode: json['mPrjcode'] as String,
      mQty: (json['mQty'] as num).toDouble(),
      mUnit: json['mUnit'] as String,
      mDocnum: json['mDocnum'] as String,
      mItemcode: json['mItemcode'] as String,
      cDate: json['cDate'] as String,
      code: json['code'] as String,
      qcQtyIn: (json['qcQtyIn'] as num).toDouble(),
      qcQtyOut: (json['qcQtyOut'] as num).toDouble(),
      zcWarehouseQtyImport: (json['zcWarehouseQtyImport'] as num).toDouble(),
      zcWarehouseQtyExport: (json['zcWarehouseQtyExport'] as num).toDouble(),
      qtyState: json['qtyState'] as String,
      staff: json['staff'] as String?,
      qcCheckTime: json['qcCheckTime'] as String?,
      qcScanTime: json['qcScanTime'] as String?,
      zcWarehouseTimeInt: json['zcWarehouseTimeInt'] as String?,
      zcWarehouseTimeOut: json['zcWarehouseTimeOut'] as String?,
      zcOutWarehouseUnit: json['zcOutWarehouseUnit'] as String?,
      zcUpInQtyTime: json['zcUpInQtyTime'] as String?,
      qcUpInQtyTime: json['qcUpInQtyTime'] as String?,
      zcInQcQtyTime: json['zcInQcQtyTime'] as String?,
      adminAllDataTime: json['adminAllDataTime'] as String?,
      codeBonded: json['codeBonded'] as String?,
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
