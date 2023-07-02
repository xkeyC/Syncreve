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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'file_sync.pbenum.dart';

export 'file_sync.pbenum.dart';

class DownloadTaskRequest extends $pb.GeneratedMessage {
  factory DownloadTaskRequest() => create();

  DownloadTaskRequest._() : super();

  factory DownloadTaskRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadTaskRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTaskRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workingUrl', protoName: 'workingUrl')
    ..aOS(2, _omitFieldNames ? '' : 'instanceUrl', protoName: 'instanceUrl')
    ..pc<DownloadTaskRequestFileInfo>(
        3, _omitFieldNames ? '' : 'fileInfos', $pb.PbFieldType.PM,
        protoName: 'fileInfos', subBuilder: DownloadTaskRequestFileInfo.create)
    ..aOS(4, _omitFieldNames ? '' : 'savePath', protoName: 'savePath')
    ..aOS(5, _omitFieldNames ? '' : 'cookie')
    ..e<DownloadInfoRequestType>(
        6, _omitFieldNames ? '' : 'downLoadType', $pb.PbFieldType.OE,
        protoName: 'downLoadType',
        defaultOrMaker: DownloadInfoRequestType.All,
        valueOf: DownloadInfoRequestType.valueOf,
        enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadTaskRequest clone() => DownloadTaskRequest()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadTaskRequest copyWith(void Function(DownloadTaskRequest) updates) =>
      super.copyWith((message) => updates(message as DownloadTaskRequest))
          as DownloadTaskRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequest create() => DownloadTaskRequest._();

  DownloadTaskRequest createEmptyInstance() => create();

  static $pb.PbList<DownloadTaskRequest> createRepeated() =>
      $pb.PbList<DownloadTaskRequest>();

  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTaskRequest>(create);
  static DownloadTaskRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workingUrl => $_getSZ(0);

  @$pb.TagNumber(1)
  set workingUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWorkingUrl() => $_has(0);

  @$pb.TagNumber(1)
  void clearWorkingUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get instanceUrl => $_getSZ(1);

  @$pb.TagNumber(2)
  set instanceUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInstanceUrl() => $_has(1);

  @$pb.TagNumber(2)
  void clearInstanceUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<DownloadTaskRequestFileInfo> get fileInfos => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get savePath => $_getSZ(3);

  @$pb.TagNumber(4)
  set savePath($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSavePath() => $_has(3);

  @$pb.TagNumber(4)
  void clearSavePath() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cookie => $_getSZ(4);

  @$pb.TagNumber(5)
  set cookie($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCookie() => $_has(4);

  @$pb.TagNumber(5)
  void clearCookie() => clearField(5);

  @$pb.TagNumber(6)
  DownloadInfoRequestType get downLoadType => $_getN(5);

  @$pb.TagNumber(6)
  set downLoadType(DownloadInfoRequestType v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDownLoadType() => $_has(5);

  @$pb.TagNumber(6)
  void clearDownLoadType() => clearField(6);
}

class DownloadTaskRequestFileInfo extends $pb.GeneratedMessage {
  factory DownloadTaskRequestFileInfo() => create();

  DownloadTaskRequestFileInfo._() : super();

  factory DownloadTaskRequestFileInfo.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadTaskRequestFileInfo.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTaskRequestFileInfo',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'fileID', protoName: 'fileID')
    ..aOS(2, _omitFieldNames ? '' : 'fileName', protoName: 'fileName')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadTaskRequestFileInfo clone() =>
      DownloadTaskRequestFileInfo()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadTaskRequestFileInfo copyWith(
          void Function(DownloadTaskRequestFileInfo) updates) =>
      super.copyWith(
              (message) => updates(message as DownloadTaskRequestFileInfo))
          as DownloadTaskRequestFileInfo;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequestFileInfo create() =>
      DownloadTaskRequestFileInfo._();

  DownloadTaskRequestFileInfo createEmptyInstance() => create();

  static $pb.PbList<DownloadTaskRequestFileInfo> createRepeated() =>
      $pb.PbList<DownloadTaskRequestFileInfo>();

  @$core.pragma('dart2js:noInline')
  static DownloadTaskRequestFileInfo getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTaskRequestFileInfo>(create);
  static DownloadTaskRequestFileInfo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get fileID => $_getSZ(0);

  @$pb.TagNumber(1)
  set fileID($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasFileID() => $_has(0);

  @$pb.TagNumber(1)
  void clearFileID() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get fileName => $_getSZ(1);

  @$pb.TagNumber(2)
  set fileName($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasFileName() => $_has(1);

  @$pb.TagNumber(2)
  void clearFileName() => clearField(2);
}

class DownloadDirTaskRequest extends $pb.GeneratedMessage {
  factory DownloadDirTaskRequest() => create();

  DownloadDirTaskRequest._() : super();

  factory DownloadDirTaskRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadDirTaskRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadDirTaskRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'workingUrl', protoName: 'workingUrl')
    ..aOS(2, _omitFieldNames ? '' : 'instanceUrl', protoName: 'instanceUrl')
    ..aOS(3, _omitFieldNames ? '' : 'dirPath', protoName: 'dirPath')
    ..aOS(4, _omitFieldNames ? '' : 'savePath', protoName: 'savePath')
    ..aOS(5, _omitFieldNames ? '' : 'cookie')
    ..e<DownloadInfoRequestType>(
        6, _omitFieldNames ? '' : 'downLoadType', $pb.PbFieldType.OE,
        protoName: 'downLoadType',
        defaultOrMaker: DownloadInfoRequestType.All,
        valueOf: DownloadInfoRequestType.valueOf,
        enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadDirTaskRequest clone() =>
      DownloadDirTaskRequest()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadDirTaskRequest copyWith(
          void Function(DownloadDirTaskRequest) updates) =>
      super.copyWith((message) => updates(message as DownloadDirTaskRequest))
          as DownloadDirTaskRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskRequest create() => DownloadDirTaskRequest._();

  DownloadDirTaskRequest createEmptyInstance() => create();

  static $pb.PbList<DownloadDirTaskRequest> createRepeated() =>
      $pb.PbList<DownloadDirTaskRequest>();

  @$core.pragma('dart2js:noInline')
  static DownloadDirTaskRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadDirTaskRequest>(create);
  static DownloadDirTaskRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get workingUrl => $_getSZ(0);

  @$pb.TagNumber(1)
  set workingUrl($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWorkingUrl() => $_has(0);

  @$pb.TagNumber(1)
  void clearWorkingUrl() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get instanceUrl => $_getSZ(1);

  @$pb.TagNumber(2)
  set instanceUrl($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasInstanceUrl() => $_has(1);

  @$pb.TagNumber(2)
  void clearInstanceUrl() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get dirPath => $_getSZ(2);

  @$pb.TagNumber(3)
  set dirPath($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasDirPath() => $_has(2);

  @$pb.TagNumber(3)
  void clearDirPath() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get savePath => $_getSZ(3);

  @$pb.TagNumber(4)
  set savePath($core.String v) {
    $_setString(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasSavePath() => $_has(3);

  @$pb.TagNumber(4)
  void clearSavePath() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get cookie => $_getSZ(4);

  @$pb.TagNumber(5)
  set cookie($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasCookie() => $_has(4);

  @$pb.TagNumber(5)
  void clearCookie() => clearField(5);

  @$pb.TagNumber(6)
  DownloadInfoRequestType get downLoadType => $_getN(5);

  @$pb.TagNumber(6)
  set downLoadType(DownloadInfoRequestType v) {
    setField(6, v);
  }

  @$pb.TagNumber(6)
  $core.bool hasDownLoadType() => $_has(5);

  @$pb.TagNumber(6)
  void clearDownLoadType() => clearField(6);
}

class DownloadTaskResult extends $pb.GeneratedMessage {
  factory DownloadTaskResult() => create();

  DownloadTaskResult._() : super();

  factory DownloadTaskResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadTaskResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTaskResult',
      createEmptyInstance: create)
    ..pPS(1, _omitFieldNames ? '' : 'ids')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadTaskResult clone() => DownloadTaskResult()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadTaskResult copyWith(void Function(DownloadTaskResult) updates) =>
      super.copyWith((message) => updates(message as DownloadTaskResult))
          as DownloadTaskResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTaskResult create() => DownloadTaskResult._();

  DownloadTaskResult createEmptyInstance() => create();

  static $pb.PbList<DownloadTaskResult> createRepeated() =>
      $pb.PbList<DownloadTaskResult>();

  @$core.pragma('dart2js:noInline')
  static DownloadTaskResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTaskResult>(create);
  static DownloadTaskResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.String> get ids => $_getList(0);
}

class DownloadTaskCancelRequest extends $pb.GeneratedMessage {
  factory DownloadTaskCancelRequest() => create();

  DownloadTaskCancelRequest._() : super();

  factory DownloadTaskCancelRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadTaskCancelRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTaskCancelRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadTaskCancelRequest clone() =>
      DownloadTaskCancelRequest()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadTaskCancelRequest copyWith(
          void Function(DownloadTaskCancelRequest) updates) =>
      super.copyWith((message) => updates(message as DownloadTaskCancelRequest))
          as DownloadTaskCancelRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelRequest create() => DownloadTaskCancelRequest._();

  DownloadTaskCancelRequest createEmptyInstance() => create();

  static $pb.PbList<DownloadTaskCancelRequest> createRepeated() =>
      $pb.PbList<DownloadTaskCancelRequest>();

  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTaskCancelRequest>(create);
  static DownloadTaskCancelRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);

  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);

  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

class DownloadTaskCancelResult extends $pb.GeneratedMessage {
  factory DownloadTaskCancelResult() => create();

  DownloadTaskCancelResult._() : super();

  factory DownloadTaskCancelResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadTaskCancelResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadTaskCancelResult',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'status')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadTaskCancelResult clone() =>
      DownloadTaskCancelResult()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadTaskCancelResult copyWith(
          void Function(DownloadTaskCancelResult) updates) =>
      super.copyWith((message) => updates(message as DownloadTaskCancelResult))
          as DownloadTaskCancelResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelResult create() => DownloadTaskCancelResult._();

  DownloadTaskCancelResult createEmptyInstance() => create();

  static $pb.PbList<DownloadTaskCancelResult> createRepeated() =>
      $pb.PbList<DownloadTaskCancelResult>();

  @$core.pragma('dart2js:noInline')
  static DownloadTaskCancelResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadTaskCancelResult>(create);
  static DownloadTaskCancelResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get status => $_getSZ(0);

  @$pb.TagNumber(1)
  set status($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasStatus() => $_has(0);

  @$pb.TagNumber(1)
  void clearStatus() => clearField(1);
}

class DownloadInfoRequest extends $pb.GeneratedMessage {
  factory DownloadInfoRequest() => create();

  DownloadInfoRequest._() : super();

  factory DownloadInfoRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadInfoRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadInfoRequest',
      createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aInt64(2, _omitFieldNames ? '' : 'updateTime', protoName: 'updateTime')
    ..e<DownloadInfoRequestType>(
        3, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: DownloadInfoRequestType.All,
        valueOf: DownloadInfoRequestType.valueOf,
        enumValues: DownloadInfoRequestType.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadInfoRequest clone() => DownloadInfoRequest()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadInfoRequest copyWith(void Function(DownloadInfoRequest) updates) =>
      super.copyWith((message) => updates(message as DownloadInfoRequest))
          as DownloadInfoRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadInfoRequest create() => DownloadInfoRequest._();

  DownloadInfoRequest createEmptyInstance() => create();

  static $pb.PbList<DownloadInfoRequest> createRepeated() =>
      $pb.PbList<DownloadInfoRequest>();

  @$core.pragma('dart2js:noInline')
  static DownloadInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadInfoRequest>(create);
  static DownloadInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);

  @$pb.TagNumber(1)
  set id($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);

  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get updateTime => $_getI64(1);

  @$pb.TagNumber(2)
  set updateTime($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasUpdateTime() => $_has(1);

  @$pb.TagNumber(2)
  void clearUpdateTime() => clearField(2);

  @$pb.TagNumber(3)
  DownloadInfoRequestType get type => $_getN(2);

  @$pb.TagNumber(3)
  set type(DownloadInfoRequestType v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);

  @$pb.TagNumber(3)
  void clearType() => clearField(3);
}

class DownLoadInfoResult extends $pb.GeneratedMessage {
  factory DownLoadInfoResult() => create();

  DownLoadInfoResult._() : super();

  factory DownLoadInfoResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownLoadInfoResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownLoadInfoResult',
      createEmptyInstance: create)
    ..e<DownloadInfoRequestType>(
        1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: DownloadInfoRequestType.All,
        valueOf: DownloadInfoRequestType.valueOf,
        enumValues: DownloadInfoRequestType.values)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownLoadInfoResult clone() => DownLoadInfoResult()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownLoadInfoResult copyWith(void Function(DownLoadInfoResult) updates) =>
      super.copyWith((message) => updates(message as DownLoadInfoResult))
          as DownLoadInfoResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownLoadInfoResult create() => DownLoadInfoResult._();

  DownLoadInfoResult createEmptyInstance() => create();

  static $pb.PbList<DownLoadInfoResult> createRepeated() =>
      $pb.PbList<DownLoadInfoResult>();

  @$core.pragma('dart2js:noInline')
  static DownLoadInfoResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownLoadInfoResult>(create);
  static DownLoadInfoResult? _defaultInstance;

  @$pb.TagNumber(1)
  DownloadInfoRequestType get type => $_getN(0);

  @$pb.TagNumber(1)
  set type(DownloadInfoRequestType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);

  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);

  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) {
    $_setBytes(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);

  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

class DownloadCountRequest extends $pb.GeneratedMessage {
  factory DownloadCountRequest() => create();

  DownloadCountRequest._() : super();

  factory DownloadCountRequest.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadCountRequest.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadCountRequest',
      createEmptyInstance: create)
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadCountRequest clone() =>
      DownloadCountRequest()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadCountRequest copyWith(void Function(DownloadCountRequest) updates) =>
      super.copyWith((message) => updates(message as DownloadCountRequest))
          as DownloadCountRequest;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadCountRequest create() => DownloadCountRequest._();

  DownloadCountRequest createEmptyInstance() => create();

  static $pb.PbList<DownloadCountRequest> createRepeated() =>
      $pb.PbList<DownloadCountRequest>();

  @$core.pragma('dart2js:noInline')
  static DownloadCountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadCountRequest>(create);
  static DownloadCountRequest? _defaultInstance;
}

class DownloadCountResult extends $pb.GeneratedMessage {
  factory DownloadCountResult() => create();

  DownloadCountResult._() : super();

  factory DownloadCountResult.fromBuffer($core.List<$core.int> i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);

  factory DownloadCountResult.fromJson($core.String i,
          [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DownloadCountResult',
      createEmptyInstance: create)
    ..e<DownloadInfoRequestType>(
        1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: DownloadInfoRequestType.All,
        valueOf: DownloadInfoRequestType.valueOf,
        enumValues: DownloadInfoRequestType.values)
    ..aInt64(2, _omitFieldNames ? '' : 'workingCount',
        protoName: 'workingCount')
    ..aInt64(3, _omitFieldNames ? '' : 'Count', protoName: 'Count')
    ..hasRequiredFields = false;

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  DownloadCountResult clone() => DownloadCountResult()..mergeFromMessage(this);

  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  DownloadCountResult copyWith(void Function(DownloadCountResult) updates) =>
      super.copyWith((message) => updates(message as DownloadCountResult))
          as DownloadCountResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DownloadCountResult create() => DownloadCountResult._();

  DownloadCountResult createEmptyInstance() => create();

  static $pb.PbList<DownloadCountResult> createRepeated() =>
      $pb.PbList<DownloadCountResult>();

  @$core.pragma('dart2js:noInline')
  static DownloadCountResult getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DownloadCountResult>(create);
  static DownloadCountResult? _defaultInstance;

  @$pb.TagNumber(1)
  DownloadInfoRequestType get type => $_getN(0);

  @$pb.TagNumber(1)
  set type(DownloadInfoRequestType v) {
    setField(1, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);

  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get workingCount => $_getI64(1);

  @$pb.TagNumber(2)
  set workingCount($fixnum.Int64 v) {
    $_setInt64(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasWorkingCount() => $_has(1);

  @$pb.TagNumber(2)
  void clearWorkingCount() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get count => $_getI64(2);

  @$pb.TagNumber(3)
  set count($fixnum.Int64 v) {
    $_setInt64(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCount() => $_has(2);

  @$pb.TagNumber(3)
  void clearCount() => clearField(3);
}

const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
