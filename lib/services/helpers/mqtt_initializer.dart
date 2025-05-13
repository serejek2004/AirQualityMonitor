import 'package:first_flutter_project/services/not_abstract/mqtt_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<MQTTService?> initializeMQTT(
  void Function(String topic, String message) onMessageReceived,
) async {
  final prefs = await SharedPreferences.getInstance();
  final login = prefs.getString('sessionLogin');
  final id = login != null ? prefs.getString('${login}IdDevice') : null;

  if (id == null) return null;

  final topics = ['sensors/temperature/$id', 'sensors/humidity/$id'];

  final mqttService = MQTTService(
    broker: '758419f9f9db440997781986174fedf9.s1.eu.hivemq.cloud',
    username: 'application',
    password: 'Hello1234',
    topics: topics,
    onMessageReceived: onMessageReceived,
  );

  mqttService.setupClient();
  await mqttService.connect();

  return mqttService;
}

Future<MQTTService> initializeAuthMQTT({
  required String tempId,
  required void Function(String topic, String message) onMessageReceived,
}) async {
  final topic = 'device/auth/$tempId';

  final mqttService = MQTTService(
    broker: '758419f9f9db440997781986174fedf9.s1.eu.hivemq.cloud',
    username: 'application',
    password: 'Hello1234',
    topics: [topic],
    onMessageReceived: onMessageReceived,
  );

  mqttService.setupClient();
  await mqttService.connect();

  return mqttService;
}
