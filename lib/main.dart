import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pxquote/blocs/card_quotes/card_quotes_bloc.dart';
import 'package:pxquote/blocs/save_to_clipboard/save_to_clipboard_bloc.dart';
import 'package:pxquote/blocs/share_scan_result/share_scan_result_bloc.dart';
import 'package:pxquote/models/quote_model.dart';
import 'package:pxquote/ui/detail_screen/detail_screen.dart';
import 'package:pxquote/ui/main_screen/main_screen.dart';
import 'package:pxquote/ui/splash_screen/splash_screen.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   final notification = message.notification;
//   final notificationData = message.data;
//   if (notification != null) {
//     LocalNotificationService().showNotification(
//       id: 01,
//       title: notification.title!,
//       body: notification.body,
//       payload: "",
//     );
//     return;
//   }
//   LocalNotificationService().showNotification(
//     id: 01,
//     title: notificationData['title'],
//     body: notificationData['body'],
//     payload: message.data["type"],
//   );
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await LocalNotificationService().init();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   final notification = message.notification;
  //   final notificationData = message.data;
  //   if (notification != null) {
  //     LocalNotificationService().showNotification(
  //       id: 01,
  //       title: notification.title ?? "",
  //       body: notification.body,
  //       payload: message.data["type"],
  //     );
  //     return;
  //   }
  //   LocalNotificationService().showNotification(
  //     id: 01,
  //     title: notificationData['title'] ?? "",
  //     body: notificationData['body'] ?? "",
  //     payload: message.data["type"] ?? "",
  //   );
  // });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<CardQuotesBloc>(create: (context) => CardQuotesBloc()..add(const GetListQuotes())),
          BlocProvider(create: (context) => SaveToClipboardBloc()),
          BlocProvider(create: (context) => ShareScanResultBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'pxQuotes',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: (settings) {
            final arguments = settings.arguments;
            switch (settings.name) {
              case "/detail":
                return CupertinoPageRoute(builder: (context) => DetailScreen(card: arguments as QuoteModel));
              case "/splashscreen":
                return CupertinoPageRoute(builder: (context) => const SplashScreen());
              case "/mainscreen":
                return CupertinoPageRoute(builder: (context) => const MainScreen());
              default:
            }
            return null;
          },
          initialRoute: "/splashscreen",
        ),
      ),
    );
  }
}
