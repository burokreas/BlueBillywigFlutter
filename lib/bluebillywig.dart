import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class BlueBillyWigPlayer extends StatefulWidget {
  const BlueBillyWigPlayer(
      {required this.jsonUrl,
      required this.width,
      required this.height,
      super.key});

  final String jsonUrl;
  final double width;
  final double height;

  @override
  State<BlueBillyWigPlayer> createState() => _BlueBillyWigPlayerState();
}

class _BlueBillyWigPlayerState extends State<BlueBillyWigPlayer> {
  // This is used in the platform side to register the view.
  static const viewType = '<bbw-video>';
  // static const platform = MethodChannel('com.opacha.autoblog/videoplayer');

  Map<String, dynamic> creationParams = <String, dynamic>{};

  @override
  void initState() {
    super.initState();

    // Pass parameters to the platform side.
    creationParams = <String, dynamic>{
      'url': widget.jsonUrl,
      'height': widget.height,
      'width': widget.width,
    };
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return AndroidBBWWidget(
          height: widget.height,
          viewType: viewType,
          creationParams: creationParams,
        );
      case TargetPlatform.iOS:
        return IOsBBWWidget(
          height: widget.height,
          width: widget.width,
          viewType: viewType,
          creationParams: creationParams,
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
    required this.height,
    required this.viewType,
    required this.creationParams,
    super.key,
  });

  final double height;
  final String viewType;
  final Map<String, dynamic> creationParams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 36),
      child: SizedBox(
        height: height,
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
    required this.height,
    required this.width,
    required this.viewType,
    required this.creationParams,
    super.key,
  });

  final double height;
  final double width;
  final String viewType;
  final Map<String, dynamic> creationParams;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 36),
      child: SizedBox(
        height: height,
        width: width,
        child: UiKitView(
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          // creationParams: creationParams,
          // creationParamsCodec: const StandardMessageCodec(),
        ),
      ),
    );
  }
}
