import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/scanned_data_entity.dart';

part 'scanned_data_model.g.dart';

@JsonSerializable()
class ScannedDataModel extends ScannedDataEntity {
  const ScannedDataModel({
    super.mwhId,
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
    super.staff,
    super.qcCheckTime,
    super.qcScanTime,
    required super.qcQtyIn,
    required super.qcQtyOut,
    required super.zcWarehouseQtyInt,
    required super.zcWarehouseQtyOut,
    super.zcWarehouseTimeInt,
    super.zcWarehouseTimeOut,
    super.zcOutWarehouseUnit,
    super.zcUpInQtyTime,
    super.qcUpInQtyTime,
    super.zcInQcQtyTime,
    required super.qtyState,
    super.adminAllDataTime,
    super.codeBonded,
    required super.message,
  });

  factory ScannedDataModel.fromJson(Map<String, dynamic> json) => _$ScannedDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScannedDataModelToJson(this);
}