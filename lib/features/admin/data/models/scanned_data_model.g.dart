// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scanned_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScannedDataModel _$ScannedDataModelFromJson(Map<String, dynamic> json) =>
    ScannedDataModel(
      mwhId: json['mwh_id'] != null ? (json['mwh_id'] as num).toInt() : 0,
      mName: json['m_name'] != null ? json['m_name'] as String : '',
      mDate: json['m_date'] != null ? json['m_date'] as String : '',
      mVendor: json['m_vendor'] != null ? json['m_vendor'] as String : '',
      mPrjcode: json['m_prjcode'] != null ? json['m_prjcode'] as String : '',
      mQty: json['m_qty'] != null ? (json['m_qty'] as num).toDouble() : 0.0,
      mUnit: json['m_unit'] != null ? json['m_unit'] as String : '',
      mDocnum: json['m_docnum'] != null ? json['m_docnum'] as String : '',
      mItemcode: json['m_itemcode'] != null ? json['m_itemcode'] as String : '',
      cDate: json['c_date'] != null ? json['c_date'] as String : '',
      code: json['code'] != null ? json['code'] as String : '',
      staff: json['staff'] != null ? json['staff'] as String : '',
      qcCheckTime: json['qc_check_time'] != null ? json['qc_check_time'] as String : '',
      qcScanTime: json['qc_scan_time'] != null ? json['qc_scan_time'] as String : '',
      qcQtyIn: json['qc_qty_in'] != null ? (json['qc_qty_in'] as num).toDouble() : 0.0,
      qcQtyOut: json['qc_qty_out'] != null ? (json['qc_qty_out'] as num).toDouble() : 0.0,
      zcWarehouseQtyInt: json['zc_warehouse_qty_int'] != null ? (json['zc_warehouse_qty_int'] as num).toDouble() : 0.0,
      zcWarehouseQtyOut: json['zc_warehouse_qty_out'] != null ? (json['zc_warehouse_qty_out'] as num).toDouble() : 0.0,
      zcWarehouseTimeInt: json['zc_warehouse_time_int'] != null ? json['zc_warehouse_time_int'] as String : '',
      zcWarehouseTimeOut: json['zc_warehouse_time_out'] != null ? json['zc_warehouse_time_out'] as String : '',
      zcOutWarehouseUnit: json['zc_out_Warehouse_unit'] != null ? json['zc_out_Warehouse_unit'] as String : '',
      zcUpInQtyTime: json['zc_up_in_qty_time'] != null ? json['zc_up_in_qty_time'] as String : '',
      qcUpInQtyTime: json['qc_up_in_qty_time'] != null ? json['qc_up_in_qty_time'] as String : '',
      zcInQcQtyTime: json['zc_in_qc_qty_time'] != null ? json['zc_in_qc_qty_time'] as String : '',
      qtyState: json['qty_state'] != null ? json['qty_state'] as String : '',
      adminAllDataTime: json['admin_all_data_time'] != null ? json['admin_all_data_time'] as String : '',
      codeBonded: json['code_bonded'] != null ? json['code_bonded'] as String : '',
      message: json['message'] != null ? json['message'] as String : '',
    );

Map<String, dynamic> _$ScannedDataModelToJson(ScannedDataModel instance) =>
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
      'staff': instance.staff,
      'qcCheckTime': instance.qcCheckTime,
      'qcScanTime': instance.qcScanTime,
      'qcQtyIn': instance.qcQtyIn,
      'qcQtyOut': instance.qcQtyOut,
      'zcWarehouseQtyInt': instance.zcWarehouseQtyInt,
      'zcWarehouseQtyOut': instance.zcWarehouseQtyOut,
      'zcWarehouseTimeInt': instance.zcWarehouseTimeInt,
      'zcWarehouseTimeOut': instance.zcWarehouseTimeOut,
      'zcOutWarehouseUnit': instance.zcOutWarehouseUnit,
      'zcUpInQtyTime': instance.zcUpInQtyTime,
      'qcUpInQtyTime': instance.qcUpInQtyTime,
      'zcInQcQtyTime': instance.zcInQcQtyTime,
      'qtyState': instance.qtyState,
      'adminAllDataTime': instance.adminAllDataTime,
      'codeBonded': instance.codeBonded,
      'message': instance.message,
    };
