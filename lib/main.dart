import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutte'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    super.initState();

    for (int i = 0; i < 3; i++) {
      _key.add(new GlobalKey());
    }
    position=Offset(20,0);
  }

  List<GlobalKey> _key = [];
Offset position;
  @override
  Widget build(BuildContext context) {
    _animationController.repeat();

    _animationController.forward();
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10)),
              height: 80,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                   right:position.dx,
                    child: CustomPaint(
                        painter: AnimatedCustomPainter(
                             Offset(0,0),
                            _animationController.view,
                            MediaQuery.of(context).size.height,
                            MediaQuery.of(context).size.width)),
                  ),
                  Padding(
                   padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                                   customBorder: new CircleBorder(),

                            key: _key[0],
                            onTap: () {

                              setState(() {
                                           RenderBox box =
                                  _key[2].currentContext.findRenderObject();
                              position
                               = box.localToGlobal(
                                  Offset.zero); //this is global position
                              double y = position.dy;

                              print("${position.dx}+" + y.toString());                      
                                                            });
                                //  _animationController.reverse();

                           
                            },
                            child: Icon(Icons.home,size: 30,)),
                        InkWell(
                           customBorder: new CircleBorder(),
                            key: _key[1],
                            onTap: () {
                                   setState(() {
                                           RenderBox box =
                                  _key[1].currentContext.findRenderObject();
                              position
                               = box.localToGlobal(
                                  Offset.zero); //this is global position
                              double y = position.dy;

                              print("${position.dx}+" + y.toString());                      
                                                            });
                            },
                            child: Icon(Icons.home,size: 30,)),
                        InkWell(
                           customBorder: new CircleBorder(),
                            key: _key[2],
                            onTap: () {
                                setState(() {
                                           RenderBox box =
                                  _key[0].currentContext.findRenderObject();
                              position
                               = box.localToGlobal(
                                  Offset.zero); //this is global position
                              double y = position.dy;

                              print("${position.dx}+" + y.toString());                      
                                                            });
                            },
                            child: Icon(Icons.phone,size: 30,)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            body: Column(
              children: [
                Text("wwww"),
                Text("wwwww"),
              ],
            )),
      ),
    );
  }
}



class AnimatedCustomPainter extends CustomPainter {
  final _paint = Paint();
  final Animation<double> _size;
  //final Animation<double> _offsetwidth;
    final Animation<double> _offset;

  final Animation<Color> _color;
  Size height;
  AnimatedCustomPainter(Offset postion,Animation<double> animation, height, width)
      : _size =
            Tween<double>(begin: 10, end: 30).animate(animation),
            
        _offset = Tween<double>(begin: postion.dx, end: /*height -300*/ 5)
            .animate(animation),
        _color = ColorTween(begin: Colors.white, end: Colors.blue)
            .animate(animation),
        super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    _paint.color = _color.value;
    canvas.drawCircle(
      Offset(
       _offset.value, //size.width / 2,
      0 // size.height + _offset.value - 400,
      ),
      _size.value,
      _paint,
    );
  }

  @override
  bool shouldRepaint(AnimatedCustomPainter oldDelegate) => true;
}
