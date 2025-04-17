class HomeDataConfig {
  final List<String> displayColumns;
  
  final Map<String, String> columnTitles;
  
  final String defaultSortColumn;
  
  final bool defaultSortAscending;
  
  final Map<String, int> columnFlex;
  
  final String functionName;

  const HomeDataConfig({
    required this.displayColumns,
    required this.columnTitles,
    required this.defaultSortColumn,
    this.defaultSortAscending = false,
    required this.columnFlex,
    required this.functionName,
  });

  static const String COL_NAME = 'm_name';
  static const String COL_PROJECT_CODE = 'm_prjcode';
  static const String COL_QTY = 'm_qty';
  static const String COL_QC_QTY_IN = 'qc_qty_in';
  static const String COL_QC_QTY_OUT = 'qc_qty_out';
  static const String COL_WAREHOUSE_QTY_INT = 'zc_warehouse_qty_int';
  static const String COL_WAREHOUSE_QTY_OUT = 'zc_warehouse_qty_out';
  static const String COL_DATE = 'm_date';
  static const String COL_QTY_STATE = 'qty_state';
  static const String COL_UP_IN_QTY_TIME = 'zc_up_in_qty_time';
  static const String COL_QC_UP_IN_QTY_TIME = 'qc_up_in_qty_time';
  static const String COL_IN_QC_QTY_TIME = 'zc_in_qc_qty_time';
  static const String COL_ADMIN_ALL_DATA_TIME = 'admin_all_data_time';

  static HomeDataConfig clearWarehouseQtyConfig() {
    return const HomeDataConfig(
      functionName: 'Clear Warehouse Quantity',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_WAREHOUSE_QTY_INT,
        COL_WAREHOUSE_QTY_OUT,
        COL_UP_IN_QTY_TIME,
        COL_QTY_STATE,
      ],
      columnTitles: {
        COL_NAME: '材料名',
        COL_PROJECT_CODE: '指令号',
        COL_WAREHOUSE_QTY_INT: '撤回後的入庫數量',
        COL_WAREHOUSE_QTY_OUT: '撤回後的出庫數量',
        COL_UP_IN_QTY_TIME: '撤回數據時間',
        COL_QTY_STATE: '數據狀態',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_WAREHOUSE_QTY_INT: 2,
        COL_WAREHOUSE_QTY_OUT: 2,
        COL_UP_IN_QTY_TIME: 2,
        COL_QTY_STATE: 2,
      },
    );
  }

  static HomeDataConfig clearQcInspectionConfig() {
    return const HomeDataConfig(
      functionName: 'Clear QC Inspection Data',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_QC_QTY_IN,
        COL_QC_QTY_OUT,
        COL_QC_UP_IN_QTY_TIME,
        COL_QTY_STATE,
      ],
      columnTitles: {
        COL_NAME: '材料名',
        COL_PROJECT_CODE: '指令号',
        COL_QC_QTY_IN: '質檢數量',
        COL_QC_QTY_OUT: '扣碼數量',
        COL_QC_UP_IN_QTY_TIME: '撤回數據時間',
        COL_QTY_STATE: '數據狀態',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_QC_QTY_IN: 2,
        COL_QC_QTY_OUT: 2,
        COL_QC_UP_IN_QTY_TIME: 2,
        COL_QTY_STATE: 2,
      },
    );
  }

  static HomeDataConfig clearQcDeductionConfig() {
    return const HomeDataConfig(
      functionName: 'Clear QC Deduction',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_QC_QTY_IN,
        COL_QC_QTY_OUT,
        COL_QC_UP_IN_QTY_TIME,
        COL_QTY_STATE,
      ],
      columnTitles: {
        COL_NAME: '材料名',
        COL_PROJECT_CODE: '指令号',
        COL_QC_QTY_IN: '質檢數量',
        COL_QC_QTY_OUT: '扣碼數量',
        COL_QC_UP_IN_QTY_TIME: '撤回數據時間',
        COL_QTY_STATE: '數據狀態',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_QC_QTY_IN: 2,
        COL_QC_QTY_OUT: 2,
        COL_QC_UP_IN_QTY_TIME: 2,
        COL_QTY_STATE: 2,
      },
    );
  }

  static HomeDataConfig pullQcUncheckedConfig() {
    return const HomeDataConfig(
      functionName: 'Pull QC Unchecked Data',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_QTY,
        COL_WAREHOUSE_QTY_INT,
        COL_IN_QC_QTY_TIME,
        COL_QTY_STATE,
      ],
      columnTitles: {
        COL_NAME: '材料名',
        COL_PROJECT_CODE: '指令号',
        COL_QTY: '数量',
        COL_WAREHOUSE_QTY_INT: '資材入庫數量',
        COL_IN_QC_QTY_TIME: '入庫時間',
        COL_QTY_STATE: '數據狀態',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_QTY: 1,
        COL_WAREHOUSE_QTY_INT: 2,
        COL_IN_QC_QTY_TIME: 2,
        COL_QTY_STATE: 2,
      },
    );
  }

  static HomeDataConfig clearAllDataConfig() {
    return const HomeDataConfig(
      functionName: 'Clear All Data',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_QC_QTY_IN,
        COL_QC_QTY_OUT,
        COL_WAREHOUSE_QTY_INT,
        COL_WAREHOUSE_QTY_OUT,
        COL_ADMIN_ALL_DATA_TIME,
      ],
      columnTitles: {
        COL_NAME: '材料名',
        COL_PROJECT_CODE: '指令号',
        COL_QC_QTY_IN: '入庫數量',
        COL_QC_QTY_OUT: '出庫數量',
        COL_WAREHOUSE_QTY_INT: '資材入庫數量',
        COL_WAREHOUSE_QTY_OUT: '倉庫出庫數量',
        COL_ADMIN_ALL_DATA_TIME: '時間',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_QC_QTY_IN: 2,
        COL_QC_QTY_OUT: 2,
        COL_WAREHOUSE_QTY_INT: 2,
        COL_WAREHOUSE_QTY_OUT: 2,
        COL_ADMIN_ALL_DATA_TIME: 2,
      },
    );
  }

  static HomeDataConfig defaultConfig() {
    return const HomeDataConfig(
      functionName: 'Home Data',
      displayColumns: [
        COL_NAME,
        COL_PROJECT_CODE,
        COL_QC_QTY_IN,
        COL_QC_QTY_OUT,
        COL_WAREHOUSE_QTY_INT,
        COL_WAREHOUSE_QTY_OUT,
        COL_DATE,
      ],
      columnTitles: {
        COL_NAME: '名稱',
        COL_PROJECT_CODE: '指令號',
        COL_QC_QTY_IN: '入庫數量',
        COL_QC_QTY_OUT: '出庫數量',
        COL_WAREHOUSE_QTY_INT: '資材入庫',
        COL_WAREHOUSE_QTY_OUT: '資材出庫',
        COL_DATE: '時間',
      },
      defaultSortColumn: COL_DATE,
      columnFlex: {
        COL_NAME: 2,
        COL_PROJECT_CODE: 2,
        COL_QC_QTY_IN: 2,
        COL_QC_QTY_OUT: 2,
        COL_WAREHOUSE_QTY_INT: 2,
        COL_WAREHOUSE_QTY_OUT: 2,
        COL_DATE: 3,
      },
    );
  }
}