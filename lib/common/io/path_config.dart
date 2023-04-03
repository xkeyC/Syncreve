import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/channel/app_service_channel.dart';
import 'package:syncreve/common/conf.dart';

class AppPathConfig {
  static String _tempDownloadPath = "";
  static String _userDownloadPath = "";

  static String get tempDownloadPath => _tempDownloadPath;

  static String get userDownloadPath => _userDownloadPath;

  static Future init() {
    if (Platform.isAndroid) {
      return _initAndroid();
    }
    throw "Need PathConfig";
  }

  static Future _initAndroid() async {
    final cachePaths = await getExternalCacheDirectories();
    final downloadPath = await AppServiceChannel.getDownloadDir();

    if (cachePaths == null || cachePaths.isEmpty) {
      _tempDownloadPath = "${AppConf.appTempDir}/syncreve_temp_files";
    } else {
      _tempDownloadPath =
          "${cachePaths.first.absolute.path}/syncreve_temp_files";
    }
    _userDownloadPath = "$downloadPath/Syncreve";
    _printPath();
  }

  static _printPath() {
    dPrint("[AppPathConfig] _tempDownloadPath == $_tempDownloadPath");
    dPrint("[AppPathConfig] _userDownloadPath == $_userDownloadPath");
  }

  static Future<bool> checkPathPermissions(String path) async {
    if (Platform.isAndroid) {
      return _checkPathPermissionsAndroid(path);
    }
    return true;
  }

  static Future<bool> _checkPathPermissionsAndroid(String path) async {
    return AppServiceChannel.checkPathPermissions(path);
  }
}
