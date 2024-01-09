import 'dart:convert';

DashboardDataModel dashboardDataModelFromJson(String str) => DashboardDataModel.fromJson(json.decode(str));

String dashboardDataModelToJson(DashboardDataModel data) => json.encode(data.toJson());

class DashboardDataModel {
  final Data? data;

  DashboardDataModel({
    this.data,
  });

  factory DashboardDataModel.fromJson(Map<String, dynamic> json) => DashboardDataModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  final int? processingOrder;
  final int? rideComplete;
  final int? totalRating;
  final int? totalPayment;

  Data({
    this.processingOrder,
    this.rideComplete,
    this.totalRating,
    this.totalPayment,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    processingOrder: json["processing_order"],
    rideComplete: json["ride_complete"],
    totalRating: json["total_rating"],
    totalPayment: json["total_payment"],
  );

  Map<String, dynamic> toJson() => {
    "processing_order": processingOrder,
    "ride_complete": rideComplete,
    "total_rating": totalRating,
    "total_payment": totalPayment,
  };
}
