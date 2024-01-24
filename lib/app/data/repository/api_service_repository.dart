import 'package:app_bloc_flutter/app/data/adapters/repository_adapter.dart';
import 'package:app_bloc_flutter/app/data/provider/rest.dart';

class ApiServiceRepository implements IApiDeviceRepository {
  final RestAPIClient _restAPIClient;

  ApiServiceRepository(this._restAPIClient);

  log() {
    // ignore: avoid_print
    print(_restAPIClient);
  }
}
