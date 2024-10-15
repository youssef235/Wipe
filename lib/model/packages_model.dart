class PackagesModel {
  final List<Subscripe> subscripes;
  final Packages packages;

  PackagesModel({
    required this.subscripes,
    required this.packages,
  });

  factory PackagesModel.fromJson(Map<String, dynamic> json) => PackagesModel(
        subscripes: List<Subscripe>.from(
            json["subscripes"].map((x) => Subscripe.fromJson(x))),
        packages: Packages.fromJson(json["packages"]),
      );

  Map<String, dynamic> toJson() => {
        "subscripes": List<dynamic>.from(subscripes.map((x) => x.toJson())),
        "packages": packages.toJson(),
      };
}

class Packages {
  final Pagination pagination;
  final List<PackagesDatum> data;

  Packages({
    required this.pagination,
    required this.data,
  });

  factory Packages.fromJson(Map<String, dynamic> json) => Packages(
        pagination: Pagination.fromJson(json["pagination"]),
        data: List<PackagesDatum>.from(
            json["data"].map((x) => PackagesDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class PackagesDatum {
  final int id;
  final String name;
  final int serviceId;
  final int orderTimes;
  final int periods;
  final int price;
  final Status status;
  final DateTime createdAt;
  final DateTime updatedAt;

  PackagesDatum({
    required this.id,
    required this.name,
    required this.serviceId,
    required this.orderTimes,
    required this.periods,
    required this.price,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PackagesDatum.fromJson(Map<String, dynamic> json) => PackagesDatum(
        id: json["id"],
        name: json["name"],
        serviceId: json["service_id"],
        orderTimes: json["order_times"],
        periods: json["periods"],
        price: json["price"],
        status: statusValues.map[json["status"]]!,
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "service_id": serviceId,
        "order_times": orderTimes,
        "periods": periods,
        "price": price,
        "status": statusValues.reverse[status],
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

enum Status { ACTIVE }

final statusValues = EnumValues({"active": Status.ACTIVE});

class Pagination {
  final int totalItems;
  final int perPage;
  final int currentPage;
  final int totalPages;

  Pagination({
    required this.totalItems,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalItems: json["total_items"],
        perPage: json["per_page"],
        currentPage: json["currentPage"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "total_items": totalItems,
        "per_page": perPage,
        "currentPage": currentPage,
        "totalPages": totalPages,
      };
}

class Subscripe {
  final int id;
  final int userId;
  final int packageId;
  final int orderTimes;
  final DateTime expireAt;
  final int? vehicleId;
  final int cost;
  final String statusPayment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final PackagesDatum package;
  final Vehicle? vehicle;

  Subscripe({
    required this.id,
    required this.userId,
    required this.packageId,
    required this.orderTimes,
    required this.expireAt,
    required this.vehicleId,
    required this.cost,
    required this.statusPayment,
    required this.createdAt,
    required this.updatedAt,
    required this.package,
    required this.vehicle,
  });

  factory Subscripe.fromJson(Map<String, dynamic> json) => Subscripe(
        id: json["id"],
        userId: json["user_id"],
        packageId: json["package_id"],
        orderTimes: json["order_times"],
        expireAt: DateTime.parse(json["expire_at"]),
        vehicleId: json["vehicle_id"],
        cost: json["cost"],
        statusPayment: json["status_payment"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        package: PackagesDatum.fromJson(json["package"]),
        vehicle:
            json["vehicle"] == null ? null : Vehicle.fromJson(json["vehicle"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "package_id": packageId,
        "order_times": orderTimes,
        "expire_at": expireAt.toIso8601String(),
        "vehicle_id": vehicleId,
        "cost": cost,
        "status_payment": statusPayment,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "package": package.toJson(),
        "vehicle": vehicle?.toJson(),
      };
}

class Vehicle {
  final int id;
  final String manufacturerName;
  final String vehicleType;
  final String vehicleColor;
  final String vehicleCardNum;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vehicle({
    required this.id,
    required this.manufacturerName,
    required this.vehicleType,
    required this.vehicleColor,
    required this.vehicleCardNum,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) => Vehicle(
        id: json["id"],
        manufacturerName: json["manufacturer_name"],
        vehicleType: json["vehicle_type"],
        vehicleColor: json["vehicle_color"],
        vehicleCardNum: json["vehicle_cardNum"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "manufacturer_name": manufacturerName,
        "vehicle_type": vehicleType,
        "vehicle_color": vehicleColor,
        "vehicle_cardNum": vehicleCardNum,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
