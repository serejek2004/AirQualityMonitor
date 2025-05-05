import 'dart:convert';
import 'dart:io';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

typedef SensorCallback = void Function(String topic, String message);

class MQTTService {
  String broker;
  String username;
  String password;
  List<String> topics;
  SensorCallback? onMessageReceived;

  late MqttServerClient _client;

  MQTTService({
    this.broker = '',
    this.username = '',
    this.password = '',
    this.topics = const [],
    this.onMessageReceived,
  });

  void setupClient() {
    _client = MqttServerClient.withPort(broker, 'flutter_client', 8883);
    _client.logging(on: false);
    _client.keepAlivePeriod = 20;
    _client.setProtocolV311();
    _client.secure = true;
    _client.securityContext = SecurityContext.defaultContext;
  }

  Future<void> connect() async {
    final connMessage = MqttConnectMessage()
        .withClientIdentifier('flutter_client')
        .authenticateAs(username, password)
        .withWillQos(MqttQos.atMostOnce);

    _client.connectionMessage = connMessage;

    try {
      await _client.connect();
      if (_client.connectionStatus!.state == MqttConnectionState.connected) {
        for (final topic in topics) {
          _client.subscribe(topic, MqttQos.atMostOnce);
        }

        _client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          final MqttPublishMessage message = c[0].payload as MqttPublishMessage;
          final payload =
              MqttPublishPayload.bytesToStringAsString(message.payload.message);
          final topic = c[0].topic;
          onMessageReceived?.call(topic, payload);
        });
      } else {
        disconnect();
      }
    } catch (e) {
      disconnect();
    }
  }

  void publish(String topic, dynamic payload) {
    if (_client.connectionStatus?.state != MqttConnectionState.connected) {
      return;
    }

    final builder = MqttClientPayloadBuilder();
    builder.addUTF8String(jsonEncode(payload));

    _client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
  }

  void disconnect() {
    _client.disconnect();
  }
}
