// import 'dart:convert';
// import 'package:amplify_api/amplify_api.dart';

// import 'constant.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'model.dart';

// import 'models/ModelProvider.dart';

// import 'package:amplify_flutter/amplify_flutter.dart';

// // import 'package:image_picker/image_picker.dart';

// //chatpage  page
// // const yellowC = Color.fromARGB(255, 255, 213, 75);
// const yellowC = Color.fromARGB(255, 250, 192, 0);
// const backgroundColor = Color.fromARGB(255, 255, 255, 255);
// //const botBackgroundColor= Color.fromARGB(255, 46, 58, 228);

// const botBackgroundColor = Color.fromARGB(255, 56, 56, 56);

// class CchatPage extends StatefulWidget {
//   const CchatPage({super.key});

//   @override
//   State<CchatPage> createState() => _CchatPageState();
// }

// class _CchatPageState extends State<CchatPage> {
//   late bool isLoading;
//   TextEditingController _textController = TextEditingController();
//   final _scrollController = ScrollController();
//   final List<ChatMessage> _messages = [];

//   // final ImagePicker _imagePicker = ImagePicker();

//   @override
//   void initState() {
//     super.initState();
//     isLoading = false;
//   }

//     Future<void> _handleSendMessage() async {
//   final message = _textController.text;

//   setState(() {
//     _messages.add(ChatMessage(
//       text: message,
//       chatMessageType: ChatMessageType.user,
//     ));
//   });

//   // Clear the text input
//   _textController.clear();
//   _scrollDown();

//   try {
//     final newEntry = ChatPage(
//       message: message, createdAt: '12',
//     );
//     final request = ModelMutations.create(newEntry);
//     final response = await Amplify.API.mutate(request: request);
//     safePrint('Create result: $response');
//   } catch (e) {
//     // Handle error while sending message to server
//     print('Error sending message: $e');
//   }
// }

//   // Future<void> openGallery() async {
//   //   final XFile? image =
//   //       await _imagePicker.pickImage(source: ImageSource.gallery);
//   //   if (image != null) {
//   //     // Process the selected image

//   //     // File selectedImage = File(image.path);
//   //     //   return Image.file(selectedImage);

//   //     // Do something with the selected image
//   //   } else {
//   //     // User canceled the selection
//   //   }
//   // }

// //logout function
//   Future<void> _handleLogout() async {
//     try {
//       await Amplify.Auth.signOut();
//     } catch (e) {
//       // Handle sign out error
//       print('Error signing out: $e');
//     }
//   }

import 'dart:async';
import 'dart:convert';

// import 'package:amplify_api/amplify_api.dart';
// import 'package:flutter/foundation.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


import 'model.dart';

// import 'models/ModelProvider.dart';

import 'package:amplify_flutter/amplify_flutter.dart';

import 'models/ModelProvider.dart';

// import 'package:image_picker/image_picker.dart';

//chatpage  page
// const yellowC = Color.fromARGB(255, 255, 213, 75);
const yellowC = Color.fromARGB(255, 250, 192, 0);
const backgroundColor = Color.fromARGB(255, 255, 255, 255);
//const botBackgroundColor= Color.fromARGB(255, 46, 58, 228);

const botBackgroundColor = Color.fromARGB(255, 56, 56, 56);

class CchatPage extends StatefulWidget {
  const CchatPage({super.key});

  @override
  State<CchatPage> createState() => _CchatPageState();
}

class _CchatPageState extends State<CchatPage> {
  late bool isLoading;
  TextEditingController _textController = TextEditingController();
  // final _scrollController = ScrollController();

  ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];


//add msgcode and msgai to get data from database aws
  
  List<MsgCode> _budgetEntries = [];
  List<MsgAi> _msgAiEntries = [];
   String? nextToken;
  


 
   
//end

  // final ImagePicker _imagePicker = ImagePicker();

//getuserName
  @override
  void initState() {
    super.initState();
    isLoading = false;
    _refreshBudgetEntries();
    getCurrentUser();
  }

  AuthUser? _user;

//backend get data
//  Future<void> _refreshBudgetEntries() async {
//     try {
//       final request = ModelQueries.list(MsgCode.classType);

//       final response = await Amplify.API.query(request: request).response;

//       final todos = response.data?.items;
//       if (response.hasErrors) {
//         safePrint('errors: ${response.errors}');
//         return;
//       }
//       setState(() {
//         //  _budgetEntries = todos!.whereType<MsgCode>().toList();
// _budgetEntries = todos!
//     .whereType<MsgCode>()
//     .toList()
//     ..sort((a, b) {
//       if (a.createdAt == null && b.createdAt == null) {
//         return 0;
//       } else if (a.createdAt == null) {
//         return 1;
//       } else if (b.createdAt == null) {
//         return -1;
//       } else {
//         return a.createdAt!.compareTo(b.createdAt!);
//       }
//     });

//       });
//     } on ApiException catch (e) {
//       safePrint('Query failed: $e');
//     }
//   }

// Future<void> _refreshBudgetEntries() async {
//   try {
//     final request = ModelQueries.list(MsgCode.classType);
//     final response = await Amplify.API.query(request: request).response;

//     final todos = response.data?.items;
//     if (response.hasErrors) {
//       safePrint('errors: ${response.errors}');
//       return;
//     }

//     setState(() {
//       _budgetEntries = todos!
//           .whereType<MsgCode>()
//           .toList()
//             ..sort((a, b) {
//               if (a.createdAt == null && b.createdAt == null) {
//                 return 0;
//               } else if (a.createdAt == null) {
//                 return 1;
//               } else if (b.createdAt == null) {
//                 return -1;
//               } else {
//                 return a.createdAt!.compareTo(b.createdAt!);
//               }
//             });
//     });
//   } on ApiException catch (e) {
//     safePrint('Query failed: $e');
//   }
// }




//   Future<void> _refreshBudgetEntries() async {
//     try {
//       final request1 = ModelQueries.list(MsgCode.classType);
     
//       final response1 = await Amplify.API.query(request: request1).response;

//       final request2 = ModelQueries.list(MsgAi.classType);
//       final response2 = await Amplify.API.query(request: request2).response;

//       final todos1 = response1.data?.items;
//       final todos2 = response2.data?.items;

//       if (response1.hasErrors) {
//         safePrint('errors: ${response1.errors}');
//         return;
//       }

//       if (response2.hasErrors) {
//         safePrint('errors: ${response2.errors}');
//         return;
//       }

//       // setState(() {
        
//       //   _budgetEntries = todos1!.whereType<MsgCode>().toList()
//       //     ..sort((a, b) {
//       //       if (a.createdAt == null && b.createdAt == null) {
//       //         return 0;
//       //       } else if (a.createdAt == null) {
//       //         return 1;
//       //       } else if (b.createdAt == null) {
//       //         return -1;
//       //       } else {
//       //         return a.createdAt!.compareTo(b.createdAt!);
//       //       }
//       //     });

//       //   //Additional logic for MsgAi data
//       //   _msgAiEntries = todos2!.whereType<MsgAi>().toList()
//       //     ..sort((a, b) {
//       //       if (a.createdAt == null && b.createdAt == null) {
//       //         return 0;
//       //       } else if (a.createdAt == null) {
//       //         return 1;
//       //       } else if (b.createdAt == null) {
//       //         return -1;
//       //       } else {
//       //         return a.createdAt!.compareTo(b.createdAt!);
//       //       }
//       //     });
//       // });


//       setState(() {
//   _budgetEntries = todos1!
//       .whereType<MsgCode>()
//       .where((msg) => msg.createdAt != null)
//       .toList()
//         ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      
//   _msgAiEntries = todos2!
//       .whereType<MsgAi>()
//       .where((msg) => msg.createdAt != null)
//       .toList()
//         ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
// });

// safePrint('$response1');

//       // _scrollController.animateTo(
//       //   0.0,
//       //   duration: Duration(milliseconds: 300),
//       //   curve: Curves.easeInOut,
//       // );
//     } on ApiException catch (e) {
//       safePrint('Query failed: $e');
//     }
//   }


    // final toto = await Amplify.DataStore.query(MsgCode.classType);
    //   setState(() {
    //     final allItems = toto;
    //     safePrint('$allItems');
    //   });


Future<void> _refreshBudgetEntries() async {
    try {
      
      // final request1 = ModelQueries.list(MsgCode.classType);
      // final response1 = await Amplify.API.query(request: request1).response;
      // final request2 = ModelQueries.list(MsgAi.classType);
      // final response2 = await Amplify.API.query(request: request2).response;



  // final firstRequest = ModelQueries.list<MsgCode>(MsgCode.classType, limit: 100000);
  // final firstResult = await Amplify.API.query(request: firstRequest).response;
  // final firstPageData = firstResult.data;

      final request1 = ModelQueries.list<MsgCode>(MsgCode.classType,limit:null);
      final response1 = await Amplify.API.query(request: request1).response;
      final request2 = ModelQueries.list<MsgAi>(MsgAi.classType, limit :null);
      final response2 = await Amplify.API.query(request: request2).response;

    
   if (response1.hasErrors) {
        safePrint('errors: ${response1.errors}');
        return;
      }

      if (response2.hasErrors) {
        safePrint('errors: ${response2.errors}');
        return;
      }

      final todos1 = response1.data?.items.cast<MsgCode>() ?? [];
      final todos2 = response2.data?.items.cast<MsgAi>() ?? [];
      // final resultt = firstPageData?.items ?? <MsgCode?>[];


      setState(() {
        _budgetEntries = todos1;
            // .where((msg) => msg.createdAt != null)
            // .toList()
            //   ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

        _msgAiEntries = todos2;
            // .where((msg) => msg.createdAt != null)
            // .toList()
            //   ..sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      });
        
      //safePrint('resuliiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiillt $todos1');
    } on ApiException catch (e) {
      safePrint('Query failed: $e');
    }
  }










//end of get data

//test delete

  // Future<void> _deleteBudgetEntry(MsgCode budgetEntry) async {
  //   final request = ModelMutations.delete<MsgCode>(budgetEntry);
  //   final response = await Amplify.API.mutate(request: request).response;
  //   safePrint('Delete response: $response');
  //   await _refreshBudgetEntries();
  // }






//get current user name 
  void getCurrentUser() async {
    try {
      final currentUser =
          await Amplify.Auth.getCurrentUser() as CognitoAuthUser;
      setState(() {
        _user = currentUser;
      });
    } catch (e) {
      print('Error getting current user: $e');
    }
  }
  
  //end of getuserName

  Future<void> handleSubmit() async {

   
    setState(() {
      _messages.add(
        ChatMessage(
          text: _textController.text,
          chatMessageType: ChatMessageType.user,
        ),
      );
      isLoading = true;
    });

    var input = _textController.text;
    _textController.clear();


    //   setState(() {
    //   _chatHistory.add('User: $message');
    // });
    // Future.delayed(Duration(milliseconds: 50)).then((value) => _scrollDown());

    generateResponse(input).then((value) async {
      setState(() {

        isLoading = false;
        _messages.add(
          ChatMessage(
            text: value,
            chatMessageType: ChatMessageType.bot,
          
          ),
        );
      });

      
      final newMsgAi = MsgAi(message: value);
      final request = ModelMutations.create(newMsgAi);
      final response = await Amplify.API.mutate(request: request).response;
      safePrint('Create result Ai: $response');
      _refreshBudgetEntries();
      summarizeConversation();
      
       

      // print('Response from generateResponse: $lastFiveMsgAiMessage');
    });


    //  try {
    //   final reply = await generateResponse(input);
    //   setState(() {
    //     _messages.add('Bot: $reply' as ChatMessage );
    //   });
    // } catch (e) {
    //   setState(() {
    //     _messages.add('Error: Failed to communicate with the chatbot' as ChatMessage);
    //   });
    // }






    final newMsg = MsgCode(message: input);
    final request = ModelMutations.create(newMsg);
    final response = await Amplify.API.mutate(request: request).response;
    safePrint('Create result: $response');
   
    _textController.clear();

     _refreshBudgetEntries();
    //  summarizeConversation();
    // Future.delayed(Duration(milliseconds: 50)).then((value) => _scrollDown());
  }

  // Future<void> openGallery() async {
  //   final XFile? image =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if (image != null) {
  //     // Process the selected image

  //     // File selectedImage = File(image.path);
  //     //   return Image.file(selectedImage);

  //     // Do something with the selected image
  //   } else {
  //     // User canceled the selection
  //   }
  // }

//logout function
  Future<void> _handleLogout() async {
    try {
      await Amplify.Auth.signOut();
    } catch (e) {
      // Handle sign out error
      print('Error signing out: $e');
    }
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }

  // Future<String> generateResponse1(String prompt) async {
  //   final apiKey = apiSecretKey;
  //   var url = Uri.https("api.openai.com", "/v1/completions");
  //   final response = await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $apiKey'
  //       },
  //       body: jsonEncode({
  //         'model': 'text-davinci-003',
  //         //  'model':'gpt-3.5-turbo',
  //         'prompt': prompt,
  //         'temperature': 0,
  //         'max_tokens': 100,
  //         'top_p': 1,
  //         'frequency_penalty': 0.0,
  //         'presence_penalty': 0.0
  //       }));
  //   Map<String, dynamic> newresponse = jsonDecode(response.body);
  //   return newresponse['choices'][0]['text'];
  // }


// Future<String> generateResponse(String message) async {



// final List<MsgAi> lastFiveMsgAiEntries = _msgAiEntries.length > 5
//     ? _msgAiEntries.sublist(_msgAiEntries.length - 5)
//     : _msgAiEntries;

// final List<Map<String, dynamic>> messages = [
//   {'role': 'system', 'content': lastFiveMsgAiEntries},
//   {'role': 'user', 'content': message},
// ];
  
//   final response = await http.post(
//     Uri.parse('https://api.openai.com/v1/chat/completions'),
//     headers: {
//       'Authorization': 'Bearer $apiSecretKey',
//       'Content-Type': 'application/json',
//     },
//     body: jsonEncode({
//       'model': 'gpt-3.5-turbo',
//       'messages': [{'role': 'system', 'content':messages}, {'role': 'user', 'content': message}],
//     }),
//   );

//   if (response.statusCode == 200) {
//     final data = jsonDecode(response.body);
//     final reply = data['choices'][0]['message']['content'];
//     return reply;
//   } else {
//     throw Exception('Failed to communicate with the chatbot API');
//   }
// }




// String capitalize(String input) {
//   if (input.isEmpty) {
//     return input;
//   }
//   return input[0].toUpperCase() + input.substring(1);
// }

Future<String> summarizeConversation() async {


  // final List<String> messages = _msgAiEntries.length > 5
  //   ? _msgAiEntries.sublist(_msgAiEntries.length - 5).map((msgAi) => msgAi.message).toList()
  //   : _msgAiEntries.map((msgAi) => msgAi.message).toList();

final List<String> messages = _msgAiEntries.map((msgAi) => msgAi.message).toList();

  // List<dynamic> messages = await getConversation(userId);


// safePrint('$messages');


  // String formattedMessages = messages as String;
    // .map((msg) => '${capitalize(msg['role'].toString())}: ${msg['content']}')
    //   .join('\n');

  String prompt =
      'Extract the name, age, interests,demographic, and other important pieces of information from the conversation. If the name and age already exist, ignore them. Add any details that do not exist in the summary. Also, summarize the traits and sentiment of the userin the following conversation:\n\n$messages\n\nSummary:';

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Authorization': 'Bearer $apiSecretKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      // 'model': 'gpt-4',

      'model': 'gpt-3.5-turbo',
      'messages': [
        {'role': 'system', 'content': prompt},
      ],
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final summary = data['choices'][0]['message']['content'];
    safePrint('summary output : $summary');
    return summary.trim();
   
    

  } else {
    throw Exception('Failed to communicate with the chatbot API SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
  }
}

Future<void> deleteAllItems() async {
  try {
    // Delete items from the MsgAi table
    final msgAiItems = await Amplify.DataStore.query(MsgAi.classType);
    for (final item in msgAiItems) {
      await Amplify.DataStore.delete(item);
    }

    // Delete items from the MsgCode table
    final msgCodeItems = await Amplify.DataStore.query(MsgCode.classType);
    for (final item in msgCodeItems) {
      await Amplify.DataStore.delete(item);
    }

    print('All items deleted successfully.');
  } catch (e) {
    print('Error deleting items: $e');
  }
}

Future<String> generateResponse(String message) async {
  
  // final List<MsgAi> lastFiveMsgAiEntries = _msgAiEntries.length > 5
  //     ? _msgAiEntries.sublist(_msgAiEntries.length - 5)
  //     : _msgAiEntries;


  // final List<Map<String, dynamic>> messages = [

  //   {'role': 'system', 'content': "i"},
  //   {'role': 'user', 'content': message},
  // ];

// final List<String> lastFiveMsgAiMessages =  message as List<String>;


// final List<String> lastFiveMsgAiMessages = _msgAiEntries.length > 5
//     ? _msgAiEntries.sublist(_msgAiEntries.length - 5).map((msgAi) => msgAi.message).toList()
//     : _msgAiEntries.map((msgAi) => msgAi.message).toList();

final List<String> allMmessages = _msgAiEntries.map((msgAi) => msgAi.message).toList();


// print(lastFiveMsgAiMessages);
  final List<Map<String, dynamic>> messages = [
     for (final msg in allMmessages)
    {'role': 'assistant', 'content': msg},
      // {'role': 'assistant', 'content':'i am Steve Jobs'},
    {'role': 'user', 'content': message},
  
  ];

  final response = await http.post(
    Uri.parse('https://api.openai.com/v1/chat/completions'),
    headers: {
      'Authorization': 'Bearer $apiSecretKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'gpt-3.5-turbo',
      'messages': messages,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final reply = data['choices'][0]['message']['content'];
    return reply;
  } else {
    throw Exception('Failed to communicate with the chatbot API');
  }
}





  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(



appBar: AppBar(
  centerTitle: true,
  backgroundColor: backgroundColor,
  
  title:      Text(
        _user != null ? "Welcome ${capitalizeFirstLetter(_user!.username)}" : 'App Title',
        style: const TextStyle(color: botBackgroundColor),
      ),
  // title: Row(
  //   mainAxisAlignment: MainAxisAlignment.center,
    
  //     children: [
  //     Text(
  //       _user != null ? "Welcome ${capitalizeFirstLetter(_user!.username)}" : 'App Title',
  //       style: const TextStyle(color: botBackgroundColor),
  //     ),
    
  //   ],
  // ),
  actions: [
    IconButton(
      icon: const Icon(
        Icons.logout_outlined,
        color: Colors.red,
   
      ),
      
      onPressed: _handleLogout,
    ),
  ],
),










      // appBar: AppBar(
      //   // toolbarHeight: 10,

      //   title: Align(
      //     alignment: Alignment.centerLeft,
      //     child: Text(
      //       style: TextStyle(color: botBackgroundColor),
      //       _user != null
      //           ? "Welcome " + capitalizeFirstLetter(_user!.username)
      //           : 'App Title',
      //     ),
      //   ),

      //   backgroundColor: backgroundColor,
      //   leading:
      //       // ElevatedButton(
      //       //     onPressed: _handleLogout,
      //       //     child: const Text('Sign Out'),
      //       //   ),
      //       // IconButton(
      //       //   icon: Icon(
      //       //     Icons.arrow_back_ios_new_rounded,
      //       //     color: yellowC, // Set the color of the back button
      //       //   ),
      //       //   // onPressed: () {
      //       //   // Navigator.pop(context);
      //       //   onPressed: _handleLogout,

      //       //   // Handle back button press
      //       //   //},
      //       // ),

      //       // IconButton(
      //       //      icon: Icon(
      //       //      Icons.arrow_back_ios_new_rounded,
      //       //       color: yellowC,
      //       //       // Set the color of the back button
      //       //      ),

      //       //     onPressed: _handleLogout
      //       //   ),
      //       Align(
      //           alignment: Alignment.centerRight,
      //           child: IconButton(
      //               icon: const Expanded(
      //                 child: Row(
      //                   children: [
      //                     Icon(
      //                       Icons.logout_outlined,
      //                       color: botBackgroundColor,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               onPressed: _handleLogout)),
      // ),
      backgroundColor: backgroundColor,
      body: Column(children: [
        Expanded(
          child: _buildList(),
        ),

//loading
        // Visibility(
        //   visible: isLoading,
        //   child: const Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: CircularProgressIndicator(
        //       color: botBackgroundColor,
        //     ),
        //   ),
        // ),

        Container(
            padding: EdgeInsets.all(8.0),
// Set the desired padding values
            child: Row(
              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Container(
                //   // padding: EdgeInsets.zero,
                //   //  margin: EdgeInsets.zero,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     color: botBackgroundColor,
                //   ),

                //   child: Center(
                //     child: PopupMenuButton<String>(
                //       color: Colors.transparent,
                //       elevation: 0,
                //       offset:
                //           Offset(0, -MediaQuery.of(context).size.height * 0.26),
                //       icon: const Icon(
                //         Icons.add_circle_outline_sharp,
                //         color: Color.fromARGB(255, 255, 255, 255),
                //       ),
                //       itemBuilder: (BuildContext context) =>
                //           <PopupMenuEntry<String>>[
                //         PopupMenuItem<String>(
                //           padding: EdgeInsets.zero,
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: yellowC,
                //               border: Border.all(
                //                 color: botBackgroundColor,
                //                 width: 3.0,
                //               ),
                //               shape: BoxShape.circle, // Use circular shape
                //             ),
                //             child: IconButton(
                //               icon: Icon(Icons.mms_rounded),
                //               color: botBackgroundColor,
                //               onPressed: () {
                //                 // Handle the button press event
                //                 // openGallery();
                //               },
                //             ),
                //           ),
                //           value: 'gallery',
                //         ),
                //         PopupMenuDivider(),

                //         // PopupMenuItem<String>(

                //         //   child: Container(
                //         //     decoration: BoxDecoration(
                //         //       border: Border.all(
                //         //         color: botBackgroundColor,
                //         //         width: 3.0,
                //         //       ),
                //         //       borderRadius: BorderRadius.circular(10.0),
                //         //     ),
                //         //     child: ListTile(
                //         //       leading: Icon(Icons.mms_rounded),
                //         //       // title: Text('Gallery'),

                //         //       //  subtitle: Text('Select from gallery'),
                //         //       // trailing: Icon(Icons.arrow_forward),
                //         //       tileColor: yellowC, // Change the color to yellow
                //         //     ),

                //         //     // child: Text('Option 1'),
                //         //   ),
                //         //   value: 'gallery',
                //         // ),

                //         PopupMenuItem<String>(
                //           padding: EdgeInsets.zero,
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: yellowC,
                //               border: Border.all(
                //                 color: botBackgroundColor,
                //                 width: 3.0,
                //               ),
                //               shape: BoxShape.circle, // Use circular shape
                //             ),
                //             child: IconButton(
                //               icon: Icon(
                //                 Icons.my_library_books_outlined,
                //                 color: botBackgroundColor,
                //               ),
                //               onPressed: null,
                //             ),
                //           ),

                //           value: 'option2',
                //           // child: Text('Option 2'),
                //         ),

                //         PopupMenuDivider(),

                //         // PopupMenuItem<String>(
                //         //   value: 'gallery',
                //         //   child: Container(
                //         //     decoration: BoxDecoration(
                //         //       border: Border.all(
                //         //         color: Colors.black,
                //         //         width: 1.0,
                //         //       ),
                //         //       borderRadius: BorderRadius.circular(10.0),
                //         //     ),
                //         //     child: ListTile(
                //         //       leading: Icon(Icons.mms_rounded),
                //         //       title: Text('Gallery'),
                //         //       tileColor: Colors.yellow,
                //         //     ),
                //         //   ),
                //         // ),

                //         //popupitem3

                //         PopupMenuItem<String>(
                //           padding: EdgeInsets.zero,
                //           child: Container(
                //             decoration: BoxDecoration(
                //               color: yellowC,
                //               border: Border.all(
                //                 color: botBackgroundColor,
                //                 width: 3.0,
                //               ),
                //               shape: BoxShape.circle, // Use circular shape
                //             ),
                //             child: IconButton(
                //               icon: Icon(
                //                 Icons.near_me_outlined,
                //                 color: botBackgroundColor,
                //               ),
                //                onPressed: null,
                //             ),
                //           ),
                //           value: 'option3',
                //           // child: Text('Option 2'),
                //         ),
                //       ],
                //       onSelected: (String value) {
                //         if (value == 'gallery') {
                //           // openGallery();
                //         }
                //       },
                //     ),
                //   ),
                // ),
                _buildInput(),
                _buildSubmit(),
              ],
            ))
      ]),
    ));
  }
// Expanded _buildInput(){
//   return Expanded(

//     child: Row(

//       children: [

//    Expanded(

//    child: Padding(
//     padding: EdgeInsets.all(8.0),

//     child: TextField(

//       textCapitalization: TextCapitalization.sentences,
//       style: const TextStyle(color: Color.fromRGBO(15, 15, 15, 1)),
//       controller:_textController ,

//         decoration:

//          InputDecoration(

//     filled: true,
//     fillColor: Color.fromARGB(255, 238, 238, 238),
//     hintText:"chat with dost bot" ,
//     hintStyle: TextStyle(
//         color: Color.fromARGB(198, 31, 31, 31),
//     ),

//     enabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.white,
//         width: 0,

//       ),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.white,
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     errorBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.white,
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(20),
//     ),
//     disabledBorder: OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.white,
//         width: 1,
//       ),
//       borderRadius: BorderRadius.circular(20),
//     ),
//   ),

//       // decoration: const InputDecoration(

//       //   fillColor:botBackgroundColor,
//       //   filled: true,
//       //   border: InputBorder.none,
//       //   focusedBorder: InputBorder.none,
//       //   enabledBorder: InputBorder.none,
//       //   errorBorder: InputBorder.none,
//       //   disabledBorder: InputBorder.none
//       //    ),
//   ),),)

// //   Container(

// //       decoration: BoxDecoration(
// //     shape: BoxShape.circle,
// // color: botBackgroundColor,
// //    ),

// //     child: Center(
// //  child: PopupMenuButton<String>(

// //           icon: const Icon(Icons.add_circle_outline_sharp,color: Color.fromARGB(255, 255, 255, 255),  ),
// //           itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[

// //             const PopupMenuItem<String>(

// //                 child: ListTile(

// //             leading: Icon(Icons.mms_rounded  ), title:Text('Gallery'),
// //            ),

// //               value: 'option1',
// //               // child: Text('Option 1'),
// //             ),
// //             const PopupMenuItem<String>(
// //               child: ListTile(

// //             leading: Icon(Icons.my_library_books_outlined  ),
// //             title:Text('Document'),
// //            ),
// //               value: 'option2',
// //               // child: Text('Option 2'),
// //             ),

// //             //popupitem3

// //             const PopupMenuItem<String>(

// //                 child: ListTile(
// //                   title: Text('Location'),
// //             leading: Icon(Icons.near_me_outlined  ),
// //            ),
// //               value: 'option1',
// //               // child: Text('Option 1'),
// //             ),

// //           ],
// //           onSelected: (String value) {
// //             // Handle menu item selection
// //           },
// //         ),),)

//       ],
//     ),
//   );

  Expanded _buildInput() {
    return Expanded(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 238, 238, 238),
                  borderRadius: BorderRadius.circular(20),

                  //box shadow for text box field

                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey.withOpacity(0.5),
                  //     spreadRadius: 2,
                  //     blurRadius: 5,
                  //     offset: Offset(0, 3),
                  //   ),
                  // ],
                ),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  style: const TextStyle(color: Color.fromRGBO(15, 15, 15, 1)),
                  controller: _textController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(255, 255, 255, 255),
                    hintText: "Chat with dost bot",
                    hintStyle: TextStyle(
                      color: Color.fromARGB(198, 31, 31, 31),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: botBackgroundColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: botBackgroundColor,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmit() {
    return Visibility(
      visible: !isLoading,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: botBackgroundColor,
            width: 3,
          ),
          shape: BoxShape.circle,
          color: yellowC,
        ),
        child: IconButton(
            icon: Transform.rotate(
              angle: -45 * 3.1415926535 / 180,
              child: Icon(
                Icons.send,
                color: botBackgroundColor,
                size: 20.0,
              ),
            ),
            onPressed: () {
        
              handleSubmit();
              _refreshBudgetEntries();
              

            }
            //  () {

            //   setState(() {

            //     _messages.add(ChatMessage(
            //         text: _textController.text,
            //         chatMessageType: ChatMessageType.user));
            //     isLoading = true;

            //   });
            //   var input = _textController.text;
            //   _textController.clear();
            //   Future.delayed(Duration(milliseconds: 50))
            //       .then((value) => _scrollDown());

            //   generateResponse(input).then((value) {
            //     setState(() {
            //       isLoading = false;
            //       _messages.add(ChatMessage(
            //           text: value, chatMessageType: ChatMessageType.bot));
            //     });
            //   });
            //   _textController.clear();
            //   Future.delayed(Duration(milliseconds: 50))
            //       .then((value) => _scrollDown());
            // },
            ),
      ),
    );
  }

  // void _scrollDown() {
  //   _scrollController.animateTo(
  //     _scrollController.position.maxScrollExtent,
  //     duration: Duration(milliseconds: 300),
  //     curve: Curves.easeOut,
  //   );
  // }

// void _scrollUp() {
//   _scrollController.animateTo(
//     0,
//     duration: Duration(milliseconds: 300),
//     curve: Curves.easeOut,
//   );
// }

  // ListView _buildList() {
  //   return ListView.builder(
  //     itemCount: _messages.length,
  //     controller: _scrollController,
  //     itemBuilder: (context, index) {
  //       var message = _messages[index];
  //       return ChatMessageWidget(
  //         text: message.text,
  //         chatMessageType: message.chatMessageType,
  //       );
  //     },
  //   );
  // }

// ListView _buildList() {

//   return ListView.builder(
//     itemCount: _budgetEntries.length + _msgAiEntries.length,
//     controller: _scrollController,
//     itemBuilder: (context, index) {
//       if (index < _budgetEntries.length) {
//         // User sent message
//         final budgetEntry = _budgetEntries[index];
//         return _buildBudgetEntryItem(budgetEntry);
//       } else {
//         // AI reply message
//         final aiIndex = index - _budgetEntries.length;
//         final aiEntry = _msgAiEntries[aiIndex];
//         return _buildMsgAiItem(aiEntry);
//       }
//     },
//   );
// }

// Widget _buildBudgetEntryItem(MsgCode budgetEntry) {
//   return Dismissible(
//     key: ValueKey(budgetEntry),
//     background: const ColoredBox(
//       color: Colors.red,
//       child: Padding(
//         padding: EdgeInsets.only(right: 10),
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Icon(Icons.delete, color: Colors.white),
//         ),
//       ),
//     ),
//     onDismissed: (_) => _deleteBudgetEntry(budgetEntry),
//     child: ListTile(
//       title: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           margin: const EdgeInsets.symmetric(vertical: 5),
//           decoration: BoxDecoration(
//             color: Colors.blue,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Text(
//               budgetEntry.message,
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildMsgAiItem(MsgAi aiEntry) {

//   // Customize the UI for AI reply messages
//   return ListTile(
//     title: Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         decoration: BoxDecoration(
//           color: Colors.green,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             aiEntry.message,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   );
// }

// ListView _buildList() {
//   return ListView.builder(
//     itemCount: _budgetEntries.length + _msgAiEntries.length,
//     controller: _scrollController,
//     itemBuilder: (context, index) {
//       if (index < _budgetEntries.length) {
//         // User sent message
//         final budgetEntry = _budgetEntries[index];
//         return Dismissible(
//           key: ValueKey(budgetEntry),
//           background: const ColoredBox(
//             color: Colors.red,
//             child: Padding(
//               padding: EdgeInsets.only(right: 10),
//               child: Align(
//                 alignment: Alignment.centerRight,
//                 child: Icon(Icons.delete, color: Colors.white),
//               ),
//             ),
//           ),
//           onDismissed: (_) => _deleteBudgetEntry(budgetEntry),
//           child: ListTile(
//             title: Align(
//               alignment: Alignment.centerRight,
//               child: Container(
//                 margin: const EdgeInsets.symmetric(vertical: 5),
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10),
//                   child: Text(
//                     budgetEntry.message,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       } else {
//         // AI reply message
//         final aiIndex = index - _budgetEntries.length;
//         final aiEntry = _msgAiEntries[aiIndex];
//         return ListTile(
//           title: Align(
//             alignment: Alignment.centerLeft,
//             child: Container(
//               margin: const EdgeInsets.symmetric(vertical: 5),
//               decoration: BoxDecoration(
//                 color: Colors.green,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10),
//                 child: Text(
//                   aiEntry.message,
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         );
//       }
//     },
//   );
// }

  ListView _buildList() {
    final allMessages = [..._budgetEntries, ..._msgAiEntries];
    // allMessages.sort((a, b) {
    //   final acreatedAt = (a is MsgCode) ? a.createdAt : (a is MsgAi) ? a.createdAt : null;
    //   final bcreatedAt = (b is MsgCode) ? b.createdAt : (b is MsgAi) ? b.createdAt : null;

    //   if (acreatedAt == null && bcreatedAt == null) {
    //     return 0;
    //   } else if (acreatedAt == null) {
    //     return 1;
    //   } else if (bcreatedAt == null) {
    //     return -1;
    //   } else {
    //     return acreatedAt.compareTo(bcreatedAt);
    //   }
    // });

    allMessages.sort((a, b) {
      final acreatedAt = (a is MsgCode)
          ? a.createdAt
          : (a is MsgAi)
              ? a.createdAt
              : null;
      final bcreatedAt = (b is MsgCode)
          ? b.createdAt
          : (b is MsgAi)
              ? b.createdAt
              : null;

      if (acreatedAt == null && bcreatedAt == null) {
        return 0;
      } else if (acreatedAt == null) {
        return 1;
      } else if (bcreatedAt == null) {
        return -1;
      } else {
        return bcreatedAt.compareTo(acreatedAt); // Reversed order here
      }
    }
    );

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollToBottom();
    // });

    return ListView.builder(
      reverse: true,
      itemCount: allMessages.length,
      controller: _scrollController,
      itemBuilder: (context, index) {
        final message = allMessages[index];

        if (message is MsgCode) {
          // User sent message
          final budgetEntry = message;
          return Dismissible(
            key: ValueKey(budgetEntry),
            background: const ColoredBox(
              color: Colors.red,
              child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
            // onDismissed: (_) => _deleteBudgetEntry(budgetEntry),
            child: ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: botBackgroundColor,
                      width: 3,
                    ),
                    color: yellowC,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      // topRight: Radius.circular(12),
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      budgetEntry.message,
                      style: TextStyle(color: botBackgroundColor,
                      
                       fontWeight: FontWeight.w500,
                      ),
                      
                    ),
                  ),
                ),
              ),
            ),
          );
        } else if (message is MsgAi) {
          // AI reply message
          final aiEntry = message;

          return ListTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                // decoration: BoxDecoration(
                //   color: Colors.green,
                //   borderRadius: BorderRadius.circular(10),
                // ),

                decoration: BoxDecoration(
                  border: Border.all(
                    color: botBackgroundColor,
                    width: 3,
                  ),
                  color: Color.fromRGBO(233, 233, 233, 1),
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(12),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),

                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    aiEntry.message.trim(),
                    style: TextStyle(color: botBackgroundColor,

                            fontWeight: FontWeight.w500,
                          ),

                  ),
                ),
              ),
            ),
          );
        }
        return SizedBox.shrink(); // Placeholder if the message type is unknown
      },
    );
  }
  


// void _scrollToBottom() {
//   if (_scrollController.hasClients) {
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: Duration(milliseconds: 30),
//       curve: Curves.easeInOut,
//     );
//   }
// }

//  ListView _buildList() {
// return ListView.builder(
//   // reverse: true,
//   itemCount: _budgetEntries.length,
//   controller: _scrollController,
//   itemBuilder: (context, index) {
//     final budgetEntry = _budgetEntries[index];

// return Dismissible(
//   key: ValueKey(budgetEntry),
//   background: const ColoredBox(
//     color: Colors.red,
//     child: Padding(
//       padding: EdgeInsets.only(right: 10),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Icon(Icons.delete, color: Colors.white),
//       ),
//     ),
//   ),
//   onDismissed: (_) => _deleteBudgetEntry(budgetEntry),
//   child: ListTile(
//     title: Align(
//       alignment: Alignment.centerRight, // Align chat messages to the right
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 5),
//         decoration: BoxDecoration(
//           color: Colors.blue,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(10),
//           child: Text(
//             budgetEntry.message,
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     ),
//   ),
// );

//   },
// );
//  }
}

// class ChatMessageWidget extends StatelessWidget {

//   final String text;
//   final ChatMessageType chatMessageType;

//   const ChatMessageWidget(
//       {super.key, required this.text, required this.chatMessageType});

//   @override
//   Widget build(BuildContext context) {

//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 0),
//       padding: EdgeInsets.all(6),
//       color: chatMessageType == ChatMessageType.bot
//           ? backgroundColor
//           : backgroundColor,
//       child: Row(
//         children: [

//           Expanded(
//             child: Column(
//               crossAxisAlignment: chatMessageType == ChatMessageType.bot
//                   ? CrossAxisAlignment.start
//                   : CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(5),

//                   margin: EdgeInsets.only(
//                     right: chatMessageType == ChatMessageType.bot ? 20.0 : 20.0,
//                     left: chatMessageType == ChatMessageType.bot ? 20.0 : 20.0,
//                   ),

//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: botBackgroundColor,
//                       width: 3,
//                     ),
//                     color: chatMessageType == ChatMessageType.bot
//                         ? Color.fromARGB(255, 238, 238, 238)
//                         : yellowC,

//                     borderRadius: chatMessageType == ChatMessageType.bot
//                         ? BorderRadius.only(
//                             // topLeft: Radius.circular(12),
//                             topRight: Radius.circular(30),
//                             bottomRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                           )
//                         : BorderRadius.only(
//                             topLeft: Radius.circular(30),
//                             // topRight: Radius.circular(12),
//                             bottomRight: Radius.circular(30),
//                             bottomLeft: Radius.circular(30),
//                           ),
//                   ),

//                   child: Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Text(
//                       text.trim(),
//                       style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                             fontSize: 15,
//                             color: chatMessageType == ChatMessageType.bot
//                                 ? Color.fromARGB(255, 58, 58, 58)
//                                 : Color.fromARGB(255, 0, 0, 0),
//                             fontWeight: FontWeight.w800,
//                           ),
//                     ),
//                   ),

//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
