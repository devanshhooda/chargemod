import 'package:freezed_annotation/freezed_annotation.dart';
part 'station_model.freezed.dart';
part 'station_model.g.dart';

@freezed
class StationModel with _$StationModel {
  const factory StationModel(
      {int? locationId,
      String? name,
      String? parkingType,
      String? email,
      int? phone,
      String? image,
      String? street1,
      String? street2,
      String? city,
      String? state,
      String? country,
      String? zip,
      String? status,
      bool? isListed,
      geoLocation}) = _StationModel;

  factory StationModel.fromJson(Map<String, dynamic> json) =>
      _$StationModelFromJson(json);
}
