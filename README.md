
# BlinqPay

**BlinqPay** is a polished Flutter application that demonstrates fetching and displaying users and posts from Firebase Firestore. It leverages a clean architecture, responsive design, multimedia handling, and proper state management using **BLoC**.


```dart
  return MultiRepositoryProvider(
    providers: [
      RepositoryProvider<UsersDatasource>(
        create: (context) => MockUsersDatasource(),
        // create: (context) => FSUsersDatasource(FirebaseFirestore.instance),
      ),
      RepositoryProvider<PostsDatasource>(
        create: (context) => MockPostsDatasource(),
        // create: (context) => FSPostsDatasource(FirebaseFirestore.instance),
      ),
    ],

  ...
```

You can find the code for the actual Firestore datasource in:
- [lib/features/posts/data/datasource/posts_datasource_fs.dart](lib/features/posts/data/datasource/posts_datasource_fs.dart) and 
- [lib/features/users/data/datasource/users_datasource_fs.dart](lib/features/users/data/datasource/users_datasource_fs.dart)

---

## Features

- Fetch posts & users from Firestore
- Post types: **Text**, **Image**, and **Video**
- Videos auto-play only when fully visible (one at a time)
- Tab navigation for **Posts** and **Users**
- Support for light & dark themes with animated switching
- Responsive UI using `flutter_screenutil`
- Includes unit, bloc and widget tests
- Built with clean architecture (feature-first + BLoC)

---

## Project Setup

### Dependencies

Make sure you have the following in your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  equatable: ^2.0.7
  flutter_bloc: ^9.1.0
  either_dart: ^1.0.0
  firebase_core: ^3.13.0
  cloud_firestore: ^5.6.6
  animated_theme_switcher: ^2.0.10
  bounce: ^1.0.2
  cached_network_image: ^3.4.1
  flutter_svg: ^2.0.17
  flutter_screenutil: ^5.9.3
  light_dark_theme_toggle: ^1.1.2
  mesh_gradient: ^1.3.8
  photo_view: ^0.15.0
  persistent_bottom_nav_bar: ^6.2.1
  shimmer: ^3.0.0
  timeago: ^3.7.0
  better_player:
    path: packages/better_player-0.0.84

dev_dependencies:
  flutter_test:
    sdk: flutter
  asset_generator: ^1.3.1
  bloc_test: ^10.0.0
  build_runner: ^2.0.4
  mockito: ^5.4.5
  flutter_lints: ^5.0.0
```

### Code Generation

- dart run asset_generator:generate

- dart run build_runner build

### Firebase Setup

**Android:**
- Download [`google-services.json`](https://drive.google.com/file/d/113qCB-T54FXEATCWvU6w5gvdi0bDPUku/view?usp=sharing)
- Place it inside: `android/app/`
- Android Application ID: `com.blinqpay.blinqpost`

**iOS:**
- Download [`GoogleService-Info.plist`](https://drive.google.com/file/d/1uXpSWQRUoUYAUIrsaKVUjhX_eO8lXNDUT/view?usp=sharing)
- Place it inside: `ios/Runner` using XCode (required)

### Initializing Firebase

Don't forget to initialize Firebase before running your app:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
```

---

## Project Structure

```
lib/
├── core/             # Theme, constants, helpers
├── features/
│   ├── home/         # App shell & navigation
│   ├── posts/        # Posts: models, UI, bloc
│   └── users/        # Users: models, UI, bloc
└── main.dart         # App entry point

```

---

## Testing

This app includes unit tests for business logic and widget tests for UI components.

To run tests:

```bash
flutter test
```

---

## Conclusion

**BlinqPay** is designed to be both functional and user-friendly. The use of clean architecture, modern state management, and responsive design ensures a smooth and maintainable codebase. This app offers a seamless experience across both Android and iOS platforms.

Feel free to contribute or provide feedback. Happy coding!