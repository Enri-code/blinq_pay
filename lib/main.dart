import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/features/home/presentation/bloc/video_manager_bloc.dart';
import 'package:blinq_pay/features/home/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => VideoManagerBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) {
          return ThemeProvider(
            initTheme:
                theme == Brightness.light ? AppTheme.light : AppTheme.dark,
            builder: (context, myTheme) {
              return MaterialApp(
                title: 'BlinqPay',
                theme: myTheme,
                home: HomeScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
