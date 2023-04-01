import 'package:grpc/grpc.dart';

class GRPCChannel {
  final channel = ClientChannel(
    'localhost',
    port: 39399,
    options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
  );
}
