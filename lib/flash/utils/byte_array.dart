import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:typed_data/typed_data.dart';

/// The ByteArray class provides methods and properties to optimize reading, writing, and working with binary data.
class ByteArray extends Object {
  late ByteData _data;
  late Uint8Buffer _bytes;

  /// Changes or reads the byte order for the data; either Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN.
  Endian endian = Endian.big;

  ByteArray([List<int>? buffer]) {
    if (buffer != null) {
      _bytes = Uint8Buffer(buffer.length);
      _bytes.setAll(0, buffer);
    } else {
      _bytes = Uint8Buffer(0);
    }
    _data = ByteData.view(_bytes.buffer);
  }

  bool _dataDirty = false;
  ByteData _getData() {
    if (_dataDirty) {
      _dataDirty = false;
      _data = ByteData.view(_bytes.buffer);
    }
    return _data;
  }

  int _position = 0;

  /// Moves, or returns the current position, in bytes, of the file pointer into the ByteArray object.
  int get position => _position;

  /// Moves, or returns the current position, in bytes, of the file pointer into the ByteArray object.
  set position(int value) {
    if (value > _bytes.length) {
      _bytes.length = value;
      _dataDirty = true;
    }
    _position = value;
  }

  List<int> get bytes => _bytes.toList();

  /// The length of the ByteArray object, in bytes.
  int get length {
    return _bytes.length;
  }

  /// The length of the ByteArray object, in bytes.
  set length(int value) {
    if (_position > value) {
      _position = value;
    }
    if (_bytes.length != value) {
      _bytes.length = value;
      _dataDirty = true;
    }
  }

  operator [](int i) {
    if (i < _bytes.length) {
      return _bytes[i];
    }
    return null;
  }

  operator []=(int i, int value) {
    if (i >= _bytes.length) {
      _bytes.length = i + 1;
      _dataDirty = true;
    }
    _bytes[i] = value;
  }

  void _setAll(int index, Iterable<int> iterable) {
    if (index + iterable.length > length) {
      length = index + iterable.length;
      _dataDirty = true;
    }
    _bytes.setAll(index, iterable);
  }

  /// The number of bytes of data available for reading from the current position in the byte array to the end of the array.
  int get bytesAvailable {
    return length - position;
  }

  /// Clears the contents of the byte array and resets the length and position properties to 0.
  void clear() {
    position = 0;
    _bytes.length = 0;
    _dataDirty = true;
  }

  /// Reads a Boolean value from the byte stream.
  bool readBoolean() {
    _validate(1);
    return _bytes[_position++] == 1;
  }

  /// Writes a Boolean value.
  void writeBoolean(bool value) {
    if (value) {
      this[_position++] = 1;
    } else {
      this[_position++] = 0;
    }
  }

  /// Reads a signed byte from the byte stream.
  int readByte() {
    _validate(1);
    return _getData().getInt8(_position++);
  }

  /// Writes a byte to the byte stream.
  void writeByte(int value) {
    _validateBuffer(1);
    _getData().setInt8(_position++, value);
  }

  /// Reads the number of data bytes, specified by the length parameter, from the byte stream.
  void readBytes(ByteArray bytes, [int offset = 0, int length = 0]) {
    if (length == 0) {
      length = bytesAvailable;
    }
    var sourceBytes = _readBytes(length);
    bytes._setAll(offset, sourceBytes);
  }

  /// Writes a sequence of length bytes from the specified byte array, bytes, starting offset(zero-based index) bytes into the byte stream.
  void writeBytes(ByteArray bytes, [int offset = 0, int length = 0]) {
    int writeLength = 0;
    if (length < 0) {
      return;
    } else if (length == 0) {
      writeLength = bytes.length - offset;
    } else {
      writeLength = min(bytes.length - offset, length);
    }
    List<int> sourceBytes = bytes._bytes.sublist(offset, offset + writeLength);
    _setAll(_position, sourceBytes);
    _position += sourceBytes.length;
  }

  /// Reads an IEEE 754 double-precision (64-bit) floating-point number from the byte stream.
  double readDouble() {
    _validate(8);
    double value = _getData().getFloat64(_position, endian);
    _position += 8;
    return value;
  }

  /// Writes an IEEE 754 double-precision (64-bit) floating-point number to the byte stream.
  void writeDouble(double value) {
    _validateBuffer(8);
    _getData().setFloat64(_position, value, endian);
    _position += 8;
  }

  /// Reads an IEEE 754 single-precision (32-bit) floating-point number from the byte stream.
  double readFloat() {
    _validate(4);
    double value = _getData().getFloat32(_position, endian);
    _position += 4;
    return value;
  }

  /// Writes an IEEE 754 single-precision (32-bit) floating-point number to the byte stream.
  void writeFloat(double value) {
    _validateBuffer(4);
    _getData().setFloat32(_position, value, endian);
    _position += 4;
  }

  /// Reads a signed 32-bit integer from the byte stream.
  int readInt() {
    _validate(4);
    int value = _getData().getInt32(_position, endian);
    _position += 4;
    return value;
  }

  /// Writes a 32-bit signed integer to the byte stream.
  void writeInt(int value) {
    _validateBuffer(4);
    _getData().setInt32(_position, value, endian);
    _position += 4;
  }

  /// Reads a signed 16-bit integer from the byte stream.
  int readShort() {
    _validate(2);
    int value = _getData().getInt16(_position, endian);
    _position += 2;
    return value;
  }

  /// Writes a 16-bit integer to the byte stream.
  void writeShort(int value) {
    _validateBuffer(2);
    _getData().setInt16(_position, value, endian);
    _position += 2;
  }

  /// Reads an unsigned byte from the byte stream.
  int readUnsignedByte() {
    _validate(1);
    int value = _getData().getUint8(_position);
    _position += 1;
    return value;
  }

  /// Reads an unsigned 32-bit integer from the byte stream.
  int readUnsignedInt() {
    _validate(4);
    int value = _getData().getUint32(_position, endian);
    _position += 4;
    return value;
  }

  /// Writes a 32-bit unsigned integer to the byte stream.
  void writeUnsignedInt(int value) {
    _validateBuffer(4);
    _getData().setUint32(_position, value, endian);
    _position += 4;
  }

  /// Reads an unsigned 16-bit integer from the byte stream.
  int readUnsignedShort() {
    _validate(2);
    int value = _getData().getUint16(_position, endian);
    _position += 2;
    return value;
  }

  /// Reads a UTF-8 string from the byte stream. The string is assumed to be prefixed with an unsigned short indicating the length in bytes.
  String readUTF() {
    int length = readUnsignedShort();
    return readUTFBytes(length);
  }

  /// Reads a sequence of UTF-8 bytes specified by the length parameter from the byte stream and returns a string.
  String readUTFBytes(int length) {
    if (length == 0) {
      return "";
    }
    _validate(length);
    var bytes = _readBytes(length);
    return _decodeUTF8(bytes);
  }

  /// Writes a UTF-8 string to the byte stream. The length of the UTF-8 string in bytes is written first, as a 16-bit integer, followed by the bytes representing the characters of the string.
  void writeUTF(String value) {
    List<int> utf8bytes = utf8.encode(value);
    int length = utf8bytes.length;
    writeShort(length);
    _setAll(_position, utf8bytes);
    _position += length;
  }

  /// Writes a UTF-8 string to the byte stream. Similar to the writeUTF() method, but writeUTFBytes() does not prefix the string with a 16-bit length word.
  void writeUTFBytes(String value) {
    List<int> utf8bytes = utf8.encode(value);
    _setAll(_position, utf8bytes);
    _position += length;
  }

  String _decodeUTF8(List<int> data) {
    return utf8.decode(data);
  }

  List<int> _readBytes(int length) {
    _validate(length);
    var subList = _bytes.sublist(position, position + length);
    _position += length;
    return subList;
  }

  void _validateBuffer(int len) {
    int l = len + position;
    if (l > length) {
      length = l;
    }
  }

  bool _validate(int len) {
    int bl = _bytes.length;
    if (bl > 0 && position + len <= bl) {
      return true;
    } else {
      throw Exception("End of file was encountered");
    }
  }
}
