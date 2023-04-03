import 'package:path_provider/path_provider.dart';

class AppConf {
  static String _appWorkingDir = "";
  static String _appTempDir = "";

  static String? tempSession;

  static String get appWorkingDir => _appWorkingDir;

  static String get grpcUnixPath => "$appWorkingDir/syncreve_grpc.sock";

  static String get appTempDir => _appTempDir;

  static String get grpcConfigFilePath =>
      "${AppConf.appWorkingDir}/grpc_conf.yaml";

  static Future init() async {
    _appWorkingDir = (await getApplicationDocumentsDirectory()).absolute.path;
    _appTempDir = (await getTemporaryDirectory()).absolute.path;
  }
}
