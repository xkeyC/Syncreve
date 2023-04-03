import 'dart:io';

import 'package:syncreve/common/conf.dart';
import 'package:syncreve/common/utils/yaml_writer.dart';
import 'package:syncreve/data/app/grpc_service_config_data.dart';

class AppGRPCConfTools {
  static Future updateConf() async {
    final conf = AppGrpcServiceConfigData(
      tempDir: AppConf.appTempDir,
      workingDir: AppConf.appWorkingDir,
    );
    final yamlWriter = YamlWriter();
    final yamlString = yamlWriter.write(conf.toJson());
    File file = File(AppConf.grpcConfigFilePath);
    if (await file.exists()) {
      await file.delete(recursive: true);
    }
    await file.create(recursive: true);
    await file.writeAsString(yamlString);
  }
}
