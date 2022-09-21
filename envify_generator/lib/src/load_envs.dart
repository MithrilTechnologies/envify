import 'dart:io' show File;
import 'package:dotenv/dotenv.dart';

/// Load the environment variables from the supplied [path],
/// using the `dotenv` parser.
///
/// If file doesn't exist, an error will be thrown through the
/// [onError] function.
Future<Map<String, String>> loadEnvs(
  String path,
  Function(String) onError,
) async {
  final file = File.fromUri(Uri.file(path));
  final fileExists = await file.exists();

  if (!fileExists) {
    onError("Environment variables file doesn't exist at `$path`.");
  }

  final envs = DotEnv(includePlatformEnvironment: true)..load([path]);

  return envs.map;
}
