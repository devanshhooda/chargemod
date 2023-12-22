// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'station_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StationModelImpl _$$StationModelImplFromJson(Map<String, dynamic> json) =>
    _$StationModelImpl(
      locationId: json['locationId'] as int?,
      name: json['name'] as String?,
      parkingType: json['parkingType'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as int?,
      image: json['image'] as String?,
      street1: json['street1'] as String?,
      street2: json['street2'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      zip: json['zip'] as String?,
      status: json['status'] as String?,
      isListed: json['isListed'] as bool?,
      geoLocation: json['geoLocation'],
    );

Map<String, dynamic> _$$StationModelImplToJson(_$StationModelImpl instance) =>
    <String, dynamic>{
      'locationId': instance.locationId,
      'name': instance.name,
      'parkingType': instance.parkingType,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'street1': instance.street1,
      'street2': instance.street2,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'zip': instance.zip,
      'status': instance.status,
      'isListed': instance.isListed,
      'geoLocation': instance.geoLocation,
    };
