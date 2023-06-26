

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';

import 'package:amplify_api/amplify_api.dart';

// import 'package:amplify_datastore/amplify_datastore.dart';

import 'package:dostv1_3/chatpage.dart';

import 'amplifyconfiguration.dart';


import 'models/ModelProvider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }




  Future<void> _configureAmplify() async {
    try {
      // Create the API plugin.
      //
      // If `ModelProvider.instance` is not available, try running
      // `amplify codegen models` from the root of your project.
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      // AmplifyDataStore datastorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);

      // Create the Auth plugin.
      final auth = AmplifyAuthCognito();

      // Add the plugins and configure Amplify for your app.
      await Amplify.addPlugins([api, auth]);
      await Amplify.configure(amplifyconfig);

      safePrint('Successfully configured');
    } on Exception catch (e) {
      safePrint('Error configuring Amplify: $e');
    }
  }

//logout function
  Future<void> _handleLogout() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      // Handle sign out error
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
        builder: Authenticator.builder(),
        home: CchatPage(),


        
        debugShowCheckedModeBanner: false,
        // const Scaffold(
        //   body: Center(
        //     child: Text('You are logged in!'),

        //  ),
        // ),
      ),
    );
  }
}


