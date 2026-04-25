import 'dart:typed_data';

String createBlobUrl(Uint8List bytes) {
  throw UnsupportedError('Cannot create blob on non-web platforms');
}
