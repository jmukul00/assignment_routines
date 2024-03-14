class RoutineModel {

  final String title;
  final String desc;
  late bool completed;
  late String? time;

  RoutineModel(
      {required this.title, required this.desc, this.completed = false, this.time});
}