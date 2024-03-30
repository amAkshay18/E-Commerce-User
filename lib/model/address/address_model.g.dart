// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      area: json['area'] as String?,
      city: json['city'] as String?,
      fullname: json['fullname'] as String?,
      house: json['house'] as String?,
      id: json['id'] as String?,
      phone: json['phone'] as String?,
      pincode: json['pincode'] as String?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'area': instance.area,
      'city': instance.city,
      'fullname': instance.fullname,
      'house': instance.house,
      'id': instance.id,
      'phone': instance.phone,
      'pincode': instance.pincode,
      'state': instance.state,
    };
