///
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class DownloadInfoRequestType extends $pb.ProtobufEnum {
  static const DownloadInfoRequestType All = DownloadInfoRequestType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'All');
  static const DownloadInfoRequestType Queue = DownloadInfoRequestType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Queue');
  static const DownloadInfoRequestType Temp = DownloadInfoRequestType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Temp');
  static const DownloadInfoRequestType Sync = DownloadInfoRequestType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'Sync');

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

