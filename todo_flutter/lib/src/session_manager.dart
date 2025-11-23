import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:todo_client/todo_client.dart';

late final Client client;

late String serverUrl;
late SessionManager sessionManager;
Future initializeSessionManager() async {
  const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
  final serverUrl =
      serverUrlFromEnv.isEmpty ? 'http://$localhost:8080/' : serverUrlFromEnv;

  client = Client(serverUrl,
      authenticationKeyManager: FlutterAuthenticationKeyManager())
    ..connectivityMonitor = FlutterConnectivityMonitor();
  sessionManager = SessionManager(caller: client.modules.auth);

  await sessionManager.initialize();
}
