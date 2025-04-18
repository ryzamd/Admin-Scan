import 'package:flutter/material.dart';
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
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
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          
          _buildDataRow('Product:', data.mName),
          _buildDataRow('Project Code:', data.mPrjcode),
          
          ...buildActionSpecificFields(),
        ],
      ),
    );
  }
  
  List<Widget> buildActionSpecificFields() {
    switch (actionType) {
      case 'clear_warehouse_qty':
        return [
          _buildDataRow('WH Qty Import:', data.zcWarehouseQtyInt.toString()),
          _buildDataRow('WH Qty Export:', data.zcWarehouseQtyOut.toString()),
          if (data.zcUpInQtyTime != null)
            _buildDataRow('In Qty Time:', data.zcUpInQtyTime!),
        ];
        
      case 'clear_qc_inspection':
      case 'clear_qc_deduction':
        return [
          _buildDataRow('QC Qty In:', data.qcQtyIn.toString()),
          _buildDataRow('QC Qty Out:', data.qcQtyOut.toString()),
          if (data.qcUpInQtyTime != null)
            _buildDataRow('QC Up In Qty Time:', data.qcUpInQtyTime!),
        ];
        
      case 'pull_qc_unchecked':
        return [
          _buildDataRow('Quantity:', data.mQty.toString()),
          _buildDataRow('WH Qty Import:', data.zcWarehouseQtyInt.toString()),
          if (data.zcInQcQtyTime != null)
            _buildDataRow('In QC Qty Time:', data.zcInQcQtyTime!),
        ];
        
      case 'clear_all_data':
        return [
          _buildDataRow('QC Qty In:', data.qcQtyIn.toString()),
          _buildDataRow('QC Qty Out:', data.qcQtyOut.toString()),
          _buildDataRow('WH Qty Import:', data.zcWarehouseQtyInt.toString()),
          _buildDataRow('WH Qty Export:', data.zcWarehouseQtyOut.toString()),
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
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              maxLines: 2,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}