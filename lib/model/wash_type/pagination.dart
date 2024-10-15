import 'dart:convert';

import 'package:equatable/equatable.dart';

class Pagination extends Equatable {
  final int? totalItems;
  final int? perPage;
  final int? currentPage;
  final int? totalPages;

  const Pagination({
    this.totalItems,
    this.perPage,
    this.currentPage,
    this.totalPages,
  });

  factory Pagination.fromMap(Map<String, dynamic> data) => Pagination(
        totalItems: data['total_items'] as int?,
        perPage: data['per_page'] as int?,
        currentPage: data['currentPage'] as int?,
        totalPages: data['totalPages'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'total_items': totalItems,
        'per_page': perPage,
        'currentPage': currentPage,
        'totalPages': totalPages,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pagination].
  factory Pagination.fromJson(String data) {
    return Pagination.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pagination] to a JSON string.
  String toJson() => json.encode(toMap());

  Pagination copyWith({
    int? totalItems,
    int? perPage,
    int? currentPage,
    int? totalPages,
  }) {
    return Pagination(
      totalItems: totalItems ?? this.totalItems,
      perPage: perPage ?? this.perPage,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props {
    return [
      totalItems,
      perPage,
      currentPage,
      totalPages,
    ];
  }
}
