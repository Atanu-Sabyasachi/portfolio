// lib/core/file_helper.dart
import 'file_helper_stub.dart' if (dart.library.html) 'file_helper_web.dart' as pk_file;

abstract class FileHelper {
  static Future<void> downloadResume(String url) async {
    await pk_file.downloadFile(url);
  }
}
