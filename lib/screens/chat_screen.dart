import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

   User? loggedinUser;
class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static String id = 'chat_screen.dart';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final _auth = FirebaseAuth.instance;
  late final _firestore = FirebaseFirestore.instance;
  late String messageText;
  final messageController=TextEditingController();
 

  @override
  //----------------------------------------------------------------------------------------------------------------------
  //      This code is used to get the current user
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }
//-----------------------------------------------------------------------------------------------------------------------------

  void messagesStream() {
    _firestore.collection('messages').get().then(
        (value) => print('Successfully collected'),
        onError: (e) => print('Some error ocurred'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                _auth.signOut(); // iss icon pe click karke sign out ho jaayega
                Navigator.pop(context);
                // messagesStream();
              }),
        ],
        title: Text('FireChat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 8,
            child: MessageStream(firestore: _firestore)
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      messageController.clear();
                      _firestore.collection('messages').add(
                          {'text': messageText, 'sender': loggedinUser?.email});
                    },
                    child: Text(
                      'Send',
                      style: GoogleFonts.getFont('Paytone One',
                          textStyle: TextStyle(fontSize: 15,color: Colors.red)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



//  late final currentUser;
class MessageStream extends StatelessWidget {
   MessageStream({ Key? key,required this.firestore }) : super(key: key);

 final firestore;

  @override
  //  late bool isMe;
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('messages').snapshots(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                      reverse: true,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final data =snapshot.data!.docs.reversed.toList();  
                          QueryDocumentSnapshot<Object?> data1=data[index];                       
                            return MessageBubble(
                              message: data1['text'], sender: data1['sender']);
                              
                        });
              },
            );
  }
}


class MessageBubble extends StatefulWidget {
  MessageBubble({Key? key, required this.message, required this.sender})
      : super(key: key);
  String message;
  String sender;
  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}
class _MessageBubbleState extends State<MessageBubble> {
  late bool isMe1;

  @override
  void initState() {
    check(widget.sender);
    super.initState();
  }


  void check(String sender){
     if(loggedinUser?.email==sender){
        isMe1=true;
   }
   else{
     isMe1=false;
   }
  }
  @override

  

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: isMe1?CrossAxisAlignment.end:CrossAxisAlignment.start,
        children: [
          Text(widget.sender),
          Material(
            elevation: 30,
            shadowColor: Colors.black,
            borderRadius: isMe1? BorderRadius.only(
              topLeft:Radius.circular(30), 
              bottomLeft:Radius.circular(30), 
              bottomRight:Radius.circular(20),      
              ):BorderRadius.only(
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(20)),
              color:isMe1?Colors.lightBlueAccent:Colors.blue.shade800,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: Text(
                widget.message,
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }
}
