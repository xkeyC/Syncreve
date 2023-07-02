import 'dart:io';

import 'package:grpc/grpc.dart';
import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/channel/app_service_channel.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/file_sync.pbgrpc.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/ping.pbgrpc.dart';

import 'grpc_conf_tools.dart';

class AppGRPCManager {
  static final _channel = ClientChannel(
      InternetAddress(AppConf.grpcUnixPath, type: InternetAddressType.unix),
      options: ChannelOptions(
          credentials: const ChannelCredentials.insecure(),
          codecRegistry:
              CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()])));

  static final _pingClient = PingServiceClient(_channel);

  static final _fileSyncClient = FileSyncServiceClient(_channel);

  static bool _isConnected = true;

  static get isConnected => _isConnected;

  static Future<void> init() async {
    await pingServer();
    if (!_isConnected) {
      await AppGRPCConfTools.updateConf();
      await AppServiceChannel.startService(AppConf.grpcConfigFilePath);
    }
  }

  static Future pingServer() async {
    try {
      final result = await _pingClient.pingServer(PingRequest()..name = "ping");
      if (result.pong == "pong") {
        dPrint("[AppGRPCManager] gRPC service Connected");
        _isConnected = true;
        return;
      }
    } catch (e) {
      dPrint("[GRPCManager] pingServer Error: $e");
    }
    _isConnected = false;
  }

  static Future<List<String>> addDownloadTask(
      DownloadTaskRequest request) async {
    final r = await _fileSyncClient.addDownloadTask(request);
    return r.ids;
  }

  static Future<List<String>> addDownloadTasksByDirPath(
      DownloadDirTaskRequest request) async {
    final r = await _fileSyncClient.addDownloadTasksByDirPath(request);
    return r.ids;
  }

  static ResponseStream<DownLoadInfoResult> getDownloadInfoStream(
      DownloadInfoRequest request) {
    return _fileSyncClient.getDownloadInfoStream(request);
  }

  static Future<List<int>> getDownloadInfo(DownloadInfoRequestType type) async {
    final r = await _fileSyncClient
        .getDownloadInfo(DownloadInfoRequest()..type = type);
    return r.data;
  }

  static Future<DownloadCountResult> getDownloadCount() async {
    final r =
        await _fileSyncClient.getDownloadCountInfo(DownloadCountRequest());
    return r;
  }

  static ResponseStream<DownloadCountResult> getDownloadCountStream() {
    return _fileSyncClient.getDownloadCountStream(DownloadCountRequest());
  }

  static Future<String> cancelDownloadTask(String id) async {
    final r = await _fileSyncClient
        .cancelDownloadTask(DownloadTaskCancelRequest()..id = id);
    return r.status;
  }
}
