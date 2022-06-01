class Activities {
  String activityType;
  String institution;
  String when;
  String objective;
  String remarks;
  int id;
  Activities({
    required this.activityType,
    required this.institution,
    required this.when,
    required this.objective,
    required this.remarks,
    required this.id,
  });

  Activities.fromJson(Map<dynamic, dynamic> json)
      : activityType = json["activityType"],
        institution = json["institution"],
        when = json["when"],
        objective = json["objective"],
        remarks = json["remarks"],
        id = json["id"];
}
