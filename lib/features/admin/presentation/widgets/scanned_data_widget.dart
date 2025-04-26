import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/services/get_translate_key.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/scanned_data_entity.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScannedData extends StatelessWidget {
  final ScannedDataEntity data;
  final String actionType;
  final VoidCallback onExecute;
  
  const ScannedData({
    super.key,
    required this.data,
    required this.actionType,
    required this.onExecute,
  });

  @override
  Widget build(BuildContext context) {

    final multiLanguage = AppLocalizations.of(context);

    return Container(
      height: 230,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteCommon,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.blackCommon.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            multiLanguage.scannedItemDetailLabel,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.blackCommon,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildDataRow(multiLanguage.materialNameLabel, data.mName),
          _buildDataRow(multiLanguage.materialCommandNumberLabel, data.mPrjcode),
          
          ...buildActionSpecificFields(context),
        ],
      ),
    );
  }
  
  List<Widget> buildActionSpecificFields(BuildContext context) {

     final multiLanguage = AppLocalizations.of(context);

    switch (actionType) {
      case FunctionType.ACTION_CLEAR_WAREHOUSE_QTY:
        return [
          _buildDataRow(multiLanguage.materialImportLabel, data.zcWarehouseQtyInt.toString()),
          _buildDataRow(multiLanguage.materialExportLabel, data.zcWarehouseQtyOut.toString()),
          if (data.zcUpInQtyTime != null)
            _buildDataRow(multiLanguage.materialExportTimeLabel, DateFormatter.formatTimestamp(data.zcUpInQtyTime!)),
        ];
        
      case FunctionType.ACTION_CLEAR_QC_INSPECTION:
      case FunctionType.ACTION_CLEAR_QC_DEDUCTION:
        return [
          _buildDataRow(multiLanguage.qualityInspectionLabel, data.qcQtyIn.toString()),
          _buildDataRow(multiLanguage.deductionCodeLabel, data.qcQtyOut.toString()),
          if (data.qcUpInQtyTime != null)
            _buildDataRow(multiLanguage.qcModificationTimeLabel, DateFormatter.formatTimestamp(data.qcUpInQtyTime!)),
        ];
        
      case FunctionType.ACTION_PULL_QC_UNCHECKED:
        return [
          _buildDataRow(multiLanguage.quantityLabel, data.mQty.toString()),
          _buildDataRow(multiLanguage.materialImportLabel, data.zcWarehouseQtyInt.toString()),
          if (data.zcInQcQtyTime != null)
            _buildDataRow(multiLanguage.importUnInspectMaterialTimeLabel, DateFormatter.formatTimestamp(data.zcInQcQtyTime!)),
        ];
        
      case FunctionType.ACTION_CLEAR_ALL_DATA:
        return [
          _buildDataRow(multiLanguage.qualityInspectionLabel, data.qcQtyIn.toString()),
          _buildDataRow(multiLanguage.deductionCodeLabel, data.qcQtyOut.toString()),
          _buildDataRow(multiLanguage.materialImportLabel, data.zcWarehouseQtyInt.toString()),
          _buildDataRow(multiLanguage.materialExportLabel, data.zcWarehouseQtyOut.toString()),
        ];
        
      default:
        return [];
    }
  }
  
  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: AppColors.blackCommon
              ),
            ),
          ),

          Expanded(
            child: Text(
              value,
              maxLines: 3,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.blackCommon
              ),
            ),
          ),
        ],
      ),
    );
  }
}