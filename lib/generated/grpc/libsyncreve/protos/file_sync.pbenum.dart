//
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class DownloadInfoRequestType extends $pb.ProtobufEnum {
  static const DownloadInfoRequestType All = DownloadInfoRequestType._(0, _omitEnumNames ? '' : 'All');
  static const DownloadInfoRequestType Queue = DownloadInfoRequestType._(1, _omitEnumNames ? '' : 'Queue');
  static const DownloadInfoRequestType Temp = DownloadInfoRequestType._(2, _omitEnumNames ? '' : 'Temp');
  static const DownloadInfoRequestType Sync = DownloadInfoRequestType._(3, _omitEnumNames ? '' : 'Sync');

  static const $core.List<DownloadInfoRequestType> values = <DownloadInfoRequestType> [
    All,
    Queue,
    Temp,
    Sync,
  ];

  static final $core.Map<$core.int, DownloadInfoRequestType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DownloadInfoRequestType? valueOf($core.int value) => _byValue[value];

  const DownloadInfoRequestType._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
