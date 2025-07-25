import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:studyme/models/log/completed_task_log.dart';
import 'package:studyme/models/goal.dart';
import 'package:studyme/models/phase/phase_withdrawal.dart';
import 'package:studyme/models/trial_type.dart';
import 'package:studyme/ui/screens/creator_1_details.dart';

import 'models/app_state/app_data.dart';
import 'models/app_state/app_state.dart';
import 'models/app_state/log_data.dart';
import 'models/intervention.dart';
import 'models/log/trial_log.dart';
import 'models/measure/keyboard_measure.dart';
import 'models/measure/list_item.dart';
import 'models/measure/list_measure.dart';
import 'models/measure/scale_measure.dart';
import 'models/phase/phase_intervention.dart';
import 'models/phase_order.dart';
import 'models/reminder.dart';
import 'models/trial.dart';
import 'models/trial_schedule.dart';
import 'routes.dart';
import 'ui/screens/dashboard.dart';
import 'ui/screens/init.dart';
import 'ui/screens/measure_library.dart';
import 'ui/screens/onboarding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupHive();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppData>(
      create: (context) => AppData(),
    ),
    ChangeNotifierProvider<LogData>(
      create: (context) => LogData(),
    )
  ], child: const MyApp()));
}

Future<void> _setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter<AppState?>(AppStateAdapter());

  Hive.registerAdapter<Trial>(TrialAdapter());
  Hive.registerAdapter<InterventionPhase>(InterventionPhaseAdapter());
  Hive.registerAdapter<WithdrawalPhase>(WithdrawalPhaseAdapter());
  Hive.registerAdapter<TrialType?>(TrialTypeAdapter());
  Hive.registerAdapter<TrialSchedule>(TrialScheduleAdapter());
  Hive.registerAdapter<Goal>(GoalAdapter());
  Hive.registerAdapter<PhaseOrder?>(PhaseOrderAdapter());

  Hive.registerAdapter<Reminder>(ReminderAdapter());
  Hive.registerAdapter<Intervention>(InterventionAdapter());

  Hive.registerAdapter<KeyboardMeasure>(KeyboardMeasureAdapter());
  Hive.registerAdapter<ListItem>(ListItemAdapter());
  Hive.registerAdapter<ListMeasure>(ListMeasureAdapter());
  Hive.registerAdapter<ScaleMeasure>(ScaleMeasureAdapter());

  Hive.registerAdapter<TrialLog>(TrialLogAdapter());
  Hive.registerAdapter<CompletedTaskLog>(CompletedTaskLogAdapter());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Study Me',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        initialRoute: Routes.init,
        routes: {
          Routes.init: (context) => const Init(),
          Routes.onboarding: (context) => const Onboarding(),
          Routes.creator: (context) => const CreatorDetails(),
          Routes.measure_library: (context) => const MeasureLibrary(),
          Routes.dashboard: (context) => const Dashboard(),
        });
  }
}
