import 'package:flutter/material.dart';

class AnimationSayfasi extends StatefulWidget {
  const AnimationSayfasi({Key? key}) : super(key: key);

  @override
  State<AnimationSayfasi> createState() => _AnimationSayfasiState();
}

class _AnimationSayfasiState extends State<AnimationSayfasi> {
  Duration duration = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AnimatedContainerDeneme(duration: duration),
              AnimatedPaddingDeneme(duration: duration),
              AnimatedCrossFadeDeneme(duration: duration),
              const HeroWidgetDenemeButonu(),
              SliderIleExplicitAnimation(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

class SliderIleExplicitAnimation extends StatefulWidget {
  const SliderIleExplicitAnimation({
    Key? key,
  }) : super(key: key);

  @override
  State<SliderIleExplicitAnimation> createState() => _SliderIleExplicitAnimationState();
}

class _SliderIleExplicitAnimationState extends State<SliderIleExplicitAnimation>
  with SingleTickerProviderStateMixin{

  late final animController = AnimationController(vsync: this);
  final alignmentTween = Tween<AlignmentGeometry>(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  double sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 20),
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 40),
        const Text('Slider ile explicit animation', style: TextStyle(fontSize: 20),),
        const SizedBox(height: 30),
        AlignTransition(
          alignment: alignmentTween.animate(animController),
          child: Icon(Icons.motorcycle_rounded),
        ),
        const SizedBox(height: 10),
        Slider(
          value: sliderValue,
          onChanged: (value) {
            setState(() {
              sliderValue = value;
              animController.animateTo(
                value/100,
                duration: Duration(milliseconds: 500),
              );
            });
          },
          min: 0.0,
          max: 100.0,
        ),
        //Text(sliderValue.toStringAsFixed(1)),
        Text(
          sliderValue < 25
              ? 'vın'
              : sliderValue < 50
                ? 'vınn'
                : sliderValue < 75
                  ? 'vınnn'
                  : 'vınnnn',
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class AnimatedContainerDeneme extends StatefulWidget {
  const AnimatedContainerDeneme({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  State<AnimatedContainerDeneme> createState() =>
      _AnimatedContainerDenemeState();
}

class _AnimatedContainerDenemeState extends State<AnimatedContainerDeneme> {
  bool animBool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 40),
        const Text(
          'Animation Playground',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 80),
        AnimatedContainer(
          height: animBool ? 100 : 120,
          width: animBool ? 100 : 120,
          duration: widget.duration,
          curve: Curves.easeInOutQuad,
          margin: EdgeInsets.only(
              left: animBool ? 80 : 0, right: animBool ? 0 : 100),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            boxShadow: animBool
                ? [
                    const BoxShadow(offset: Offset(30, -30), blurRadius: 30),
                  ]
                : [
                    const BoxShadow(offset: Offset(-30, 30), blurRadius: 30),
                  ],
            borderRadius: animBool ? const BorderRadius.all(Radius.circular(10)) : const BorderRadius.all(Radius.circular(150)),
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: Alignment.bottomRight,
              colors: animBool
                  ? [Colors.greenAccent, Colors.orangeAccent]
                  : [Colors.redAccent, Colors.blueAccent],
            ),
          ),
        ),
        const SizedBox(height: 60),
        ElevatedButton(
          onPressed: () {
            setState(() {
              animBool = !animBool;
            });
          },
          child: const Text('Değiştir!'),
        )
      ],
    );
  }
}

class AnimatedPaddingDeneme extends StatefulWidget {
  const AnimatedPaddingDeneme({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  State<AnimatedPaddingDeneme> createState() => _AnimatedPaddingDenemeState();
}

class _AnimatedPaddingDenemeState extends State<AnimatedPaddingDeneme> {
  bool animBool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 20),
        const Text(
          'Animated Padding',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 40),
        AnimatedPadding(
          padding: EdgeInsets.only(
              left: animBool ? 0 : 200, right: animBool ? 200 : 0),
          child: const Text('Bouncing text'),
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceOut,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            setState(() {
              animBool = !animBool;
            });
          },
          child: const Text('Bounce!'),
        )
      ],
    );
  }
}

class AnimatedCrossFadeDeneme extends StatefulWidget {
  const AnimatedCrossFadeDeneme({
    Key? key,
    required this.duration,
  }) : super(key: key);

  final Duration duration;

  @override
  State<AnimatedCrossFadeDeneme> createState() => _AnimatedCrossFadeDenemeState();
}

class _AnimatedCrossFadeDenemeState extends State<AnimatedCrossFadeDeneme> {
  bool animBool = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        const SizedBox(height: 20),
        const Text(
          'Animated Image',
          style: TextStyle(fontSize: 20),
        ),
        const Text('Tans & Kinkun Edition'),
        const SizedBox(height: 40),
        SizedBox(
          child: AnimatedCrossFade(
              firstChild: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/tans.jpeg', fit: BoxFit.fill)),
              secondChild: SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset('assets/erkin.jpeg', fit: BoxFit.fitWidth)),
              crossFadeState: animBool ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              duration: widget.duration,
          ),
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            setState(() {
              animBool = !animBool;
            });
          },
          child: const Text('Değiştir'),
        )
      ],
    );
  }
}

class HeroWidgetDenemeButonu extends StatelessWidget {
  const HeroWidgetDenemeButonu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
          thickness: 1,
          indent: 10,
          endIndent: 10,
        ),
        Center(
          child: Hero(
            tag: 'hero widget deneme',
            child: Container(
              color: Colors.greenAccent,
              margin: const EdgeInsets.only(top:20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return HeroWidgetTestSayfasi();
                      }
                  ));
                },
                child: const Text('Hero widget Deneme',
                  style: TextStyle(fontSize: 24, color: Colors.indigo),),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HeroWidgetTestSayfasi extends StatelessWidget {
  const HeroWidgetTestSayfasi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Hero(
              tag: 'hero widget deneme',
              child: Material(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.greenAccent,
                  child: Center(
                    child: const Text('Hero widget Deneme',
                      style: TextStyle(fontSize: 24, color: Colors.indigo),),
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }
}

