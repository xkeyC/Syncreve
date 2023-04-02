///
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'file_sync.pbenum.dart';

export 'file_sync.pbenum.dart';

class DownloadTaskRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadTaskRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'url')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savePath', protoName: 'savePath')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileName', protoName: 'fileName')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cookie')
    ..e<DownloadInfoRequestType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'downLoadType', $pb.PbFieldType.OE, protoName: 'downLoadType', defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false
  ;

  DownloadTaskRequest._() : super();
  factory DownloadTaskRequest({
    $core.String? url,
    $core.String? savePath,
    $core.String? fileName,
    $core.String? cookie,
    DownloadInfoRequestType? downLoadType,
  }) {
    final _result = create();
    if (url != null) {
      _result.url = url;
    }
    if (savePath != null) {
      _result.savePath = savePath;
    }
    if (fileName != null) {
      _result.fileName = fileName;
    }
    if (cookie != null) {
      _result.cookie = cookie;
    }
    if (downLoadType != null) {
      _result.downLoadType = downLoadType;
    }
    return _result;
  }
  factory DownloadTaskRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadTaskRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadTaskRequest clone() => DownloadTaskRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadTaskRequest copyWith(void Function(DownloadTaskRequest) updates) => super.copyWith((message) => updates(message as DownloadTaskRequest)) as DownloadTaskRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequest create() => DownloadTaskRequest._();
  DownloadTaskRequest createEmptyInstance() => create();
  static $pb.PbList<DownloadTaskRequest> createRepeated() => $pb.PbList<DownloadTaskRequest>();
  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadTaskRequest>(create);
  static DownloadTaskRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get savePath => $_getSZ(1);
  @$pb.TagNumber(2)
  set savePath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSavePath() => $_has(1);
  @$pb.TagNumber(2)
  void clearSavePath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fileName => $_getSZ(2);
  @$pb.TagNumber(3)
  set fileName($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFileName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFileName() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get cookie => $_getSZ(3);
  @$pb.TagNumber(4)
  set cookie($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasCookie() => $_has(3);
  @$pb.TagNumber(4)
  void clearCookie() => clearField(4);

  @$pb.TagNumber(5)
  DownloadInfoRequestType get downLoadType => $_getN(4);
  @$pb.TagNumber(5)
  set downLoadType(DownloadInfoRequestType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasDownLoadType() => $_has(4);
  @$pb.TagNumber(5)
  void clearDownLoadType() => clearField(5);
}

class DownloadTaskResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadTaskResult', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DownloadTaskResult._() : super();
  factory DownloadTaskResult({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DownloadTaskResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadTaskResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadTaskResult clone() => DownloadTaskResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadTaskResult copyWith(void Function(DownloadTaskResult) updates) => super.copyWith((message) => updates(message as DownloadTaskResult)) as DownloadTaskResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadTaskResult create() => DownloadTaskResult._();
  DownloadTaskResult createEmptyInstance() => create();
  static $pb.PbList<DownloadTaskResult> createRepeated() => $pb.PbList<DownloadTaskResult>();
  @$core.pragma('dart2js:noInline')
  static DownloadTaskResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadTaskResult>(create);
  static DownloadTaskResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DownloadTaskCancelRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadTaskCancelRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..hasRequiredFields = false
  ;

  DownloadTaskCancelRequest._() : super();
  factory DownloadTaskCancelRequest({
    $core.String? id,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    return _result;
  }
  factory DownloadTaskCancelRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadTaskCancelRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadTaskCancelRequest clone() => DownloadTaskCancelRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadTaskCancelRequest copyWith(void Function(DownloadTaskCancelRequest) updates) => super.copyWith((message) => updates(message as DownloadTaskCancelRequest)) as DownloadTaskCancelRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelRequest create() => DownloadTaskCancelRequest._();
  DownloadTaskCancelRequest createEmptyInstance() => create();
  static $pb.PbList<DownloadTaskCancelRequest> createRepeated() => $pb.PbList<DownloadTaskCancelRequest>();
  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadTaskCancelRequest>(create);
  static DownloadTaskCancelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DownloadTaskCancelResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadTaskCancelResult', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status')
    ..hasRequiredFields = false
  ;

  DownloadTaskCancelResult._() : super();
  factory DownloadTaskCancelResult({
    $core.String? status,
  }) {
    final _result = create();
    if (status != null) {
      _result.status = status;
    }
    return _result;
  }
  factory DownloadTaskCancelResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadTaskCancelResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadTaskCancelResult clone() => DownloadTaskCancelResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadTaskCancelResult copyWith(void Function(DownloadTaskCancelResult) updates) => super.copyWith((message) => updates(message as DownloadTaskCancelResult)) as DownloadTaskCancelResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelResult create() => DownloadTaskCancelResult._();
  DownloadTaskCancelResult createEmptyInstance() => create();
  static $pb.PbList<DownloadTaskCancelResult> createRepeated() => $pb.PbList<DownloadTaskCancelResult>();
  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadTaskCancelResult>(create);
  static DownloadTaskCancelResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);
  @$pb.TagNumber(1)
  set status($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);
  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class DownloadInfoRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadInfoRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<DownloadInfoRequestType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false
  ;

  DownloadInfoRequest._() : super();
  factory DownloadInfoRequest({
    $core.String? id,
    DownloadInfoRequestType? type,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory DownloadInfoRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadInfoRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadInfoRequest clone() => DownloadInfoRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadInfoRequest copyWith(void Function(DownloadInfoRequest) updates) => super.copyWith((message) => updates(message as DownloadInfoRequest)) as DownloadInfoRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadInfoRequest create() => DownloadInfoRequest._();
  DownloadInfoRequest createEmptyInstance() => create();
  static $pb.PbList<DownloadInfoRequest> createRepeated() => $pb.PbList<DownloadInfoRequest>();
  @$core.pragma('dart2js:noInline')
  static DownloadInfoRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadInfoRequest>(create);
  static DownloadInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  DownloadInfoRequestType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(DownloadInfoRequestType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class DownLoadInfoResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownLoadInfoResult', createEmptyInstance: create)
    ..e<DownloadInfoRequestType>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..a<$core.List<$core.int>>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  DownLoadInfoResult._() : super();
  factory DownLoadInfoResult({
    DownloadInfoRequestType? type,
    $core.List<$core.int>? data,
  }) {
    final _result = create();
    if (type != null) {
      _result.type = type;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory DownLoadInfoResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownLoadInfoResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownLoadInfoResult clone() => DownLoadInfoResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownLoadInfoResult copyWith(void Function(DownLoadInfoResult) updates) => super.copyWith((message) => updates(message as DownLoadInfoResult)) as DownLoadInfoResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownLoadInfoResult create() => DownLoadInfoResult._();
  DownLoadInfoResult createEmptyInstance() => create();
  static $pb.PbList<DownLoadInfoResult> createRepeated() => $pb.PbList<DownLoadInfoResult>();
  @$core.pragma('dart2js:noInline')
  static DownLoadInfoResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownLoadInfoResult>(create);
  static DownLoadInfoResult? _defaultInstance;

  @$pb.TagNumber(1)
  DownloadInfoRequestType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(DownloadInfoRequestType v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

