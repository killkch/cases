import 'package:cases/gemini/models/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key, required this.message, required this.isOutGoing});

  final Message message;
  /**
   * 스위칭 역할을 해주는 불린 형 변수를 선언해 줍니다. 
   */
  final bool isOutGoing;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isOutGoing ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isOutGoing ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: isOutGoing ? Colors.white : Colors.black,
                fontSize: 16.0,
                letterSpacing: -1,
              ),
            ),
            SizedBox(height: 10),
            message.imageUrl != null
                ? Image.network(message.imageUrl!)
                : SizedBox.shrink(),
                /**
                 * 내용이나 장식이 전혀없는 위젯이다. 가장 작은 영역으로 크기가 조정됩니다. 
                 */
          ],
        ),
      ),
    );
  }
}
