import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zac/data/network/post_network.dart';
import 'package:zac/data/network/user_network.dart';
import 'package:zac/data/repository/post_repository.dart';
import 'package:zac/data/repository/user_repository.dart';
import 'package:zac/presentation/screens/home_screen.dart';
import 'package:zac/provider/post_provider.dart';
import 'package:zac/provider/user_provider.dart';

void main() {
  // SharedPreferences.setMockInitialValues({});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => UserProvider(
                userRepository: UserRepository(userNetwork: UserNetwork()))),
        ChangeNotifierProvider(
            create: (context) => PostProvider(
                postRepository: PostRepository(postNetwork: PostNetwork()))),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
