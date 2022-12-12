import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

WebSocketChannel establishConnection(String symbol, String interval) {
  final channel = WebSocketChannel.connect(
    Uri.parse('wss://stream.binance.com:9443/ws'),
  );
  channel.sink.add(
    jsonEncode(
      {
        "method": "SUBSCRIBE",
        "params": [symbol + "@kline_" + interval],
        "id": 1
      },
    ),
  );
  return channel;
}
