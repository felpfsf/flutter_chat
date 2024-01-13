import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _usermessageController = TextEditingController();

  void clearForm() {
    _usermessageController.clear();
    FocusScope.of(context).unfocus();
  }

  void _submitMessage() async {
    final enteredMessage = _usermessageController.text;

    if (enteredMessage.trim().isEmpty) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please type something...'),
          ),
        );
      }
    }

    clearForm();

    final user = FirebaseAuth.instance.currentUser!;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    await FirebaseFirestore.instance.collection('chat').add({
      'userId': user.uid,
      'text': enteredMessage,
      'createdAt': Timestamp.now(),
      'username': userData.data()!['username'],
      'userImage': userData.data()!['image_url'],
    });

    // send data to firebase

    debugPrint('🚀 ~ new message: $enteredMessage');
  }

  @override
  void dispose() {
    _usermessageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _usermessageController,
              textCapitalization: TextCapitalization.sentences,
              autocorrect: true,
              enableSuggestions: true,
              decoration: const InputDecoration(labelText: 'Send a message'),
            ),
          ),
          IconButton(
            color: Theme.of(context).colorScheme.primary,
            onPressed: _submitMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
