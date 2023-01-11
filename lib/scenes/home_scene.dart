import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gl/flutter_gl.dart';
import 'package:solar_system/models/config_options.dart';
import 'package:solar_system/models/planet.dart';
import 'package:solar_system/res/assets/textures.dart';
import 'package:solar_system/res/extensions/planet_extension.dart';
import 'package:solar_system/widgets/credit_widget.dart';
import 'package:solar_system/widgets/scene_title_widget.dart';
import 'package:three_dart/three_dart.dart' as three;
import 'package:three_dart_jsm/three_dart_jsm.dart' as three_jsm;

class HomeScene extends StatefulWidget {
  const HomeScene({super.key});

  @override
  State<HomeScene> createState() => _HomeSceneState();
}

class _HomeSceneState extends State<HomeScene> {
  /// Keys
  late final GlobalKey<three_jsm.DomLikeListenableState> _domLikeKey;

  /// three
  three.WebGLRenderer? renderer;
  three.WebGLRenderTarget? renderTarget;

  /// GL
  late FlutterGlPlugin three3dRender;

  /// config
  late double width;
  late double height;
  late three.Scene _scene;
  late three.Camera _camera;
  Size? screenSize;
  double dpr = 1;
  late int sourceTexture;

  /// planets
  late three.Mesh _sun;
  late Planet _planet;

  @override
  void initState() {
    super.initState();
    _domLikeKey = GlobalKey();
    _planet = const Planet();
  }

  @override
  Widget build(BuildContext context) {
    return three_jsm.DomLikeListenable(
      key: _domLikeKey,
      builder: (context) {
        _initSize();
        return Scaffold(
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: width,
                    height: height,
                    color: Colors.black,
                    child: Builder(
                      builder: (BuildContext context) {
                        if (three3dRender.isInitialized) {
                          if (kIsWeb) {
                            return HtmlElementView(
                              viewType: three3dRender.textureId!.toString(),
                            );
                          }
                          return Texture(
                            textureId: three3dRender.textureId!,
                          );
                        }
                        return Container();
                      },
                    ),
                  ),
                  const SceneTitileWidget(),
                  const Positioned(
                    bottom: 20,
                    left: 20,
                    child: CreditWidget(),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _initSize() {
    if (screenSize != null) {
      return;
    }

    final mediaQuery = MediaQuery.of(context);

    screenSize = mediaQuery.size;
    dpr = mediaQuery.devicePixelRatio;

    _initPlatformState();
  }

  Future<void> _initPlatformState() async {
    width = screenSize!.width;
    height = screenSize!.height;

    three3dRender = FlutterGlPlugin();

    final options = ConfigOptions(
      antialias: true,
      alpha: true,
      width: width.toInt(),
      height: height.toInt(),
      dpr: dpr,
    );

    await three3dRender.initialize(options: options.toMap());

    setState(() {});

    Future.delayed(const Duration(milliseconds: 100), () async {
      await three3dRender.prepareContext();

      await _initScene();
    });
  }

  Future<void> _initScene() async {
    await _initRenderer();
    _scene = three.Scene();
    _camera = three.PerspectiveCamera(45, width / height, 0.1, 1000);
    final orbit = three_jsm.OrbitControls(_camera, _domLikeKey);

    _camera.position.set(190, 140, 140);
    orbit.update();

    ///
    final ambientLight = three.AmbientLight(0x333333);
    _scene.add(ambientLight);

    ///
    final backgroundTextureLoader = three.TextureLoader(null);
    final backgroundTexture = await backgroundTextureLoader.loadAsync(
      textureStars,
    );

    ///
    final sunGeo = three.SphereGeometry(16, 30, 30);
    final sunTextureLoader = three.TextureLoader(null);
    final sunMat = three.MeshBasicMaterial({
      'map': await sunTextureLoader.loadAsync(
        textureSun,
      ),
    });
    _sun = three.Mesh(sunGeo, sunMat);
    _scene.add(_sun);

    _planet = await _planet.initializePlanets(_scene);

    final pointLight = three.PointLight(0xFFFFFFFF, 2, 300);
    _scene
      ..add(pointLight)
      ..background = backgroundTexture;

    ///
    await _planet.animate(
      sun: _sun,
      planet: _planet,
      render: () {
        renderer!.render(_scene, _camera);
      },
    );
  }

  Future<void> _initRenderer() async {
    final options = ConfigOptions(
      antialias: true,
      alpha: true,
      width: width,
      height: height,
      gl: three3dRender.gl,
    );

    renderer = three.WebGLRenderer(
      options.toMap(),
    );
    renderer!.setPixelRatio(dpr);
    renderer!.setSize(width, height);
    renderer!.shadowMap.enabled = true;

    if (!kIsWeb) {
      final pars = three.WebGLRenderTargetOptions({'format': three.RGBAFormat});
      renderTarget = three.WebGLRenderTarget(
        (width * dpr).toInt(),
        (height * dpr).toInt(),
        pars,
      );
      renderTarget!.samples = 4;
      renderer!.setRenderTarget(renderTarget);
      sourceTexture = renderer!.getRenderTargetGLTexture(renderTarget!);
    } else {
      renderTarget = null;
    }
  }
}
