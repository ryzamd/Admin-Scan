import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/home_data_entity.dart';

part 'home_data_model.g.dart';

@JsonSerializable()
class HomeDataModel extends HomeDataEntity {
  const HomeDataModel({
    required super.mwhId,
    required super.mName,
    required super.mDate,
    required super.mVendor,
    required super.mPrjcode,
    required super.mQty,
    required super.mUnit,
    required super.mDocnum,
    required super.mItemcode,
    required super.cDate,
    required super.code,
    required super.qcQtyIn,
    required super.qcQtyOut,
    required super.zcWarehouseQtyImport,
    required super.zcWarehouseQtyExport,
    required super.qtyState,
    super.staff,
    super.qcCheckTime,
    super.qcScanTime,
    super.zcWarehouseTimeInt,
    super.zcWarehouseTimeOut,
    super.zcOutWarehouseUnit,
    super.zcUpInQtyTime,
    super.qcUpInQtyTime,
    super.zcInQcQtyTime,
    super.adminAllDataTime,
    super.codeBonded,
  });

  @JsonKey(name: 'mwh_id', defaultValue: 0)
  int get getMwhId => mwhId;

  @JsonKey(name: 'm_name', defaultValue: '')
  String get getMName => mName;

  @JsonKey(name: 'm_date', defaultValue: '')
  String get getMDate => mDate;

  @JsonKey(name: 'm_vendor', defaultValue: '')
  String get getMVendor => mVendor;

  @JsonKey(name: 'm_prjcode', defaultValue: '')
  String get getMPrjcode => mPrjcode;

  @JsonKey(name: 'm_qty', defaultValue: 0.0)
  double get getMQty => mQty;

  @JsonKey(name: 'm_unit', defaultValue: '')
  String get getMUnit => mUnit;

  @JsonKey(name: 'm_docnum', defaultValue: '')
  String get getMDocnum => mDocnum;

  @JsonKey(name: 'm_itemcode', defaultValue: '')
  String get getMItemcode => mItemcode;

  @JsonKey(name: 'c_date', defaultValue: '')
  String get getCDate => cDate;

  @JsonKey(defaultValue: '')
  String get getCode => code;

  @JsonKey(name: 'qc_qty_in', defaultValue: 0)
  int get getQcQtyIn => qcQtyIn;

  @JsonKey(name: 'qc_qty_out', defaultValue: 0)
  int get getQcQtyOut => qcQtyOut;

  @JsonKey(name: 'zc_warehouse_qty_int', defaultValue: 0)
  int get getZcWarehouseQtyImport => zcWarehouseQtyImport;

  @JsonKey(name: 'zc_warehouse_qty_out', defaultValue: 0)
  int get getZcWarehouseQtyExport => zcWarehouseQtyExport;

  @JsonKey(name: 'qty_state', defaultValue: '')
  String get getQtyState => qtyState;

  @JsonKey(name: 'staff')
  String? get getStaff => staff;

  @JsonKey(name: 'qc_check_time')
  String? get getQcCheckTime => qcCheckTime;

  @JsonKey(name: 'qc_scan_time')
  String? get getQcScanTime => qcScanTime;

  @JsonKey(name: 'zc_warehouse_time_int')
  String? get getZcWarehouseTimeInt => zcWarehouseTimeInt;

  @JsonKey(name: 'zc_warehouse_time_out')
  String? get getZcWarehouseTimeOut => zcWarehouseTimeOut;

  @JsonKey(name: 'zc_out_Warehouse_unit')
  String? get getZcOutWarehouseUnit => zcOutWarehouseUnit;

  @JsonKey(name: 'zc_up_in_qty_time')
  String? get getZcUpInQtyTime => zcUpInQtyTime;

  @JsonKey(name: 'qc_up_in_qty_time')
  String? get getQcUpInQtyTime => qcUpInQtyTime;

  @JsonKey(name: 'zc_in_qc_qty_time')
  String? get getZcInQcQtyTime => zcInQcQtyTime;

  @JsonKey(name: 'admin_all_data_time')
  String? get getAdminAllDataTime => adminAllDataTime;

  @JsonKey(name: 'code_bonded')
  String? get getCodeBonded => codeBonded;

  factory HomeDataModel.fromJson(Map<String, dynamic> json) =>
      _$HomeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDataModelToJson(this);
}