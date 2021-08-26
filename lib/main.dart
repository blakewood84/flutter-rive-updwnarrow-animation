import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rive Up / Down Arrow Demo',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  SMIBool? isUp;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'Arrow state', onStateChange: _onStateChange);
    artboard.addController(controller!);
    isUp = controller.findInput<bool>('isUp') as SMIBool;
    isUp!.change(false);
  }

  void _onStateChange(
    String stateMachine, String stateName
  ) {
    print('State Machine: $stateMachine');
    print('State name: $stateName');
  }

  void togglePlay() async {
    isUp!.value = !isUp!.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                togglePlay();
              },
              child: Container(
                width: 100,
                height: 100,
                child: RiveAnimation.asset(
                  'assets/up-down-arrow.riv',
                  stateMachines: ['Arrow state'],
                  onInit: _onRiveInit,
                )
              )
            ),
          ],
        ),
      )
    );
  }
}