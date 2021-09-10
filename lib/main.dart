import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:resume_builder/screens/authenticate/wrapper/authenticate_base_widget_wrapper.dart';
import 'package:resume_builder/screens/loading/loading.dart';
import 'package:resume_builder/services/authservice.dart';

import 'module/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MaterialApp(
        locale: DevicePreview.locale(context), // Add the locale here
        builder: DevicePreview.appBuilder,
        theme: ThemeData(
          dividerTheme: DividerThemeData(
            space: 16.0,
            thickness: 2.0,
            indent: 32.0,
            endIndent: 32.0,
          ),
        ),
        home: App(),
      )
    ),
  );
}

// globally declare firebaseAuthProvider
final firebaseAuthProvider = FirebaseAuth.instance;

// Creating a auth State Changes Stream Provider
final authStateChangesProvider = StreamProvider<ResumeUser?>((_) {
  return AuthService().user;
});

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: FutureBuilder(
        // Initialize FlutterFire:
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {


            return Consumer(
              builder: (context,ref,child) {

                final AsyncValue<ResumeUser?> result = ref.watch(authStateChangesProvider);

                if (result.data?.value != null ){
                  return AuthenticateBaseWidgetWrapper(user: result.data!.value!);
                } else {
                  return Loading();
                }
              },
            );
          }
          // Otherwise, show something whilst waiting for initialization to complete
          return Loading();
        },
      ),
    );
  }
}


