import 'package:app_bloc_flutter/app/constants/firebase_database.dart';
import 'package:app_bloc_flutter/app/data/local_data_source.dart';
import 'package:app_bloc_flutter/app/data/provider/rest.dart';
import 'package:app_bloc_flutter/app/data/repository/api_service_repository.dart';
import 'package:app_bloc_flutter/app/modules/counter/bloc/counter_bloc.dart';
import 'package:app_bloc_flutter/app/modules/lo_to/bloc/lo_to_bloc.dart';
import 'package:app_bloc_flutter/app/modules/lo_to/firebase/firebase_data.dart';
import 'package:app_bloc_flutter/app/routes/app_pages.dart';
import 'package:app_bloc_flutter/firebase_options.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  /// Use preferences like expected.
  await SharedPreferences.getInstance();
  final sf = await SharedPreferences.getInstance();
  runApp(MainApp(
    sharedPreferences: sf,
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, required this.sharedPreferences});
  final bool _isAuth = true;
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => ApiServiceRepository(
            RestAPIClient(
              httpClient: Dio(),
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocalDataSource(sharedPreferences),
        ),
        RepositoryProvider(
          create: (context) => LotoFirebaseDatabase(
            refData: FirebaseDatabase.instance.ref(
              FirebaseDatabaseString.count,
            ),
            refUsers: FirebaseDatabase.instance.ref(
              FirebaseDatabaseString.users,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CounterBloc(
              context.read<ApiServiceRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => LoToBloc(
              localDataSource: context.read<LocalDataSource>(),
              firebaseDatabase: context.read<LotoFirebaseDatabase>(),
            ),
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.returnRouter(
            _isAuth,
          ),
        ),
      ),
    );
  }
}
