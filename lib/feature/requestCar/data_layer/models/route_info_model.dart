import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/location_point_entity.dart';
import 'package:uberCloneRider/feature/requestCar/domain_layer/entities/route_info_entity.dart';

class RouteInfoModel extends RouteInfoEntity {
  const RouteInfoModel({
    required super.distanceKm,
    required super.durationMin,
    required super.points,
    super.isFallback,
  });

  factory RouteInfoModel.fromOsrmMap(Map<String, dynamic> map) {
    final points = PolylinePoints.decodePolyline(map['geometry'] as String)
        .map(
          (point) => LocationPointEntity(
            latitude: point.latitude,
            longitude: point.longitude,
          ),
        )
        .toList();

    return RouteInfoModel(
      distanceKm: ((map['distance'] as num?)?.toDouble() ?? 0) / 1000,
      durationMin: ((map['duration'] as num?)?.toDouble() ?? 0) / 60,
      points: points,
    );
  }
}
