# bluebillywig

A Flutter plugin to show BlueBillywig videos through their Android and iOS SDK.

# Getting Started

## Add the plugin to pubspec.yaml

At the moment, this plugin is not available through pub.dev.

```
dependencies:
  bluebillywig:
    path: /local/path/to/pubspec.yaml/for/plugin/
```

## Include the plugin in your dart file

```
import 'package:bluebillywig/bluebillywig.dart';
```

## Add like any Flutter widget

The dimensions are calculated based on the provided width argument.

Height of a video is `width * 9 / 16`.

```
BlueBillyWigPlayer(
    jsonUrl: 'https://demo.bbvms.com/p/default_standard/c/2431946.json',
    width: MediaQuery.of(context).size.width, // width of screen
)
```

# example app

In `/example/` a small Flutter example app is provided.


