import 'package:sureline/core/app/app.dart';
import 'package:sureline/core/constants/constants.dart';
import 'package:sureline/features/remote_config/domain/repositories/remote_config_repository.dart';

class PrepareRemoteConfigUseCase {
  final RemoteConfigRepository repository;

  PrepareRemoteConfigUseCase(this.repository);

  Future<void> execute() async {
    final result = await repository.getRemoteConfig();
    result.fold(
      (left) {
        App.remoteConfigEntity = Constants.remoteConfigModel;
      },
      (right) {
        App.remoteConfigEntity = right;
      },
    );
  }
}
