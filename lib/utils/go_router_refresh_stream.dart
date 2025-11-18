// lib/utils/go_router_refresh_stream.dart
import 'package:flutter/foundation.dart';
import 'dart:async';

// Classe qui agit comme un Listenable réactif à un Stream (comme celui de Firebase Auth)
class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
          (dynamic _) => notifyListeners(),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}