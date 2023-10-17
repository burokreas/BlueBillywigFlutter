import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class BlueBillyWigPlayer extends StatefulWidget {
  const BlueBillyWigPlayer(
      {required this.jsonUrl, required this.width, super.key});

  final String jsonUrl;
  final double width;

  static const aspectRatio = 9 / 16;

  @override
  State<BlueBillyWigPlayer> createState() => _BlueBillyWigPlayerState();
}

class _BlueBillyWigPlayerState extends State<BlueBillyWigPlayer> {
  // This is used in the platform side to register the view.
  static const viewType = 'com.bluebillywig.player/view';
  static const platform = MethodChannel('com.bluebillywig.player/channel');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void pauseVideo() async {
    try {
      await platform.invokeMethod('pauseVideo');
    } on PlatformException catch (e) {
      debugPrint('Could not pause video: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidBBWWidget(
          aspectRatio: BlueBillyWigPlayer.aspectRatio,
          width: widget.width,
          viewType: viewType,
          jsonUrl: widget.jsonUrl,
        );
      case TargetPlatform.iOS:
        return IOsBBWWidget(
          width: widget.width,
          viewType: viewType,
          aspectRatio: BlueBillyWigPlayer.aspectRatio,
          jsonUrl: widget.jsonUrl,
        );
      case TargetPlatform.fuchsia:
        return const Text('Videoplayer not supported on Fuchsia.');
      case TargetPlatform.linux:
        return const Text('Videoplayer not supported on Linux.');
      case TargetPlatform.macOS:
        return const Text('Videoplayer not supported on macOS.');
      case TargetPlatform.windows:
        return const Text('Videoplayer not supported on Windows.');
    }
  }
}

class AndroidBBWWidget extends StatelessWidget {
  const AndroidBBWWidget({
    required this.aspectRatio,
    required this.jsonUrl,
    required this.viewType,
    required this.width,
    super.key,
  });

  final double aspectRatio;
  final double width;
  final String jsonUrl;
  final String viewType;

  @override
  Widget build(BuildContext context) {
    // TODO why does Android need dpr multiplication?
    final d = MediaQuery.of(context).devicePixelRatio;
    final w = width * d;

    // Pass parameters to the platform side.
    final creationParams = <String, dynamic>{
      'url': jsonUrl,
      'height': w * aspectRatio,
      'width': w,
    };

    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 36),
      child: SizedBox(
        height: width * aspectRatio,
        child: PlatformViewLink(
          viewType: viewType,
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: viewType,
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        ),
      ),
    );
  }
}

class IOsBBWWidget extends StatelessWidget {
  const IOsBBWWidget({
    required this.aspectRatio,
    required this.jsonUrl,
    required this.viewType,
    required this.width,
    super.key,
  });

  final double aspectRatio;
  final double width;
  final String jsonUrl;
  final String viewType;

  @override
  Widget build(BuildContext context) {
    final creationParams = <String, dynamic>{
      'url': jsonUrl,
      'height': width * aspectRatio,
      'width': width,
    };

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 36),
      child: SizedBox(
        height: width * aspectRatio,
        width: width,
        child: UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}
