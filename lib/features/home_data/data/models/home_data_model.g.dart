// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeDataModel _$HomeDataModelFromJson(Map<String, dynamic> json) =>
    HomeDataModel(
      mwhId: json['mwh_id'] != null ? (json['mwh_id'] as num).toInt() : 0,
      mName: json['m_name'] != null ? json['m_name'] as String : 'No data',
      mDate: json['m_date'] != null ? json['m_date'] as String : 'No data',
      mVendor: json['m_vendor'] != null ? json['m_vendor'] as String : 'No data',
      mPrjcode: json['m_prjcode'] != null ? json['m_prjcode'] as String : 'No data',
      mQty: json['m_qty'] != null ? (json['m_qty'] as num).toDouble() : 0.0,
      mUnit: json['m_unit'] != null ? json['m_unit'] as String : 'No data',
      mDocnum: json['m_docnum'] != null ? json['m_docnum'] as String : 'No data',
      mItemcode: json['m_itemcode'] != null ? json['m_itemcode'] as String : 'No data',
      cDate: json['c_date'] != null ? json['c_date'] as String : 'No data',
      code: json['code'] != null ? json['code'] as String : 'No data',
      qcQtyIn: json['qc_qty_in'] != null ? (json['qc_qty_in'] as num).toDouble() : 0.0,
      qcQtyOut: json['qc_qty_out'] != null ? (json['qc_qty_out'] as num).toDouble() : 0.0,
      zcWarehouseQtyImport: json['zc_warehouse_qty_int'] != null ? (json['zc_warehouse_qty_int'] as num).toDouble() : 0.0,
      zcWarehouseQtyExport: json['zc_warehouse_qty_out'] != null ? (json['zc_warehouse_qty_out'] as num).toDouble() : 0.0,
      qtyState: json['qty_state'] != null ? json['qty_state'] as String : 'No data',
      staff: json['staff'] != null ? json['staff'] as String? : 'No data',
      qcCheckTime: json['qc_check_time'] != null ? json['qc_check_time'] as String? : 'No data',
      qcScanTime: json['qc_scan_time'] != null ? json['qc_scan_time'] as String? : 'No data',
      zcWarehouseTimeInt: json['zc_warehouse_time_int'] != null ? json['zc_warehouse_time_int'] as String? : 'No data',
      zcWarehouseTimeOut: json['zc_warehouse_time_out'] != null ? json['zc_warehouse_time_out'] as String? : 'No data',
      zcOutWarehouseUnit: json['zc_out_Warehouse_unit'] != null ? json['zc_out_Warehouse_unit'] as String? : 'No data',
      zcUpInQtyTime: json['zc_up_in_qty_time'] != null ? json['zc_up_in_qty_time'] as String? : 'No data',
      qcUpInQtyTime: json['qc_up_in_qty_time'] != null ? json['qc_up_in_qty_time'] as String? : 'No data',
      zcInQcQtyTime: json['zc_in_qc_qty_time'] != null ? json['zc_in_qc_qty_time'] as String? : 'No data',
      adminAllDataTime: json['admin_all_data_time'] != null ? json['admin_all_data_time'] as String? : 'No data',
      codeBonded: json['code_bonded'] != null ? json['code_bonded'] as String? : 'No data',
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
