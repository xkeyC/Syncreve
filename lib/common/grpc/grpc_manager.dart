import 'package:grpc/grpc.dart';
import 'package:syncreve/base/base_utils.dart';
import 'package:syncreve/common/channel/app_service_channel.dart';
import 'package:syncreve/common/conf.dart';
import 'package:syncreve/generated/grpc/libsyncreve/protos/ping.pbgrpc.dart';

import 'grpc_conf_tools.dart';

class AppGRPCManager {
  static final channel = ClientChannel(
    'localhost',
    port: 39399,
    options: ChannelOptions(
      credentials: const ChannelCredentials.insecure(),
      codecRegistry:
          CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]),
    ),
  );

  static final pingClient = PingServiceClient(channel);

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
      final result = await pingClient.pingServer(PingRequest(name: "ping"));
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
}
