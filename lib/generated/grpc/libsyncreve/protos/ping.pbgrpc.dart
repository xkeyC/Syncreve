///
//  Generated code. Do not modify.
//  source: libsyncreve/protos/ping.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'ping.pb.dart' as $1;
export 'ping.pb.dart';

class PingServiceClient extends $grpc.Client {
  static final _$pingServer = $grpc.ClientMethod<$1.PingRequest, $1.PingResult>(
      '/PingService/PingServer',
      ($1.PingRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $1.PingResult.fromBuffer(value));

  PingServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseFuture<$1.PingResult> pingServer($1.PingRequest request,
      {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$pingServer, request, options: options);
  }
}

abstract class PingServiceBase extends $grpc.Service {
  $core.String get $name => 'PingService';

  PingServiceBase() {
    $addMethod($grpc.ServiceMethod<$1.PingRequest, $1.PingResult>(
        'PingServer',
        pingServer_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.PingRequest.fromBuffer(value),
        ($1.PingResult value) => value.writeToBuffer()));
  }

  $async.Future<$1.PingResult> pingServer_Pre(
      $grpc.ServiceCall call, $async.Future<$1.PingRequest> request) async {
    return pingServer(call, await request);
  }

  $async.Future<$1.PingResult> pingServer(
      $grpc.ServiceCall call, $1.PingRequest request);
}
