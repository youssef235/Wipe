import 'dart:convert';

import 'package:equatable/equatable.dart';

class WashTypeService extends Equatable {
  final int? id;
  final String? name;
  final dynamic regionId;
  final dynamic region;
  final int? capacity;
  final int? typeService;
  final String? typeServiceText;
  final int? basePrice;
  final dynamic baseFare;
  final dynamic minimumFare;
  final dynamic minimumDistance;
  final dynamic perDistance;
  final dynamic perMinuteDrive;
  final dynamic perMinuteWait;
  final dynamic waitingTimeLimit;
  final int? cancellationFee;
  final String? paymentMethod;
  final dynamic commissionType;
  final int? adminCommission;
  final int? fleetCommission;
  final String? serviceImage;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? description;

  const WashTypeService({
    this.id,
    this.name,
    this.regionId,
    this.region,
    this.capacity,
    this.typeService,
    this.typeServiceText,
    this.basePrice,
    this.baseFare,
    this.minimumFare,
    this.minimumDistance,
    this.perDistance,
    this.perMinuteDrive,
    this.perMinuteWait,
    this.waitingTimeLimit,
    this.cancellationFee,
    this.paymentMethod,
    this.commissionType,
    this.adminCommission,
    this.fleetCommission,
    this.serviceImage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.description,
  });

  factory WashTypeService.fromMap(Map<String, dynamic> data) => WashTypeService(
        id: data['id'] as int?,
        name: data['name'] as String?,
        regionId: data['region_id'] as dynamic,
        region: data['region'] as dynamic,
        capacity: data['capacity'] as int?,
        typeService: data['type_service'] as int?,
        typeServiceText: data['type_service_text'] as String?,
        basePrice: data['base_price'] as int?,
        baseFare: data['base_fare'] as dynamic,
        minimumFare: data['minimum_fare'] as dynamic,
        minimumDistance: data['minimum_distance'] as dynamic,
        perDistance: data['per_distance'] as dynamic,
        perMinuteDrive: data['per_minute_drive'] as dynamic,
        perMinuteWait: data['per_minute_wait'] as dynamic,
        waitingTimeLimit: data['waiting_time_limit'] as dynamic,
        cancellationFee: data['cancellation_fee'] as int?,
        paymentMethod: data['payment_method'] as String?,
        commissionType: data['commission_type'] as dynamic,
        adminCommission: data['admin_commission'] as int?,
        fleetCommission: data['fleet_commission'] as int?,
        serviceImage: data['service_image'] as String?,
        status: data['status'] as int?,
        createdAt: data['created_at'] == null
            ? null
            : DateTime.parse(data['created_at'] as String),
        updatedAt: data['updated_at'] == null
            ? null
            : DateTime.parse(data['updated_at'] as String),
        description: data['description'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'region_id': regionId,
        'region': region,
        'capacity': capacity,
        'type_service': typeService,
        'type_service_text': typeServiceText,
        'base_price': basePrice,
        'base_fare': baseFare,
        'minimum_fare': minimumFare,
        'minimum_distance': minimumDistance,
        'per_distance': perDistance,
        'per_minute_drive': perMinuteDrive,
        'per_minute_wait': perMinuteWait,
        'waiting_time_limit': waitingTimeLimit,
        'cancellation_fee': cancellationFee,
        'payment_method': paymentMethod,
        'commission_type': commissionType,
        'admin_commission': adminCommission,
        'fleet_commission': fleetCommission,
        'service_image': serviceImage,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'description': description,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WashTypeService].
  factory WashTypeService.fromJson(String data) {
    return WashTypeService.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WashTypeService] to a JSON string.
  String toJson() => json.encode(toMap());

  WashTypeService copyWith({
    int? id,
    String? name,
    dynamic regionId,
    dynamic region,
    int? capacity,
    int? typeService,
    String? typeServiceText,
    int? basePrice,
    dynamic baseFare,
    dynamic minimumFare,
    dynamic minimumDistance,
    dynamic perDistance,
    dynamic perMinuteDrive,
    dynamic perMinuteWait,
    dynamic waitingTimeLimit,
    int? cancellationFee,
    String? paymentMethod,
    dynamic commissionType,
    int? adminCommission,
    int? fleetCommission,
    String? serviceImage,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
  }) {
    return WashTypeService(
      id: id ?? this.id,
      name: name ?? this.name,
      regionId: regionId ?? this.regionId,
      region: region ?? this.region,
      capacity: capacity ?? this.capacity,
      typeService: typeService ?? this.typeService,
      typeServiceText: typeServiceText ?? this.typeServiceText,
      basePrice: basePrice ?? this.basePrice,
      baseFare: baseFare ?? this.baseFare,
      minimumFare: minimumFare ?? this.minimumFare,
      minimumDistance: minimumDistance ?? this.minimumDistance,
      perDistance: perDistance ?? this.perDistance,
      perMinuteDrive: perMinuteDrive ?? this.perMinuteDrive,
      perMinuteWait: perMinuteWait ?? this.perMinuteWait,
      waitingTimeLimit: waitingTimeLimit ?? this.waitingTimeLimit,
      cancellationFee: cancellationFee ?? this.cancellationFee,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      commissionType: commissionType ?? this.commissionType,
      adminCommission: adminCommission ?? this.adminCommission,
      fleetCommission: fleetCommission ?? this.fleetCommission,
      serviceImage: serviceImage ?? this.serviceImage,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      regionId,
      region,
      capacity,
      typeService,
      typeServiceText,
      basePrice,
      baseFare,
      minimumFare,
      minimumDistance,
      perDistance,
      perMinuteDrive,
      perMinuteWait,
      waitingTimeLimit,
      cancellationFee,
      paymentMethod,
      commissionType,
      adminCommission,
      fleetCommission,
      serviceImage,
      status,
      createdAt,
      updatedAt,
      description,
    ];
  }
}
