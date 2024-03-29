import 'package:studyme/util/string_extension.dart';

enum TimeAggregation { Day, Segment, Phase }

extension TimeAggregationExtension on TimeAggregation? {
  String get readable => toString().split('.').last.capitalize();
}
