import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

// 
const int yourAppID = 1369564417;
const String yourAppSign = "c143da3a114cb0b04113cf278f34939b0f6c08b775b54405d6e63fc9d6d7e878";
void main() {
  runApp(const MyImoApp());
}

class MyImoApp extends StatelessWidget {
  const MyImoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Imo Clone App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const LoginScreen(),
    );
  }
}


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.video_call, size: 90, color: Colors.blue),
            const SizedBox(height: 10),
            const Text("Welcome", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Enter Your Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Enter Your Number ,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (phoneController.text.isNotEmpty && nameController.text.isNotEmpty) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          userId: phoneController.text.trim(),
                          userName: nameController.text.trim(),
                        ),
                      ),
                    );
                  }
                },
                child: const Text("Loging", style: TextStyle(fontSize: 18)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const HomeScreen({super.key, required this.userId, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int diamonds = 50; // Free Get Firt 50 Diamond
  final TextEditingController callIdController = TextEditingController(text: "1001");
  final TextEditingController roomIdController = TextEditingController(text: "5001");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hello, ${widget.userName}"),
        actions: [
          TextButton.icon(
            onPressed: () => _showDiamondRechargeDialog(),
            icon: const Icon(Icons.diamond, color: Colors.amber),
            label: Text("$diamonds", style: const TextStyle(color: Colors.white, fontSize: 16)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // অডিও ও ভিডিও কল সেকশন
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("অডিও / ভিডিও / গ্রুপ কল", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: callIdController,
                      decoration: const InputDecoration(
                        labelText: "কল আইডি বা গ্রুপ কোড দিন (যেমন: 1001)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.call),
                            label: const Text("অডিও কল"),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CallPage(
                                  callID: callIdController.text,
                                  userID: widget.userId,
                                  userName: widget.userName,
                                  isVideo: false,
                                ),
                              ));
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.videocam),
                            label: const Text("ভিডিও কল"),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => CallPage(
                                  callID: callIdController.text,
                                  userID: widget.userId,
                                  userName: widget.userName,
                                  isVideo: true,
                                ),
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // লাইভ ভয়েস ক্লাব সেকশন
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("লাইভ ভয়েস ক্লাব রুম", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    TextField(
                      controller: roomIdController,
                      decoration: const InputDecoration(
                        labelText: "রুম আইডি দিন (যেমন: 5001)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.mic),
                            label: const Text("হোস্ট হিসেবে শুরু করুন"),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => VoiceRoomPage(
                                  roomID: roomIdController.text,
                                  userID: widget.userId,
                                  userName: widget.userName,
                                  isHost: true,
                                ),
                              ));
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.headset),
                            label: const Text("শ্রোতা হিসেবে যোগ দিন"),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => VoiceRoomPage(
                                  roomID: roomIdController.text,
                                  userID: widget.userId,
                                  userName: widget.userName,
                                  isHost: false,
                                ),
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ডায়মন্ড রিচার্জ বাটন
            SizedBox(
              width: double.infinity,
              height: 55,
              
