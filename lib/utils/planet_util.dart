import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:solar_system/models/base_mesh.dart';
import 'package:solar_system/models/planet.dart';
import 'package:solar_system/params/create_planet_params.dart';
import 'package:solar_system/params/planet_ring_params.dart';
import 'package:solar_system/res/assets/textures.dart';
import 'package:three_dart/three_dart.dart' as three;

const int _sphereSegments = 30;
const int _ringSegments = 32;
const double _ringRotation = -0.5 * math.pi;

class PlanetUtil {
  factory PlanetUtil() {
    return _instance;
  }
  PlanetUtil._();

  static final PlanetUtil _instance = PlanetUtil._();
  static PlanetUtil get instance => _instance;
  Future<Planet> initializePlanet(three.Scene scene) async {
    return Planet(
      mecury: await _createPlanet(
        CreatePlanetParams(
          size: 3.2,
          texture: textureMecury,
          position: 28,
        ),
        scene,
      ),
      venus: await _createPlanet(
        CreatePlanetParams(
          size: 5.8,
          texture: textureVenus,
          position: 44,
        ),
        scene,
      ),
      saturn: await _createPlanet(
        CreatePlanetParams(
          size: 10,
          texture: textureSaturn,
          position: 138,
          planetRingParams: const PlanetRingParams(
            innerRadius: 10,
            outerRadius: 20,
            texture: textureSaturnRing,
          ),
        ),
        scene,
      ),
      earth: await _createPlanet(
        CreatePlanetParams(
          size: 6,
          texture: textureEarth,
          position: 62,
        ),
        scene,
      ),
      jupiter: await _createPlanet(
        CreatePlanetParams(
          size: 12,
          texture: textureJupiter,
          position: 100,
        ),
        scene,
      ),
      mars: await _createPlanet(
        CreatePlanetParams(
          size: 4,
          texture: textureMars,
          position: 78,
        ),
        scene,
      ),
      uranus: await _createPlanet(
        CreatePlanetParams(
          size: 7,
          texture: textureUranus,
          position: 176,
          planetRingParams: const PlanetRingParams(
            innerRadius: 7,
            outerRadius: 12,
            texture: textureUranus,
          ),
        ),
        scene,
      ),
      neptune: await _createPlanet(
        CreatePlanetParams(
          size: 7,
          texture: textureNeptune,
          position: 200,
        ),
        scene,
      ),
      pluto: await _createPlanet(
        CreatePlanetParams(
          size: 2.8,
          texture: texturePluto,
          position: 216,
        ),
        scene,
      ),
    );
  }

  Future<BaseMesh> _createPlanet(
    CreatePlanetParams createPlanetParams,
    three.Scene scene,
  ) async {
    final geo = three.SphereGeometry(
      createPlanetParams.size,
      _sphereSegments,
      _sphereSegments,
    );
    final mecuryTextureLoader = three.TextureLoader(null);
    final mat = three.MeshStandardMaterial({
      'map': await mecuryTextureLoader.loadAsync(
        createPlanetParams.texture,
      ),
    });
    final mesh = three.Mesh(geo, mat);
    final object3d = three.Object3D()..add(mesh);
    if (createPlanetParams.planetRingParams != null) {
      final ring = createPlanetParams.planetRingParams;
      final ringGeo = three.RingGeometry(
        ring!.innerRadius,
        ring.outerRadius,
        _ringSegments,
      );
      final ringTextureLoader = three.TextureLoader(null);
      final ringMat = three.MeshBasicMaterial({
        'map': await ringTextureLoader.loadAsync(
          ring.texture,
        ),
        'side': three.DoubleSide,
      });
      final ringMesh = three.Mesh(ringGeo, ringMat);
      object3d.add(ringMesh);
      ringMesh.position.x = createPlanetParams.position;
      ringMesh.rotation.x = _ringRotation;
    }
    scene.add(object3d);
    mesh.position.x = createPlanetParams.position;
    return BaseMesh(
      mesh: mesh,
      object3d: object3d,
    );
  }

  Future<void> animate({
    required Planet planet,
    required three.Mesh sun,
    required VoidCallback render,
  }) async {
    sun.rotateY(0.004);
    planet.mecury?.rotateMesh(0.004);
    planet.venus?.rotateMesh(0.002);
    planet.earth?.rotateMesh(0.02);
    planet.mars?.rotateMesh(0.018);
    planet.jupiter?.rotateMesh(0.04);
    planet.saturn?.rotateMesh(0.038);
    planet.uranus?.rotateMesh(0.03);
    planet.neptune?.rotateMesh(0.032);
    planet.pluto?.rotateMesh(0.008);

    ///
    planet.mecury?.rotateObject3D(0.04);
    planet.venus?.rotateObject3D(0.015);
    planet.earth?.rotateObject3D(0.01);
    planet.mars?.rotateObject3D(0.008);
    planet.jupiter?.rotateObject3D(0.002);
    planet.saturn?.rotateObject3D(0.0009);
    planet.uranus?.rotateObject3D(0.0004);
    planet.neptune?.rotateObject3D(0.0001);
    planet.pluto?.rotateObject3D(0.00007);
    render();
    Future.delayed(const Duration(milliseconds: 40), () {
      animate(
        planet: planet,
        sun: sun,
        render: render,
      );
    });
  }
}
