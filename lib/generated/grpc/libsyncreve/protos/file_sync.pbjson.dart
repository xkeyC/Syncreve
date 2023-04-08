///
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use downloadInfoRequestTypeDescriptor instead')
const DownloadInfoRequestType$json = const {
  '1': 'DownloadInfoRequestType',
  '2': const [
    const {'1': 'All', '2': 0},
    const {'1': 'Queue', '2': 1},
    const {'1': 'Temp', '2': 2},
    const {'1': 'Sync', '2': 3},
  ],
};

/// Descriptor for `DownloadInfoRequestType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List downloadInfoRequestTypeDescriptor = $convert.base64Decode('ChdEb3dubG9hZEluZm9SZXF1ZXN0VHlwZRIHCgNBbGwQABIJCgVRdWV1ZRABEggKBFRlbXAQAhIICgRTeW5jEAM=');
@$core.Deprecated('Use downloadTaskRequestDescriptor instead')
const DownloadTaskRequest$json = const {
  '1': 'DownloadTaskRequest',
  '2': const [
    const {'1': 'workingUrl', '3': 1, '4': 1, '5': 9, '10': 'workingUrl'},
    const {'1': 'instanceUrl', '3': 2, '4': 1, '5': 9, '10': 'instanceUrl'},
    const {'1': 'fileID', '3': 3, '4': 3, '5': 9, '10': 'fileID'},
    const {'1': 'savePath', '3': 4, '4': 1, '5': 9, '10': 'savePath'},
    const {'1': 'fileName', '3': 5, '4': 1, '5': 9, '10': 'fileName'},
    const {'1': 'cookie', '3': 6, '4': 1, '5': 9, '10': 'cookie'},
    const {'1': 'downLoadType', '3': 7, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'downLoadType'},
  ],
};

/// Descriptor for `DownloadTaskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskRequestDescriptor = $convert.base64Decode('ChNEb3dubG9hZFRhc2tSZXF1ZXN0Eh4KCndvcmtpbmdVcmwYASABKAlSCndvcmtpbmdVcmwSIAoLaW5zdGFuY2VVcmwYAiABKAlSC2luc3RhbmNlVXJsEhYKBmZpbGVJRBgDIAMoCVIGZmlsZUlEEhoKCHNhdmVQYXRoGAQgASgJUghzYXZlUGF0aBIaCghmaWxlTmFtZRgFIAEoCVIIZmlsZU5hbWUSFgoGY29va2llGAYgASgJUgZjb29raWUSPAoMZG93bkxvYWRUeXBlGAcgASgOMhguRG93bmxvYWRJbmZvUmVxdWVzdFR5cGVSDGRvd25Mb2FkVHlwZQ==');
@$core.Deprecated('Use downloadDirTaskRequestDescriptor instead')
const DownloadDirTaskRequest$json = const {
  '1': 'DownloadDirTaskRequest',
  '2': const [
    const {'1': 'workingUrl', '3': 1, '4': 1, '5': 9, '10': 'workingUrl'},
    const {'1': 'instanceUrl', '3': 2, '4': 1, '5': 9, '10': 'instanceUrl'},
    const {'1': 'dirPath', '3': 3, '4': 1, '5': 9, '10': 'dirPath'},
    const {'1': 'savePath', '3': 4, '4': 1, '5': 9, '10': 'savePath'},
    const {'1': 'cookie', '3': 5, '4': 1, '5': 9, '10': 'cookie'},
    const {'1': 'downLoadType', '3': 6, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'downLoadType'},
  ],
};

/// Descriptor for `DownloadDirTaskRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadDirTaskRequestDescriptor = $convert.base64Decode('ChZEb3dubG9hZERpclRhc2tSZXF1ZXN0Eh4KCndvcmtpbmdVcmwYASABKAlSCndvcmtpbmdVcmwSIAoLaW5zdGFuY2VVcmwYAiABKAlSC2luc3RhbmNlVXJsEhgKB2RpclBhdGgYAyABKAlSB2RpclBhdGgSGgoIc2F2ZVBhdGgYBCABKAlSCHNhdmVQYXRoEhYKBmNvb2tpZRgFIAEoCVIGY29va2llEjwKDGRvd25Mb2FkVHlwZRgGIAEoDjIYLkRvd25sb2FkSW5mb1JlcXVlc3RUeXBlUgxkb3duTG9hZFR5cGU=');
@$core.Deprecated('Use downloadTaskResultDescriptor instead')
const DownloadTaskResult$json = const {
  '1': 'DownloadTaskResult',
  '2': const [
    const {'1': 'ids', '3': 1, '4': 3, '5': 9, '10': 'ids'},
  ],
};

/// Descriptor for `DownloadTaskResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskResultDescriptor = $convert.base64Decode('ChJEb3dubG9hZFRhc2tSZXN1bHQSEAoDaWRzGAEgAygJUgNpZHM=');
@$core.Deprecated('Use downloadTaskCancelRequestDescriptor instead')
const DownloadTaskCancelRequest$json = const {
  '1': 'DownloadTaskCancelRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
  ],
};

/// Descriptor for `DownloadTaskCancelRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskCancelRequestDescriptor = $convert.base64Decode('ChlEb3dubG9hZFRhc2tDYW5jZWxSZXF1ZXN0Eg4KAmlkGAEgASgJUgJpZA==');
@$core.Deprecated('Use downloadTaskCancelResultDescriptor instead')
const DownloadTaskCancelResult$json = const {
  '1': 'DownloadTaskCancelResult',
  '2': const [
    const {'1': 'status', '3': 1, '4': 1, '5': 9, '10': 'status'},
  ],
};

/// Descriptor for `DownloadTaskCancelResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadTaskCancelResultDescriptor = $convert.base64Decode('ChhEb3dubG9hZFRhc2tDYW5jZWxSZXN1bHQSFgoGc3RhdHVzGAEgASgJUgZzdGF0dXM=');
@$core.Deprecated('Use downloadInfoRequestDescriptor instead')
const DownloadInfoRequest$json = const {
  '1': 'DownloadInfoRequest',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '9': 0, '10': 'id', '17': true},
    const {'1': 'updateTime', '3': 2, '4': 1, '5': 3, '9': 1, '10': 'updateTime', '17': true},
    const {'1': 'type', '3': 3, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'type'},
  ],
  '8': const [
    const {'1': '_id'},
    const {'1': '_updateTime'},
  ],
};

/// Descriptor for `DownloadInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downloadInfoRequestDescriptor = $convert.base64Decode('ChNEb3dubG9hZEluZm9SZXF1ZXN0EhMKAmlkGAEgASgJSABSAmlkiAEBEiMKCnVwZGF0ZVRpbWUYAiABKANIAVIKdXBkYXRlVGltZYgBARIsCgR0eXBlGAMgASgOMhguRG93bmxvYWRJbmZvUmVxdWVzdFR5cGVSBHR5cGVCBQoDX2lkQg0KC191cGRhdGVUaW1l');
@$core.Deprecated('Use downLoadInfoResultDescriptor instead')
const DownLoadInfoResult$json = const {
  '1': 'DownLoadInfoResult',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.DownloadInfoRequestType', '10': 'type'},
    const {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
  ],
};

/// Descriptor for `DownLoadInfoResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List downLoadInfoResultDescriptor = $convert.base64Decode('ChJEb3duTG9hZEluZm9SZXN1bHQSLAoEdHlwZRgBIAEoDjIYLkRvd25sb2FkSW5mb1JlcXVlc3RUeXBlUgR0eXBlEhIKBGRhdGEYAiABKAxSBGRhdGE=');
