import 'dart:async';

class WebSocketClient {
  bool _isConnected = false;
  final _streamController = StreamController<Map<String, dynamic>>.broadcast();

  bool get isConnected => _isConnected;
  Stream<Map<String, dynamic>> get dataStream => _streamController.stream;

  Future<void> connect(String endpointUrl) async {
    _isConnected = true;
    // Realtime connection logic / stream handler mock initialization
  }

  void emit(String event, Map<String, dynamic> data) {
    if (_isConnected) {
      _streamController.add({'event': event, 'data': data, 'timestamp': DateTime.now().toIso8601String()});
    }
  }

  Future<void> disconnect() async {
    _isConnected = false;
    await _streamController.close();
  }
}
