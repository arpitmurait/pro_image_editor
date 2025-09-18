import 'package:bot_toast/bot_toast.dart';
import 'package:example/frame_example.dart';
import 'package:example/selectable_layer_example.dart';
import 'package:flutter/material.dart';

import 'frame_response.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates a new [MyApp] widget.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pro-Image-Editor',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade800,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<AttributeModel>? response;
  String frame = "";
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState(); 
    _loadAndTransformData();
  }
  
   _loadAndTransformData() async {
    var res = await _apiService.fetchFrameData();
    frame = res.$1;
    response = res.$2;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Poster"),
      ),
      body: Column(
        children: [
          ElevatedButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => FrameExample(frameUrl: frame,attributes: response!,)));
          }, child: Text("Open"))
        ],
      ),
    );
  }
}
