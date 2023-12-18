// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String?,
      accessToken: json['accessToken'] as String?,
      mobile: json['mobile'] as String?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      isNewUser: json['isNewUser'] as bool?,
      refreshToken: json['refreshToken'],
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'accessToken': instance.accessToken,
      'mobile': instance.mobile,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'isNewUser': instance.isNewUser,
      'refreshToken': instance.refreshToken,
    };
