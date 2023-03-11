import 'package:adblocker_webview/src/domain/repository/adblocker_repository.dart';
import 'package:adblocker_webview/src/domain/use_case/fetch_banned_host_use_case.dart';
import 'package:adblocker_webview/src/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:adblocker_webview/adblocker_webview.dart';
import 'package:get_it/get_it.dart';

import 'fakes/fake_adblocker_repository_impl.dart';

void main() {
  Future<void> registerFakes(GetIt getIt) async {
    await getIt.reset();

    getIt
      ..registerFactory<AdBlockerRepository>(
        () => FakeAdBlockerRepositoryImpl(),
      )
      ..registerFactory<FetchBannedHostUseCase>(
        () => FetchBannedHostUseCase(adBlockerRepository: getIt.get()),
      );
  }

  test('Test controller initializes successfully', () async {
    final instance = AdBlockerWebviewController.instance;
    await registerFakes(ServiceLocator.getIt);
    await instance.initialize();
  });
}
