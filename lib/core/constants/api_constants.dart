class ApiConstants {
  static const String baseUrl = 'http://192.168.6.141:7053/api/';
  
  static const String loginEndpoint = 'login/auth/login';
  
  static const String homeListEndpoint = 'login/data_list/user_name';
  static const String checkCodeEndpoint = 'login/data_list/check_code';
  
  static const String clearIncomingDataEndpoint = 'Admin/update/zc_warehouse_qty_int';
  static const String clearQcInspectionDataEndpoint = 'Admin/update/update_qc_qty_out_int';
  static const String clearQcDeductionEndpoint = 'Admin/update/update_qc_qty_out';
  static const String pullQcUncheckedDataEndpoint = 'Admin/pull/zc_in_qc_qty';
  static const String clearAllDataEndpoint = 'Admin/pull/All_delete_data';
  
  static String get loginUrl => baseUrl + loginEndpoint;
  static String get homeListUrl => baseUrl + homeListEndpoint;
  static String get checkCodeUrl => baseUrl + checkCodeEndpoint;
  static String get clearIncomingDataUrl => baseUrl + clearIncomingDataEndpoint;
  static String get clearQcInspectionDataUrl => baseUrl + clearQcInspectionDataEndpoint;
  static String get clearQcDeductionUrl => baseUrl + clearQcDeductionEndpoint;
  static String get pullQcUncheckedDataUrl => baseUrl + pullQcUncheckedDataEndpoint;
  static String get clearAllDataUrl => baseUrl + clearAllDataEndpoint;
  
  static const String getListEndpoint = 'login/GetList';
  static String getListUrl(String date) => '$baseUrl$getListEndpoint?date=$date';
}