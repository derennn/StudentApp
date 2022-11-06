import 'package:flutter/material.dart';

class AnimationSayfasi extends StatefulWidget {
  const AnimationSayfasi({Key? key}) : super(key: key);

  @override
  State<AnimationSayfasi> createState() => _AnimationSayfasiState();
}

class _AnimationSayfasiState extends State<AnimationSayfasi> {
  Duration duration = Duration(seconds: 1);
  bool animBool = true;

  void tusaBasildi () {
    setState(() {
      animBool = !animBool;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                AnimatedContainerDeneme(animBool: animBool, duration: duration, func: tusaBasildi),
              ],
            ),
          ),
      ),
    );
  }
}

class AnimatedContainerDeneme extends StatefulWidget {
  const AnimatedContainerDeneme({
    Key? key,
    required this.animBool,
    required this.duration,
    required this.func,
  }) : super(key: key);

  final bool animBool;
  final Duration duration;
  final VoidCallback func;

  @override
  State<AnimatedContainerDeneme> createState() => _AnimatedContainerDenemeState();
}

class _AnimatedContainerDenemeState extends State<AnimatedContainerDeneme> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
              'Animation Playground',
            style: TextStyle(fontSize: 20),
          ),
          AnimatedContainer(
            height: widget.animBool ? 100 : 120,
            width: widget.animBool ? 100 : 120,
            duration: widget.duration,
            margin: EdgeInsets.only(left: widget.animBool ? 80 : 0, right: widget.animBool ? 0 : 100),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              boxShadow: widget.animBool
              ? [BoxShadow(offset: Offset(30, -30),blurStyle: BlurStyle.normal, blurRadius: 30),]
              : [BoxShadow(offset: Offset(-30,30), blurRadius: 30),],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              gradient: LinearGradient(
                begin: AlignmentDirectional.topCenter,
                end: Alignment.bottomRight,
                colors: widget.animBool
                ? [Colors.greenAccent, Colors.orangeAccent]
                : [Colors.redAccent, Colors.blueAccent],
              ),
            ),
          ),
          ElevatedButton(
              onPressed: widget.func,
              child: Text('Değiştir!'),
          )
        ],
      ),
    );
  }
}
