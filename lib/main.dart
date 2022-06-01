import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_activites/cubit/activities_cubit.dart';
import 'package:mobile_activites/cubit/add_activities_cubit.dart';
import 'package:mobile_activites/cubit/edit_activities_cubit.dart';
import 'package:mobile_activites/data/network_service.dart';
import 'package:mobile_activites/data/repository.dart';
import 'package:mobile_activites/presentation/app_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppRouter route = AppRouter();
  Repository? repository;

  @override
  Widget build(BuildContext context) {
    repository = Repository(networkService: NetworkService());
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ActivitiesCubit(repository: repository),
        ),
        BlocProvider(
          create: (context) => AddActivitiesCubit(repository: repository),
        ),
        BlocProvider(
          create: (context) => EditActivitiesCubit(repository: repository),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: route.generateRoute,
      ),
    );
  }
}
