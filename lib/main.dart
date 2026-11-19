import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';


const int yourAppID = 1369564417;
const String yourAppSign = "https://console.firebase.google.com/project/my-imo-app-9a014/database/my-imo-app-9a014-default-rtdb/data/~2F?fb_gclid=Cj0KCQiAtvXXBhC2ARIsAJc8SURYjJVn6OKpipnzhoCz3R_811896XgUeEmNzslh0qRUgnH8YsJcOnkaAtbrEALw_wcB&fb_utm_campaign=Cloud-SS-DR-Firebase-FY26-global-gsem-1713590&fb_utm_content=text-ad&fb_utm_medium=cpc&fb_utm_source=google&fb_utm_term=KW_firebase%20spark%20plan";

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
            const Text("স্বাগতম", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "আপনার নাম লিখুন",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "ফোন নাম্বার দিন",
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
                child: const Text("লগইন করুন", style: TextStyle(fontSize: 18)),
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
  int diamonds = 50;
  final TextEditingController callIdController = TextEditingController(text: "1001");
  final TextEditingController roomIdController = TextEditingController(text: "5001");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("হ্যালো, ${widget.userName}"),
        actions: [
          TextButton.icon(
            onPressed: _showDiamondRechargeDialog,
            icon: const Icon(Icons.diamond, color: Colors.amber),
            label: Text("$diamonds", style: const TextStyle(color: Colors.black, fontSize: 16)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                        labelText: "কল আইডি দিন (যেমন: 1001)",
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
                            label: const Text("হোস্ট"),
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
                            label: const Text("শ্রোতা"),
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
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.diamond, color: Colors.amber),
                label: const Text("ডায়মন্ড রিচার্জ করুন", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange.shade800),
                onPressed: _showDiamondRechargeDialog,
              ),
            ),
          ],
        ),
        
