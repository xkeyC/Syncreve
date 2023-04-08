///
//  Generated code. Do not modify.
//  source: libsyncreve/protos/file_sync.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'file_sync.pbenum.dart';

export 'file_sync.pbenum.dart';

class DownloadTaskRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadTaskRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workingUrl', protoName: 'workingUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileID', protoName: 'fileID')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savePath', protoName: 'savePath')
    ..aOS(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'fileName', protoName: 'fileName')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cookie')
    ..e<DownloadInfoRequestType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'downLoadType', $pb.PbFieldType.OE, protoName: 'downLoadType', defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false
  ;

  DownloadTaskRequest._() : super();
  factory DownloadTaskRequest({
    $core.String? workingUrl,
    $core.String? fileID,
    $core.String? savePath,
    $core.String? fileName,
    $core.String? cookie,
    DownloadInfoRequestType? downLoadType,
  }) {
    final _result = create();
    if (workingUrl != null) {
      _result.workingUrl = workingUrl;
    }
    if (fileID != null) {
      _result.fileID = fileID;
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
  $core.String get workingUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set workingUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkingUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkingUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileID => $_getSZ(1);
  @$pb.TagNumber(2)
  set fileID($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasFileID() => $_has(1);
  @$pb.TagNumber(2)
  void clearFileID() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get savePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set savePath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSavePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearSavePath() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get fileName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fileName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasFileName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cookie => $_getSZ(4);
  @$pb.TagNumber(5)
  set cookie($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasCookie() => $_has(4);
  @$pb.TagNumber(5)
  void clearCookie() => clearField(5);

  @$pb.TagNumber(6)
  DownloadInfoRequestType get downLoadType => $_getN(5);
  @$pb.TagNumber(6)
  set downLoadType(DownloadInfoRequestType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDownLoadType() => $_has(5);
  @$pb.TagNumber(6)
  void clearDownLoadType() => clearField(6);
}

class DownloadDirTaskRequest extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadDirTaskRequest', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'workingUrl', protoName: 'workingUrl')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'dirPath', protoName: 'dirPath')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'savePath', protoName: 'savePath')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'cookie')
    ..e<DownloadInfoRequestType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'downLoadType', $pb.PbFieldType.OE, protoName: 'downLoadType', defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false
  ;

  DownloadDirTaskRequest._() : super();
  factory DownloadDirTaskRequest({
    $core.String? workingUrl,
    $core.String? dirPath,
    $core.String? savePath,
    $core.String? cookie,
    DownloadInfoRequestType? downLoadType,
  }) {
    final _result = create();
    if (workingUrl != null) {
      _result.workingUrl = workingUrl;
    }
    if (dirPath != null) {
      _result.dirPath = dirPath;
    }
    if (savePath != null) {
      _result.savePath = savePath;
    }
    if (cookie != null) {
      _result.cookie = cookie;
    }
    if (downLoadType != null) {
      _result.downLoadType = downLoadType;
    }
    return _result;
  }
  factory DownloadDirTaskRequest.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadDirTaskRequest.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadDirTaskRequest clone() => DownloadDirTaskRequest()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadDirTaskRequest copyWith(void Function(DownloadDirTaskRequest) updates) => super.copyWith((message) => updates(message as DownloadDirTaskRequest)) as DownloadDirTaskRequest; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskRequest create() => DownloadDirTaskRequest._();
  DownloadDirTaskRequest createEmptyInstance() => create();
  static $pb.PbList<DownloadDirTaskRequest> createRepeated() => $pb.PbList<DownloadDirTaskRequest>();
  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskRequest getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadDirTaskRequest>(create);
  static DownloadDirTaskRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workingUrl => $_getSZ(0);
  @$pb.TagNumber(1)
  set workingUrl($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasWorkingUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearWorkingUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get dirPath => $_getSZ(1);
  @$pb.TagNumber(2)
  set dirPath($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDirPath() => $_has(1);
  @$pb.TagNumber(2)
  void clearDirPath() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get savePath => $_getSZ(2);
  @$pb.TagNumber(3)
  set savePath($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSavePath() => $_has(2);
  @$pb.TagNumber(3)
  void clearSavePath() => clearField(3);

  @$pb.TagNumber(5)
  $core.String get cookie => $_getSZ(3);
  @$pb.TagNumber(5)
  set cookie($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(5)
  $core.bool hasCookie() => $_has(3);
  @$pb.TagNumber(5)
  void clearCookie() => clearField(5);

  @$pb.TagNumber(6)
  DownloadInfoRequestType get downLoadType => $_getN(4);
  @$pb.TagNumber(6)
  set downLoadType(DownloadInfoRequestType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasDownLoadType() => $_has(4);
  @$pb.TagNumber(6)
  void clearDownLoadType() => clearField(6);
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

class DownloadDirTaskResult extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'DownloadDirTaskResult', createEmptyInstance: create)
    ..pPS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'ids')
    ..hasRequiredFields = false
  ;

  DownloadDirTaskResult._() : super();
  factory DownloadDirTaskResult({
    $core.Iterable<$core.String>? ids,
  }) {
    final _result = create();
    if (ids != null) {
      _result.ids.addAll(ids);
    }
    return _result;
  }
  factory DownloadDirTaskResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DownloadDirTaskResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DownloadDirTaskResult clone() => DownloadDirTaskResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DownloadDirTaskResult copyWith(void Function(DownloadDirTaskResult) updates) => super.copyWith((message) => updates(message as DownloadDirTaskResult)) as DownloadDirTaskResult; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskResult create() => DownloadDirTaskResult._();
  DownloadDirTaskResult createEmptyInstance() => create();
  static $pb.PbList<DownloadDirTaskResult> createRepeated() => $pb.PbList<DownloadDirTaskResult>();
  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DownloadDirTaskResult>(create);
  static DownloadDirTaskResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get ids => $_getList(0);
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
    ..aInt64(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updateTime', protoName: 'updateTime')
    ..e<DownloadInfoRequestType>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: DownloadInfoRequestType.All, valueOf: DownloadInfoRequestType.valueOf, enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false
  ;

  DownloadInfoRequest._() : super();
  factory DownloadInfoRequest({
    $core.String? id,
    $fixnum.Int64? updateTime,
    DownloadInfoRequestType? type,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (updateTime != null) {
      _result.updateTime = updateTime;
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
  $fixnum.Int64 get updateTime => $_getI64(1);
  @$pb.TagNumber(2)
  set updateTime($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUpdateTime() => $_has(1);
  @$pb.TagNumber(2)
  void clearUpdateTime() => clearField(2);

  @$pb.TagNumber(3)
  DownloadInfoRequestType get type => $_getN(2);
  @$pb.TagNumber(3)
  set type(DownloadInfoRequestType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);
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

