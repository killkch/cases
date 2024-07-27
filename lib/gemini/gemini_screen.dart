import 'package:cases/gemini/providers/providers.dart';
import 'package:cases/gemini/screens/send_image_screen.dart';
import 'package:cases/gemini/widgets/messages_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeminiScreen extends ConsumerStatefulWidget {
  const GeminiScreen({super.key});

  @override
  ConsumerState<GeminiScreen> createState() => _GeminiScreenState();
}

class _GeminiScreenState extends ConsumerState<GeminiScreen> {
  //?
  /**
   * 문제 입력을 위하여 콘트롤러를 선언해 줍니다. 
   */
  late final TextEditingController _messageController;
  /**
   * env directory에 저장한 apikey를 불러옵니다. 
   */
  final apiKey = dotenv.env['API_KEY'] ?? '';

  @override
  void initState() {
    /**
     * 콘트롤러를 초기화 해줍니다. 
     */
    _messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    /**
     * 다른 페이지로 이동 시 혹은 앱을 종료시 콘트롤러를 메모리에서 제거해 줍니다. 
     * dispose의 경우 다른 페이지로 이동을 할 때 실행이 되는 부분입니다. 
     * 그냥 나갈경우 콘트롤러는 계속 메모리상에 머물게 됩니다. 
     * 이러한 것들이 계속 쌓ㅇ리다 보묜 앱이 무거워지겠죠 
     */
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black87,
        title: const Text(
          'GEMINI AI',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /**
           * 전체를 statefulWidget으로 바꾸는 것은 낭비가 될 수가 있다. 
           * 이런 경우 consumer를 이용하여 필요한 부분 만을 둘러싸서 활용을 할 수가 있다. 
           */
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: () {
                /**
                 * authProvider에서 작성한 signout() 함수/메쏘드를 불러온다. 
                 */
                ref.read(authProvider).signOut();
              },
              icon: Icon(Icons.logout),
            );
          }),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  /**
                  //  const 는 변하지 않는 상수를 의미한다 고로 널 채크 시 변할 수 있는 변수에 대해서
                  //사용을 하면 에러가 발생 할 수 가 있다.  
                  */
                  Expanded(
                    child: MessagesList(
                      userId: FirebaseAuth.instance.currentUser!.uid,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 3.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Ask any Question...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SendImageScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      color: Colors.red,
                      Icons.image,
                    ),
                  ),
                  IconButton(
                    // onPressed: () async {
                    //   await ref.read(chatProvider).sendTextMessage(
                    //         apiKey: apiKey,
                    //         textPrompt: _messageController.text,
                    //       );
                    // },
                    onPressed: () {
                      sendMessage();
                    },
                    icon: Icon(
                      color: Colors.blue,
                      Icons.send,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future sendMessage() async {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;
    await ref.read(chatProvider).sendTextMessage(
          apiKey: apiKey,
          textPrompt: _messageController.text,
        );
  }
}
