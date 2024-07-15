import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/app_state/app_data.dart';
import 'package:studyme/models/app_state/app_state.dart';
import 'package:studyme/routes.dart';
import 'package:studyme/util/notifications.dart';

class Init extends StatefulWidget {
  const Init({super.key});

  @override
  InitState createState() => InitState();
}

class InitState extends State<Init> {
  @override
  Widget build(BuildContext context) {
    _initAppState();
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }

  _initAppState() async {
    // first make sure app data is fetched from box
    await Provider.of<AppData>(context, listen: false).loadAppState();
    await Notifications.init();
    if (!mounted) return;
    Provider.of<AppData>(context, listen: false)
        .addStepLogForSurvey('opened app');
    AppData appData = Provider.of<AppData>(context, listen: false);
    AppState? state = appData.state;
    if (state == AppState.ONBOARDING) {
      Navigator.pushReplacementNamed(context, Routes.onboarding);
    } else if (state == AppState.CREATING_DETAILS ||
        state == AppState.CREATING_PHASES) {
      Navigator.pushReplacementNamed(context, Routes.creator);
    } else if (state == AppState.DOING) {
      if (!mounted) return;
      appData.scheduleFutureNotifications();
      Navigator.pushReplacementNamed(context, Routes.dashboard);
    }
  }
}
