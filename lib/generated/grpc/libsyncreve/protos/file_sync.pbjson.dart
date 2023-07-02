//
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use downloadInfoRequestTypeDescriptor instead')
const DownloadInfoRequestType$json = {
  '1': 'DownloadInfoRequestType',
  '2': [
    {'1': 'All', '2': 0},
    {'1': 'Queue', '2': 1},
    {'1': 'Temp', '2': 2},
    {'1': 'Sync', '2': 3},
  ],
};

/// Descriptor for `DownloadInfoRequestType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List downloadInfoRequestTypeDescriptor = $convert.base64Decode(
    'ChdEb3dubG9hZEluZm9SZXF1ZXN0VHlwZRIHCgNBbGwQABIJCgVRdWV1ZRABEggKBFRlbXAQAh'
    'IICgRTeW5jEAM=');

@$core.Deprecated('Use downloadTaskRequestDescriptor instead')
const DownloadTaskRequest$json = {
  '1': 'DownloadTaskRequest',
  '2': [
    {'1': 'workingUrl', '3': 1, '4': 1, '5': 9, '10': 'workingUrl'},
    {'1': 'instanceUrl', '3': 2, '4': 1, '5': 9, '10': 'instanceUrl'},
    {'1': 'fileInfos', '3': 3, '4': 3, '5': 11, '6': '.DownloadTaskRequestFileInfo', '10': 'fileInfos'},
    {'1': 'savePath', '3': 4, '4': 1, '5': 9, '10': 'savePath'},
    {'1': 'cookie', '3': 5, '4': 1, '5': 9, '10': 'cookie'},
    {'1': 'downLoadType', '3': 6, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'downLoadType'},
  ],
};

/// Descriptor for `DownloadTaskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskRequestDescriptor = $convert.base64Decode(
    'ChNEb3dubG9hZFRhc2tSZXF1ZXN0Eh4KCndvcmtpbmdVcmwYASABKAlSCndvcmtpbmdVcmwSIA'
    'oLaW5zdGFuY2VVcmwYAiABKAlSC2luc3RhbmNlVXJsEjoKCWZpbGVJbmZvcxgDIAMoCzIcLkRv'
    'd25sb2FkVGFza1JlcXVlc3RGaWxlSW5mb1IJZmlsZUluZm9zEhoKCHNhdmVQYXRoGAQgASgJUg'
    'hzYXZlUGF0aBIWCgZjb29raWUYBSABKAlSBmNvb2tpZRI8Cgxkb3duTG9hZFR5cGUYBiABKA4y'
    'GC5Eb3dubG9hZEluZm9SZXF1ZXN0VHlwZVIMZG93bkxvYWRUeXBl');

@$core.Deprecated('Use downloadTaskRequestFileInfoDescriptor instead')
const DownloadTaskRequestFileInfo$json = {
  '1': 'DownloadTaskRequestFileInfo',
  '2': [
    {'1': 'fileID', '3': 1, '4': 1, '5': 9, '10': 'fileID'},
    {'1': 'fileName', '3': 2, '4': 1, '5': 9, '10': 'fileName'},
  ],
};

/// Descriptor for `DownloadTaskRequestFileInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskRequestFileInfoDescriptor = $convert.base64Decode(
    'ChtEb3dubG9hZFRhc2tSZXF1ZXN0RmlsZUluZm8SFgoGZmlsZUlEGAEgASgJUgZmaWxlSUQSGg'
    'oIZmlsZU5hbWUYAiABKAlSCGZpbGVOYW1l');

@$core.Deprecated('Use downloadDirTaskRequestDescriptor instead')
const DownloadDirTaskRequest$json = {
  '1': 'DownloadDirTaskRequest',
  '2': [
    {'1': 'workingUrl', '3': 1, '4': 1, '5': 9, '10': 'workingUrl'},
    {'1': 'instanceUrl', '3': 2, '4': 1, '5': 9, '10': 'instanceUrl'},
    {'1': 'dirPath', '3': 3, '4': 1, '5': 9, '10': 'dirPath'},
    {'1': 'savePath', '3': 4, '4': 1, '5': 9, '10': 'savePath'},
    {'1': 'cookie', '3': 5, '4': 1, '5': 9, '10': 'cookie'},
    {'1': 'downLoadType', '3': 6, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'downLoadType'},
  ],
};

/// Descriptor for `DownloadDirTaskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadDirTaskRequestDescriptor = $convert.base64Decode(
    'ChZEb3dubG9hZERpclRhc2tSZXF1ZXN0Eh4KCndvcmtpbmdVcmwYASABKAlSCndvcmtpbmdVcm'
    'wSIAoLaW5zdGFuY2VVcmwYAiABKAlSC2luc3RhbmNlVXJsEhgKB2RpclBhdGgYAyABKAlSB2Rp'
    'clBhdGgSGgoIc2F2ZVBhdGgYBCABKAlSCHNhdmVQYXRoEhYKBmNvb2tpZRgFIAEoCVIGY29va2'
    'llEjwKDGRvd25Mb2FkVHlwZRgGIAEoDjIYLkRvd25sb2FkSW5mb1JlcXVlc3RUeXBlUgxkb3du'
    'TG9hZFR5cGU=');

@$core.Deprecated('Use downloadTaskResultDescriptor instead')
const DownloadTaskResult$json = {
  '1': 'DownloadTaskResult',
  '2': [
    {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
  ],
};

/// Descriptor for `DownloadTaskResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskResultDescriptor = $convert.base64Decode(
    'ChJEb3dubG9hZFRhc2tSZXN1bHQSEAoDaWRzGAEgAygJUgNpZHM=');

@$core.Deprecated('Use downloadTaskCancelRequestDescriptor instead')
const DownloadTaskCancelRequest$json = {
  '1': 'DownloadTaskCancelRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DownloadTaskCancelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskCancelRequestDescriptor = $convert.base64Decode(
    'ChlEb3dubG9hZFRhc2tDYW5jZWxSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');

@$core.Deprecated('Use downloadTaskCancelResultDescriptor instead')
const DownloadTaskCancelResult$json = {
  '1': 'DownloadTaskCancelResult',
  '2': [
    {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DownloadTaskCancelResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskCancelResultDescriptor = $convert.base64Decode(
    'ChhEb3dubG9hZFRhc2tDYW5jZWxSZXN1bHQSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');

@$core.Deprecated('Use downloadInfoRequestDescriptor instead')
const DownloadInfoRequest$json = {
  '1': 'DownloadInfoRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    {'1': 'updateTime', '3': 2, '4': 1, '5': 3, '9': 1, '10': 'updateTime', '17': true},
    {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'type'},
  ],
  '8': [
    {'1': '_id'},
    {'1': '_updateTime'},
  ],
};

/// Descriptor for `DownloadInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadInfoRequestDescriptor = $convert.base64Decode(
    'ChNEb3dubG9hZEluZm9SZXF1ZXN0EhMKAmlkGAEgASgJSABSAmlkiAEBEiMKCnVwZGF0ZVRpbW'
    'UYAiABKANIAVIKdXBkYXRlVGltZYgBARIsCgR0eXBlGAMgASgOMhguRG93bmxvYWRJbmZvUmVx'
    'dWVzdFR5cGVSBHR5cGVCBQoDX2lkQg0KC191cGRhdGVUaW1l');

@$core.Deprecated('Use downLoadInfoResultDescriptor instead')
const DownLoadInfoResult$json = {
  '1': 'DownLoadInfoResult',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'type'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `DownLoadInfoResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downLoadInfoResultDescriptor = $convert.base64Decode(
    'ChJEb3duTG9hZEluZm9SZXN1bHQSLAoEdHlwZRgBIAEoDjIYLkRvd25sb2FkSW5mb1JlcXVlc3'
    'RUeXBlUgR0eXBlEhIKBGRhdGEYAiABKAxSBGRhdGE=');

@$core.Deprecated('Use downloadCountRequestDescriptor instead')
const DownloadCountRequest$json = {
  '1': 'DownloadCountRequest',
};

/// Descriptor for `DownloadCountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadCountRequestDescriptor = $convert.base64Decode(
    'ChREb3dubG9hZENvdW50UmVxdWVzdA==');

@$core.Deprecated('Use downloadCountResultDescriptor instead')
const DownloadCountResult$json = {
  '1': 'DownloadCountResult',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'type'},
    {'1': 'workingCount', '3': 2, '4': 1, '5': 3, '10': 'workingCount'},
    {'1': 'Count', '3': 3, '4': 1, '5': 3, '10': 'Count'},
  ],
};

/// Descriptor for `DownloadCountResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadCountResultDescriptor = $convert.base64Decode(
    'ChNEb3dubG9hZENvdW50UmVzdWx0EiwKBHR5cGUYASABKA4yGC5Eb3dubG9hZEluZm9SZXF1ZX'
    'N0VHlwZVIEdHlwZRIiCgx3b3JraW5nQ291bnQYAiABKANSDHdvcmtpbmdDb3VudBIUCgVDb3Vu'
    'dBgDIAEoA1IFQ291bnQ=');

