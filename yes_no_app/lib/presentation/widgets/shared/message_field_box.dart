import 'package:flutter/material.dart';

class MessageFieldBox extends StatelessWidget {
  final ValueChanged<String> onValue;

  const MessageFieldBox({
    super.key,
    required this.onValue
  });

  @override
  Widget build(BuildContext context) {
    
    final textController = TextEditingController();
    //para el focus del input
    final focusNode = FocusNode();

    final outlineInputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(40)
    );

    final inputDecoration = InputDecoration(
        hintText: 'End your message with a "??"',
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        filled: true,
        suffixIcon: IconButton(
          icon:Icon(Icons.send_outlined),
          onPressed: (){
            final textValue = textController.value.text;
            print('button: $textValue');
            textController.clear();
            onValue(textValue);
          },
          ),
        
    );

    return TextFormField(
      //
      onTapUpOutside: (event) {
        focusNode.unfocus();
      },
      focusNode: focusNode,
      controller: textController,
      decoration: inputDecoration,
      onFieldSubmitted: ( value ){
        print('Submit value $value');
        //asi limpia la caja de texto
        textController.clear();
        // Se mantine el focus a media que escribas y pulses enter
        focusNode.requestFocus();
        onValue(value);
      }, 
      /*
      onChanged: (value) {
        print('Changed: $value');
      },*/
    );
  }
}