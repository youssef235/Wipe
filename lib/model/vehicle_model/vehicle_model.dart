import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';

class VehicleModel extends Equatable {
  final List<VehicleObject>? data;

  const VehicleModel({this.data});

  factory VehicleModel.fromMap(Map<String, dynamic> data) => VehicleModel(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => VehicleObject.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [VehicleModel].
  factory VehicleModel.fromJson(String data) {
    return VehicleModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [VehicleModel] to a JSON string.
  String toJson() => json.encode(toMap());

  VehicleModel copyWith({
    List<VehicleObject>? data,
  }) {
    return VehicleModel(
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [data];
}
