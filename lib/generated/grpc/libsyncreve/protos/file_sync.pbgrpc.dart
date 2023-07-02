//
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'file_sync.pb.dart' as $0;

export 'file_sync.pb.dart';

@$pb.GrpcServiceName('FileSyncService')
class FileSyncServiceClient extends $grpc.Client {
  static final _$addDownloadTask = $grpc.ClientMethod<$0.DownloadTaskRequest, $0.DownloadTaskResult>(
      '/FileSyncService/AddDownloadTask',
      ($0.DownloadTaskRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadTaskResult.fromBuffer(value));
  static final _$addDownloadTasksByDirPath = $grpc.ClientMethod<$0.DownloadDirTaskRequest, $0.DownloadTaskResult>(
      '/FileSyncService/AddDownloadTasksByDirPath',
      ($0.DownloadDirTaskRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadTaskResult.fromBuffer(value));
  static final _$cancelDownloadTask = $grpc.ClientMethod<$0.DownloadTaskCancelRequest, $0.DownloadTaskCancelResult>(
      '/FileSyncService/CancelDownloadTask',
      ($0.DownloadTaskCancelRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadTaskCancelResult.fromBuffer(value));
  static final _$getDownloadInfoStream = $grpc.ClientMethod<$0.DownloadInfoRequest, $0.DownLoadInfoResult>(
      '/FileSyncService/GetDownloadInfoStream',
      ($0.DownloadInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownLoadInfoResult.fromBuffer(value));
  static final _$getDownloadInfo = $grpc.ClientMethod<$0.DownloadInfoRequest, $0.DownLoadInfoResult>(
      '/FileSyncService/GetDownloadInfo',
      ($0.DownloadInfoRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownLoadInfoResult.fromBuffer(value));
  static final _$getDownloadCountInfo = $grpc.ClientMethod<$0.DownloadCountRequest, $0.DownloadCountResult>(
      '/FileSyncService/GetDownloadCountInfo',
      ($0.DownloadCountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadCountResult.fromBuffer(value));
  static final _$getDownloadCountStream = $grpc.ClientMethod<$0.DownloadCountRequest, $0.DownloadCountResult>(
      '/FileSyncService/GetDownloadCountStream',
      ($0.DownloadCountRequest value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.DownloadCountResult.fromBuffer(value));

  FileSyncServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.DownloadTaskResult> addDownloadTask($0.DownloadTaskRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addDownloadTask, request, options: options);
  }

  $grpc.ResponseFuture<$0.DownloadTaskResult> addDownloadTasksByDirPath($0.DownloadDirTaskRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addDownloadTasksByDirPath, request, options: options);
  }

  $grpc.ResponseFuture<$0.DownloadTaskCancelResult> cancelDownloadTask($0.DownloadTaskCancelRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$cancelDownloadTask, request, options: options);
  }

  $grpc.ResponseStream<$0.DownLoadInfoResult> getDownloadInfoStream($0.DownloadInfoRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getDownloadInfoStream, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.DownLoadInfoResult> getDownloadInfo($0.DownloadInfoRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDownloadInfo, request, options: options);
  }

  $grpc.ResponseFuture<$0.DownloadCountResult> getDownloadCountInfo($0.DownloadCountRequest request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getDownloadCountInfo, request, options: options);
  }

  $grpc.ResponseStream<$0.DownloadCountResult> getDownloadCountStream($0.DownloadCountRequest request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getDownloadCountStream, $async.Stream.fromIterable([request]), options: options);
  }
}

@$pb.GrpcServiceName('FileSyncService')
abstract class FileSyncServiceBase extends $grpc.Service {
  $core.String get $name => 'FileSyncService';

  FileSyncServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.DownloadTaskRequest, $0.DownloadTaskResult>(
        'AddDownloadTask',
        addDownloadTask_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DownloadTaskRequest.fromBuffer(value),
        ($0.DownloadTaskResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadDirTaskRequest, $0.DownloadTaskResult>(
        'AddDownloadTasksByDirPath',
        addDownloadTasksByDirPath_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DownloadDirTaskRequest.fromBuffer(value),
        ($0.DownloadTaskResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadTaskCancelRequest, $0.DownloadTaskCancelResult>(
        'CancelDownloadTask',
        cancelDownloadTask_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DownloadTaskCancelRequest.fromBuffer(value),
        ($0.DownloadTaskCancelResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadInfoRequest, $0.DownLoadInfoResult>(
        'GetDownloadInfoStream',
        getDownloadInfoStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.DownloadInfoRequest.fromBuffer(value),
        ($0.DownLoadInfoResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadInfoRequest, $0.DownLoadInfoResult>(
        'GetDownloadInfo',
        getDownloadInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DownloadInfoRequest.fromBuffer(value),
        ($0.DownLoadInfoResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadCountRequest, $0.DownloadCountResult>(
        'GetDownloadCountInfo',
        getDownloadCountInfo_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.DownloadCountRequest.fromBuffer(value),
        ($0.DownloadCountResult value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.DownloadCountRequest, $0.DownloadCountResult>(
        'GetDownloadCountStream',
        getDownloadCountStream_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.DownloadCountRequest.fromBuffer(value),
        ($0.DownloadCountResult value) => value.writeToBuffer()));
  }

  $async.Future<$0.DownloadTaskResult> addDownloadTask_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadTaskRequest> request) async {
    return addDownloadTask(call, await request);
  }

  $async.Future<$0.DownloadTaskResult> addDownloadTasksByDirPath_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadDirTaskRequest> request) async {
    return addDownloadTasksByDirPath(call, await request);
  }

  $async.Future<$0.DownloadTaskCancelResult> cancelDownloadTask_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadTaskCancelRequest> request) async {
    return cancelDownloadTask(call, await request);
  }

  $async.Stream<$0.DownLoadInfoResult> getDownloadInfoStream_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadInfoRequest> request) async* {
    yield* getDownloadInfoStream(call, await request);
  }

  $async.Future<$0.DownLoadInfoResult> getDownloadInfo_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadInfoRequest> request) async {
    return getDownloadInfo(call, await request);
  }

  $async.Future<$0.DownloadCountResult> getDownloadCountInfo_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadCountRequest> request) async {
    return getDownloadCountInfo(call, await request);
  }

  $async.Stream<$0.DownloadCountResult> getDownloadCountStream_Pre($grpc.ServiceCall call, $async.Future<$0.DownloadCountRequest> request) async* {
    yield* getDownloadCountStream(call, await request);
  }

  $async.Future<$0.DownloadTaskResult> addDownloadTask($grpc.ServiceCall call, $0.DownloadTaskRequest request);
  $async.Future<$0.DownloadTaskResult> addDownloadTasksByDirPath($grpc.ServiceCall call, $0.DownloadDirTaskRequest request);
  $async.Future<$0.DownloadTaskCancelResult> cancelDownloadTask($grpc.ServiceCall call, $0.DownloadTaskCancelRequest request);
  $async.Stream<$0.DownLoadInfoResult> getDownloadInfoStream($grpc.ServiceCall call, $0.DownloadInfoRequest request);
  $async.Future<$0.DownLoadInfoResult> getDownloadInfo($grpc.ServiceCall call, $0.DownloadInfoRequest request);
  $async.Future<$0.DownloadCountResult> getDownloadCountInfo($grpc.ServiceCall call, $0.DownloadCountRequest request);
  $async.Stream<$0.DownloadCountResult> getDownloadCountStream($grpc.ServiceCall call, $0.DownloadCountRequest request);
}
