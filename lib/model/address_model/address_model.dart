import 'package:json_annotation/json_annotation.dart';

part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  String? area;
  String? city;
  String? fullname;
  String? house;
  String? id;
  String? phone;
  String? pincode;
  String? state;

  AddressModel({
    this.area,
    this.city,
    this.fullname,
    this.house,
    this.id,
    this.phone,
    this.pincode,
    this.state,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return _$AddressModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}
