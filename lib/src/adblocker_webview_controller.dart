import 'dart:collection';

import 'domain/use_case/fetch_banned_host_use_case.dart';
import 'package:adblocker_webview/src/service_locator.dart';

import 'domain/entity/host.dart';

/// The controller for [AdBlockerWebviewWidget].
/// Below is and Example of getting a singleton instance:
/// ```dart
///    final _adBlockerWebviewController = AdBlockerWebviewController.instance;
/// ```
/// It's better to warm up the controller before displaying the webview. It's possible to do that by:
/// ```dart
///   @override
///   void initState() {
///     super.initState();
///     _adBlockerWebviewController.initialize();
///     /// ... Other code here.
///   }
/// ```
///
///

///ignore_for_file: avoid-late-keyword
///ignore_for_file: avoid-non-null-assertion
class AdBlockerWebviewController {
  static AdBlockerWebviewController? _instance;

  FetchBannedHostUseCase? _fetchBannedHostUseCase;

  final _bannedHost = <Host>[];

  UnmodifiableListView<Host> get bannedHost =>
      UnmodifiableListView(_bannedHost);

  static AdBlockerWebviewController get instance {
    if (_instance == null) {
      ServiceLocator.configureDependencies();
      _instance = AdBlockerWebviewController._internal();
    }

    return _instance!;
  }

  AdBlockerWebviewController._internal();

  Future<void> initialize() async {
    _fetchBannedHostUseCase = ServiceLocator.get<FetchBannedHostUseCase>();
    final hosts = await _fetchBannedHostUseCase?.execute() ?? [];
    _bannedHost
      ..clear()
      ..addAll(hosts);
  }
}
