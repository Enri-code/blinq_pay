import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:blinq_pay/core/theme/app_theme.dart';
import 'package:blinq_pay/features/home/presentation/pages/home_screen.dart';
import 'package:blinq_pay/features/posts/data/datasource/posts_datasource_fs.dart';
import 'package:blinq_pay/features/posts/data/repository/posts_repository.dart';
import 'package:blinq_pay/features/posts/domain/datasource/posts_datasource.dart';
import 'package:blinq_pay/features/posts/presentation/bloc/posts_bloc/posts_bloc.dart';
import 'package:blinq_pay/features/users/data/datasource/users_datasource_fs.dart';
import 'package:blinq_pay/features/users/data/repository/users_repository.dart';
import 'package:blinq_pay/features/users/domain/datasource/users_datasource.dart';
import 'package:blinq_pay/features/users/presentation/bloc/users_bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UsersDatasource>(
          create: (context) => UsersDatasourceFS(),
        ),
        RepositoryProvider<PostsDatasource>(
          create: (context) => PostsDatasourceFS(),
        ),
      ],
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider<UsersRepositoryImpl>(
            create: (context) => UsersRepositoryImpl(context.read()),
          ),
          RepositoryProvider<PostsRepositoryImpl>(
            create: (context) => PostsRepositoryImpl(context.read()),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => PostsBloc(context.read())),
            BlocProvider(create: (context) => UsersBloc(context.read())),
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
        ),
      ),
    );
  }
}
