import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage("https://i.pinimg.com/736x/af/29/4a/af294a2cab07ed8b0869a6edc288831c.jpg"),
          ),
        ),
        title: Text("Tory Nicholes"),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
 // ACa se trabaja el body
  @override
  Widget build(BuildContext context) {
    //ctr+. esta envuelto en una areaa segura
    
    final chatProvider = context.watch<ChatProvider>();
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal:10),
        child: Column(
          children: [
            //Expande el widget hijo a todo el espaico que el hijon de
            Expanded(
              child:ListView.builder(
                controller: chatProvider.chatScrollController,
                //itemCount: 100,
                //obtengo uandtos mensajes hay desde el provider
                itemCount: chatProvider.message.length,
                /* Como genero que se vean los mensajes sin el provider
                itemBuilder:( context, index){
                  //return MyMessageBubble();
                  return ( index % 2 == 0)
                  ? const HerMessageBubble()
                  : const MyMessageBubble();
                },*/
                //COmo genero los items con chatProvider
                itemBuilder: ( context, index){
                  final message = chatProvider.message[index];
                  return (message.fromWho == FromWho.hers)
                    ? HerMessageBubble()
                    : MyMessageBubble(message:message);
                },
                ) 
            ),
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}