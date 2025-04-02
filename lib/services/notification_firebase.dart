import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_signs/main.dart';

class FirebaseAPI {
  final _fireaseMessaging = FirebaseMessaging.instance;

  // initialize notification
  Future<void> initNotifications() async {
    // request Permission from user
    await _fireaseMessaging.requestPermission();

    // token for this device
    final fCMToken = await _fireaseMessaging.getToken();

    // send this token ur server
    print("TOKEN : $fCMToken");
    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState?.pushNamed('/homePage', arguments: message);
  }


    // background settings
  Future initPushNotification() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    // attach event listeners
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}
