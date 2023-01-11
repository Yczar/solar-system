import 'package:flutter/material.dart';

import 'package:solar_system/models/planet.dart';
import 'package:solar_system/utils/planet_util.dart';
import 'package:three_dart/three_dart.dart' as three;

extension PlanetExtension on Planet {
  Future<Planet> initializePlanets(three.Scene scene) async =>
      PlanetUtil.instance.initializePlanet(scene);
  Future<void> animate({
    required Planet planet,
    required three.Mesh sun,
    required VoidCallback render,
  }) async =>
      PlanetUtil.instance.animate(
        planet: planet,
        sun: sun,
        render: render,
      );
}
