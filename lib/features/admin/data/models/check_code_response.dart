import 'package:json_annotation/json_annotation.dart';
import 'scanned_data_model.dart';

part 'check_code_response.g.dart';

@JsonSerializable()
class CheckCodeResponse {
  final String message;
  final ScannedDataModel data;

  CheckCodeResponse({required this.message, required this.data});
  
  factory CheckCodeResponse.fromJson(Map<String, dynamic> json) => _$CheckCodeResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$CheckCodeResponseToJson(this);
}