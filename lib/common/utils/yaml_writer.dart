/// YamlWriter by Isaac Skelton
/// https://stackoverflow.com/questions/60051282/how-to-write-a-map-to-a-yaml-file-in-dart

class YamlWriter {
  /// The amount of spaces for each level.
  final int spaces;

  /// Initialize the writer with the amount of [spaces] per level.
  YamlWriter({
    this.spaces = 2,
  });

  /// Write a dart structure to a YAML string. [yaml] should be a [Map] or [List].
  String write(dynamic yaml) {
    return _writeInternal(yaml).trim();
  }

  /// Write a dart structure to a YAML string. [yaml] should be a [Map] or [List].
  String _writeInternal(dynamic yaml, { int indent = 0 }) {
    String str = '';

    if (yaml is List) {
      str += _writeList(yaml, indent: indent);
    } else if (yaml is Map) {
      str += _writeMap(yaml, indent: indent);
    } else if (yaml is String) {
      str += "\"${yaml.replaceAll("\"", "\\\"")}\"";
    } else {
      str += yaml.toString();
    }


    return str;
  }

  /// Write a list to a YAML string.
  /// Pass the list in as [yaml] and indent it to the [indent] level.
  String _writeList(List yaml, { int indent = 0 }) {
    String str = '\n';

    for (var item in yaml) {
      str += "${_indent(indent)}- ${_writeInternal(item, indent: indent + 1)}\n";
    }

    return str;
  }

  /// Write a map to a YAML string.
  /// Pass the map in as [yaml] and indent it to the [indent] level.
  String _writeMap(Map yaml, { int indent = 0 }) {
    String str = '\n';

    for (var key in yaml.keys) {
      var value = yaml[key];
      str += "${_indent(indent)}${key.toString()}: ${_writeInternal(value, indent: indent + 1)}\n";
    }

    return str;
  }

  /// Create an indented string for the level with the spaces config.
  /// [indent] is the level of indent whereas [spaces] is the
  /// amount of spaces that the string should be indented by.
  String _indent(int indent) {
    return ''.padLeft(indent * spaces, ' ');
  }
}