import 'dart:convert';

import 'package:equatable/equatable.dart';

class VehicleObject extends Equatable {
  final int? id;
  final int? userId;
  final String? manufacturerName;
  final String? vehicleType;
  final String? vehicleColor;
  final String? vehicleCardNum;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const VehicleObject({
    this.id,
    this.userId,
    this.manufacturerName,
    this.vehicleType,
    this.vehicleColor,
    this.vehicleCardNum,
    this.createdAt,
    this.updatedAt,
  });

  factory VehicleObject.fromMap(Map<String, dynamic> data) => VehicleObject(
        id: data['id'] as int?,
        userId: data['user_id'] as int?,
        manufacturerName: data['manufacturer_name'] as String?,
        vehicleType: data['vehicle_type'] as String?,
        vehicleColor: data['vehicle_color'] as String?,
        vehicleCardNum: data['vehicle_cardNum'] as String?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'manufacturer_name': manufacturerName,
        'vehicle_type': vehicleType,
        'vehicle_color': vehicleColor,
        'vehicle_cardNum': vehicleCardNum,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VehicleObject].
  factory VehicleObject.fromJson(String data) {
    return VehicleObject.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VehicleObject] to a JSON string.
  String toJson() => json.encode(toMap());

  VehicleObject copyWith({
    int? id,
    int? userId,
    String? manufacturerName,
    String? vehicleType,
    String? vehicleColor,
    String? vehicleCardNum,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VehicleObject(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      manufacturerName: manufacturerName ?? this.manufacturerName,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleColor: vehicleColor ?? this.vehicleColor,
      vehicleCardNum: vehicleCardNum ?? this.vehicleCardNum,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      manufacturerName,
      vehicleType,
      vehicleColor,
      vehicleCardNum,
      createdAt,
      updatedAt,
    ];
  }
}
