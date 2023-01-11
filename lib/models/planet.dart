import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:solar_system/models/base_mesh.dart';

@immutable
class Planet {
  const Planet({
    this.mecury,
    this.saturn,
    this.venus,
    this.earth,
    this.mars,
    this.jupiter,
    this.uranus,
    this.neptune,
    this.pluto,
  });
  final BaseMesh? mecury;
  final BaseMesh? saturn;
  final BaseMesh? venus;
  final BaseMesh? earth;
  final BaseMesh? mars;
  final BaseMesh? jupiter;
  final BaseMesh? uranus;
  final BaseMesh? neptune;
  final BaseMesh? pluto;

  Planet copyWith({
    BaseMesh? mecury,
    BaseMesh? saturn,
    BaseMesh? venus,
    BaseMesh? earth,
    BaseMesh? mars,
    BaseMesh? jupiter,
    BaseMesh? uranus,
    BaseMesh? neptune,
    BaseMesh? pluto,
  }) {
    return Planet(
      mecury: mecury ?? this.mecury,
      saturn: saturn ?? this.saturn,
      venus: venus ?? this.venus,
      earth: earth ?? this.earth,
      mars: mars ?? this.mars,
      jupiter: jupiter ?? this.jupiter,
      uranus: uranus ?? this.uranus,
      neptune: neptune ?? this.neptune,
      pluto: pluto ?? this.pluto,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mecury': mecury?.toMap(),
      'saturn': saturn?.toMap(),
      'venus': venus?.toMap(),
      'earth': earth?.toMap(),
      'mars': mars?.toMap(),
      'jupiter': jupiter?.toMap(),
      'uranus': uranus?.toMap(),
      'neptune': neptune?.toMap(),
      'pluto': pluto?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Planet(mecury: $mecury, saturn: $saturn, venus: $venus, '
        'earth: $earth, mars: $mars, jupiter: $jupiter, uranus: $uranus, '
        'neptune: $neptune, pluto: $pluto)';
  }

  @override
  bool operator ==(covariant Planet other) {
    if (identical(this, other)) return true;

    return other.mecury == mecury &&
        other.saturn == saturn &&
        other.venus == venus &&
        other.earth == earth &&
        other.mars == mars &&
        other.jupiter == jupiter &&
        other.uranus == uranus &&
        other.neptune == neptune &&
        other.pluto == pluto;
  }

  @override
  int get hashCode {
    return mecury.hashCode ^
        saturn.hashCode ^
        venus.hashCode ^
        earth.hashCode ^
        mars.hashCode ^
        jupiter.hashCode ^
        uranus.hashCode ^
        neptune.hashCode ^
        pluto.hashCode;
  }
}
