import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'bloc/app_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await getDBInstance();
  AppState appState = await AppState.getState();

  runApp(MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AppCubit(appState))],
      child: const App()));
}
