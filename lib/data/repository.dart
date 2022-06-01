import 'package:mobile_activites/data/model/activities.dart';
import 'package:mobile_activites/data/network_service.dart';

class Repository {
  final NetworkService networkService;
  Repository({required this.networkService});
  Future<List<Activities>> fetchActivities() async {
    final activitiesRaw = await networkService.fetchTodos();
    return activitiesRaw.map((e) => Activities.fromJson(e)).toList();
  }

  Future<Activities?> addActivity(Activities activities) async {
    final ActivityObj = {
      "activityType": activities.activityType,
      "institution": activities.institution,
      "when": activities.when,
      "objective": activities.objective,
      "remarks": activities.remarks
    };
    final activityMap = await networkService.addActivity(ActivityObj);
    if (activityMap == null) return null;
    return Activities.fromJson(activityMap);
  }

  Future<bool> updateActivity(Activities activities) async {
    final activityObj = {
      "activityType": activities.activityType,
      "institution": activities.institution,
      "when": activities.when,
      "objective": activities.objective,
      "remarks": activities.remarks
    };
    return await networkService.updateActivity(activityObj, activities.id);
  }
}
