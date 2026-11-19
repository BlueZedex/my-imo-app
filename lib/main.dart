import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

const int appID = 1369564417;
const String appSign = "c143da3a114cb0b04113cf278f34939b0f6c08b775b54405d6e63fc9d6d7e878";

void main() => runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()));

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Imo Clone Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "আপনার নাম", border: OutlineInputBorder())),
            const SizedBox(height: 12),
            TextField(controller: phoneCtrl, keyboardType: TextInputType.phone, decoration: const InputDecoration(labelText: "ফোন নাম্বার", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (nameCtrl.text.isNotEmpty && phoneCtrl.text.isNotEmpty) {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(id: phoneCtrl.text, name: nameCtrl.text)));
                }
              },
              child: const Text("লগইন করুন"),
            )
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String id, name;
  const HomePage({super.key, required this.id, required this.name});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int diamonds = 50;
  final callCtrl = TextEditingController(text: "1001");
  final roomCtrl = TextEditingController(text: "5001");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        actions: [
          TextButton.icon(
            onPressed: () => setState(() => diamonds += 100),
            icon: const Icon(Icons.diamond, color: Colors.amber),
            label: Text("$diamonds (+100)"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: callCtrl, decoration: const InputDecoration(labelText: "কল আইডি (যেমন: 1001)", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => _openCall(false), child: const Text("অডিও কল"))),
                const SizedBox(width: 10),
                Expanded(child: ElevatedButton(onPressed: () => _openCall(true), child: const Text("ভিডিও কল"))),
              ],
            ),
            const Divider(height: 30),
            TextField(controller: roomCtrl, decoration: const InputDecoration(labelText: "ভয়েস রুম আইডি (যেমন: 5001)", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => _openRoom(true), child: const Text("হোস্ট রুম"))),
                const SizedBox(width: 10),
                Expanded(child: OutlinedButton(onPressed: () => _openRoom(false), child: const Text("শ্রোতা যোগ দিন"))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _openCall(bool video) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ZegoUIKitPrebuiltCall(
      appID: appID, appSign: appSign, userID: widget.id, userName: widget.name, callID: callCtrl.text,
      config: video ? ZegoUIKitPrebuiltCallConfig.groupVideoCall() : ZegoUIKitPrebuiltCallConfig.groupVoiceCall(),
    )));
  }

  void _openRoom(bool host) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => ZegoUIKitPrebuiltLiveAudioRoom(
      appID: appID, appSign: appSign, userID: widget.id, userName: widget.name, roomID: roomCtrl.text,
      config: host ? ZegoUIKitPrebuiltLiveAudioRoomConfig.host() : ZegoUIKitPrebuiltLiveAudioRoomConfig.audience(),
    )));
  }
}
