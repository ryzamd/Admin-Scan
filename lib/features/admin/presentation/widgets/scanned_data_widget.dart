import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../domain/entities/scanned_data_entity.dart';

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
          const Text(
            'Scanned Item Details:',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.blackCommon,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildDataRow('名稱:', data.mName),
          _buildDataRow('指令號:', data.mPrjcode),
          
          ...buildActionSpecificFields(),
        ],
      ),
    );
  }
  
  List<Widget> buildActionSpecificFields() {
    switch (actionType) {
      case 'clear_warehouse_qty':
        return [
          _buildDataRow('入庫:', data.zcWarehouseQtyInt.toString()),
          _buildDataRow('出庫:', data.zcWarehouseQtyOut.toString()),
          if (data.zcUpInQtyTime != null)
            _buildDataRow('撤回時間:', DateFormatter.formatTimestamp(data.zcUpInQtyTime!)),
        ];
        
      case 'clear_qc_inspection':
      case 'clear_qc_deduction':
        return [
          _buildDataRow('質檢:', data.qcQtyIn.toString()),
          _buildDataRow('扣碼:', data.qcQtyOut.toString()),
          if (data.qcUpInQtyTime != null)
            _buildDataRow('QC修改時間:', DateFormatter.formatTimestamp(data.qcUpInQtyTime!)),
        ];
        
      case 'pull_qc_unchecked':
        return [
          _buildDataRow('数量:', data.mQty.toString()),
          _buildDataRow('入庫:', data.zcWarehouseQtyInt.toString()),
          if (data.zcInQcQtyTime != null)
            _buildDataRow('時間:', DateFormatter.formatTimestamp(data.zcInQcQtyTime!)),
        ];
        
      case 'clear_all_data':
        return [
          _buildDataRow('質檢:', data.qcQtyIn.toString()),
          _buildDataRow('扣碼:', data.qcQtyOut.toString()),
          _buildDataRow('入庫:', data.zcWarehouseQtyInt.toString()),
          _buildDataRow('出庫:', data.zcWarehouseQtyOut.toString()),
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