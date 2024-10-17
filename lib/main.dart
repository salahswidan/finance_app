import 'package:finance_app/cubit/fetch_data_cubit.dart';
import 'package:finance_app/model/finance_model.dart';
import 'package:finance_app/page/add.dart';
import 'package:finance_app/page/on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'page/home_page.dart';
import 'page/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Hive.initFlutter();
  Hive.registerAdapter(FinanceModelAdapter());
  await Hive.openBox("darkModeBox");
  await Hive.openBox<FinanceModel>("financeBox");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FetchDataCubit(),
      child: ValueListenableBuilder(
        valueListenable: Hive.box("darkModeBox").listenable(),
        builder: (context, box, child) {
          var darkMode = box.get("darkMode", defaultValue: false);
          return MaterialApp(
            title: "Finance ",
            debugShowCheckedModeBanner: false,
            darkTheme: ThemeData.dark(useMaterial3: true),
            themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(useMaterial3: true),
            home: HomePage(),
          );
        },
      ),
    );
  }
}
