import 'package:flutter/material.dart';
import 'package:mobile_activites/constant/constant.dart';
import 'package:mobile_activites/data/model/activities.dart';
import 'package:mobile_activites/presentation/screen/add_activities_screen.dart';
import 'package:mobile_activites/presentation/screen/edit_activities_screen.dart';
import 'package:mobile_activites/presentation/screen/home_page.dart';
import 'package:mobile_activites/presentation/screen/info_activities.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (context) => const HomePage());
      case ADD_ACTIVITIES_ROUTE:
        return MaterialPageRoute(builder: (context) => AddActivitiesScreen());
      case EDIT_ACTIViTIES_ROUTE:
        final activities = settings.arguments as Activities;
        return MaterialPageRoute(
            builder: (context) => EditActivitiesScreen(
                  activities: activities,
                ));
      case INFO_ACTIViTIES_ROUTE:
        final activities = settings.arguments as Activities;
        return MaterialPageRoute(
            builder: (context) => InfoActivities(
                  activities: activities,
                ));
      default:
        return null;
    }
  }
}
