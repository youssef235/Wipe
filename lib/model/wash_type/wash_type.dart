import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'datum.dart';
import 'pagination.dart';

class WashType extends Equatable {
  final Pagination? pagination;
  final List<WashTypeService>? data;

  const WashType({this.pagination, this.data});

  factory WashType.fromMap(Map<String, dynamic> data) => WashType(
        pagination: data['pagination'] == null
            ? null
            : Pagination.fromMap(data['pagination'] as Map<String, dynamic>),
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => WashTypeService.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'pagination': pagination?.toMap(),
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WashType].
  factory WashType.fromJson(String data) {
    return WashType.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WashType] to a JSON string.
  String toJson() => json.encode(toMap());

  WashType copyWith({
    Pagination? pagination,
    List<WashTypeService>? data,
  }) {
    return WashType(
      pagination: pagination ?? this.pagination,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [pagination, data];
}
