import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({Key? key}) : super(key: key);

  @override
  _AnimationPageState createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  AnimationController? _animationController;

  double top = 0.0;
  double bottom = 0.0;
  double left = 0.0;
  double right = 0.0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      lowerBound: 1.0,
      upperBound: 200.0,
    );

    _animationController!.addStatusListener((status) {
      print("STATUS: $status");
      if (status == AnimationStatus.completed) {
        // _animationController!.reverse();
      }
    });

    _animationController!.addListener(() {
      setState(() {
        debugPrint(_animationController!.value.toString());
      });
    });

    _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedContainer(
          margin: EdgeInsets.only(
            top: top,
            bottom: bottom,
            left: left,
            right: right,
          ),
          duration: const Duration(milliseconds: 600),
          height: 100,
          width: 100,
          curve: Curves.bounceInOut,
          color: Colors.red,
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          floatingButton(() {
            setState(() {
              if (right != 0) {
                right+=50;
              }
            });
          }, Icons.arrow_back_outlined),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              floatingButton(() {
                setState(() {
                  bottom+=50;
                });
              }, Icons.arrow_upward_outlined),
              floatingButton(() {
                setState(() {
                  top+=50;
                });
              }, Icons.arrow_downward_outlined),
            ],
          ),
          floatingButton(() {
            setState(() {
              left +=50;
            });
          }, Icons.arrow_forward_outlined),
        ],
      ),
    );
  }

  floatingButton(callback, icon) {
    return FloatingActionButton(
      onPressed: callback,
      child: Icon(icon),
    );
  }
}



// Text(_animationController!.value.toInt().toString()),
          // Center(
          //   child: InkWell(
          //     child: Hero(
          //       tag: 'hero',
          //       child: Container(
          //         height: 100,
          //         width: 100,
          //         color: Colors.red,
          //       ),
          //     ),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const NextPage(),
          //         ),
          //       );
          //     },
          //   ),
          // ),