class CarDetailsModel {
  final int id;
  final int userId;
  final int packageId;
  final int orderTimes;
  final DateTime expireAt;
  final int vehicleId;
  final num cost;
  final String statusPayment;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Vehicle vehicle;

  CarDetailsModel({
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
    required this.vehicle,
  });

  factory CarDetailsModel.fromJson(Map<String, dynamic> json) =>
      CarDetailsModel(
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
        vehicle: Vehicle.fromJson(json["vehicle"]),
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
        "vehicle": vehicle.toJson(),
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
