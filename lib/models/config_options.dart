import 'dart:convert';

import 'package:flutter/material.dart';

@immutable
class ConfigOptions {
  const ConfigOptions({
    required this.antialias,
    required this.alpha,
    required this.width,
    required this.height,
    this.dpr,
    this.canvas,
    this.gl,
  });
  factory ConfigOptions.fromJson(String source) =>
      ConfigOptions.fromMap(json.decode(source) as Map<String, dynamic>);

  factory ConfigOptions.fromMap(Map<String, dynamic> map) {
    return ConfigOptions(
      antialias: map['antialias'] as bool,
      alpha: map['alpha'] as bool,
      width: map['width'] as num,
      height: map['height'] as num,
      dpr: map['dpr'] as double,
      canvas: map['canvas'],
      gl: map['gl'],
    );
  }
  final bool antialias;
  final bool alpha;
  final num width;
  final num height;
  final double? dpr;
  final dynamic gl;
  final dynamic canvas;

  ConfigOptions copyWith({
    bool? antialias,
    bool? alpha,
    int? width,
    int? height,
    double? dpr,
    dynamic canvas,
    dynamic gl,
  }) {
    return ConfigOptions(
      antialias: antialias ?? this.antialias,
      alpha: alpha ?? this.alpha,
      width: width ?? this.width,
      height: height ?? this.height,
      dpr: dpr ?? this.dpr,
      canvas: canvas ?? this.canvas,
      gl: gl ?? this.gl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'antialias': antialias,
      'alpha': alpha,
      'width': width,
      'height': height,
      'dpr': dpr,
      'cavas': canvas,
      'gl': gl,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'ConfigOptions(antialias: $antialias, alpha: $alpha, width: $width, '
        'height: $height, dpr: $dpr)';
  }

  @override
  bool operator ==(covariant ConfigOptions other) {
    if (identical(this, other)) return true;

    return other.antialias == antialias &&
        other.alpha == alpha &&
        other.width == width &&
        other.height == height &&
        other.dpr == dpr;
  }

  @override
  int get hashCode {
    return antialias.hashCode ^
        alpha.hashCode ^
        width.hashCode ^
        height.hashCode ^
        dpr.hashCode;
  }
}
