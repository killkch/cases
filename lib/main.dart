// ignore_for_file: prefer_const_constructors

import 'package:cases/firebase_options.dart';
import 'package:cases/gemini/screens/login_screen.dart';
import 'package:cases/hive_database/model/word_model.dart';
import 'package:cases/provider/counter_provider.dart';
import 'package:cases/provider/user_provider.dart';
import 'package:cases/provider_infinite_scroll/ajax_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:cases/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' as provider;

void main() async {
  /**
   * dotenv 초기화 작업입니다. 
   */
  await dotenv.load(fileName: ".env");
  //? init firebase !!!!
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //? init HIVE !!!
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox<WordModel>('word');
  //? splash screen init
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  /**
   * 리버포드 초기화에 필요한 설정입니다. 
   * providerscope로 감싸줍니다.
   */
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //? Get 을 사용하기 위해서는 material app 을 이러한 방식으로 바꿔줘야 합니다.
    /**
     * river pod 와 provider에 동시에 선언이 되어 있는 클래스이다 
     * 이러한 경우 prefic를 사용하여 주어야 한다. 
     */
    return provider.MultiProvider(
      providers: [
        provider.ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => CounterProvider(),
        ),
        provider.ChangeNotifierProvider(
          create: (_) => AjaxProvider(),
        ),
      ],
      child: GetMaterialApp(
        //? 테스트 배너를 없애는 부분입니다.

        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: HomePage(),

        //? 수시로 바꾸는 값에 사용합니다.
        //? 즉 정보를 가져오는 데이타베이스와 동기화하여 한쪽이 변화를 할 경우 동시에 같이 변회된 정보의 값을 사용할 수 있게
        //? 해 줍니다.
        //? 많은 용도로 사용하지만 가장 대표적으로 사용하는 부분은 로그인 상테 변화를 알수 있습니다.
        //? iterator와 같은 의미로 보시면 됩니다.

        home: StreamBuilder(
          //? 파이어베이스 인증 서비스에서 제공하는 userChanges 즉 사용자의 상태를 채크합니다.
          //? 만약 연결 상태가 웨이팅일 경우 웨이팅 화면을 만들어 줍니다.
          //? User 객체를 가져오는 스트리이 3가지 있다 그 중의 하나이다.

          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                /**
                 * 인디케이터를 보여줍니다. 
                 */
                child: CircularProgressIndicator(),
              );
            }

            /**
             * 만약에 스냅샷이 널이면 아직 로그인이 안된 상태로 보고 로그인 페이지로 이동합니다.
             * 널이 아닌 경우 홈페이지로 이동하게 됩니다. 
             */

            if (snapshot.data == null) {
              return const LoginScreen();
            }
            return HomePage();
          },
        ),
      ),
    );
  }
}
