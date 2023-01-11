import 'package:flutter/material.dart';

@immutable
class PlanetRingParams {
  const PlanetRingParams({
    required this.innerRadius,
    required this.outerRadius,
    required this.texture,
  });
  final double innerRadius;
  final double outerRadius;
  final String texture;
}
