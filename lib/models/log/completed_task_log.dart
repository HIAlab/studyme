import 'package:hive/hive.dart';

part 'completed_task_log.g.dart';

@HiveType(typeId: 51)
class CompletedTaskLog {
  @HiveField(0)
  String taskId;

  @HiveField(1)
  DateTime dateTime;

  CompletedTaskLog({required this.taskId, required this.dateTime});
}
