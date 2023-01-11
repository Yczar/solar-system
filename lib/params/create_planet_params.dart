import 'dart:convert';

import 'package:solar_system/params/planet_ring_params.dart';

class CreatePlanetParams {
  CreatePlanetParams({
    required this.size,
    required this.texture,
    required this.position,
    this.planetRingParams,
  });
  final double size;
  final String texture;
  final double position;
  final PlanetRingParams? planetRingParams;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'size': size,
      'texture': texture,
      'position': position,
      'planet_ring': planetRingParams
    };
  }

  String toJson() => json.encode(toMap());
}
