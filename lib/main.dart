import 'package:pravana_eet/Screens/HomePage.dart';
import 'package:pravana_eet/Screens/LoginScreen.dart';
import 'package:flutter/material.dart';
import 'package:pravana_eet/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:pravana_eet/components/loading.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider.initialize())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ScreensController(),
      )));
}


class ScreensController extends StatefulWidget {
  @override
  _ScreensControllerState createState() => _ScreensControllerState();
}

class _ScreensControllerState extends State<ScreensController> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch (user.status) {
      case Status.Uninitialized:
        return Loading();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return HomeScreen();
      default:
        return LoginScreen();
    }
  }
}
