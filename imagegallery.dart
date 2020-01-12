import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageGalley extends StatefulWidget {
  @override
  _ImageGalleyState createState() => new _ImageGalleyState();
}

class _ImageGalleyState extends State<ImageGalley>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    List<Widget> items = new List<Widget>(); //  =ImageGalley() ;
    items.add(const Image(
      image: NetworkImage(
          'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
    ));

    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: SafeArea(

          child: new StreamBuilder(
              stream:
                  FirebaseDatabase.instance.reference().child("images").onValue,
              builder: (BuildContext context, AsyncSnapshot<Event> snapshot) {
                if (snapshot.hasData) {
                  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
                  int ind = 0;
                  map.forEach((dynamic, v) => print(v["image"]));
//                  for(int i=0 ; i<v ; i ++) {
                  function(map ,items);

                  return new Stack(
                    children: <Widget> [

                    new CarouselSlider(
                    items: items,
                    height: 400,
                    aspectRatio: 20,
                    viewportFraction: 1.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 1),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    //      autoPlayCurve: Curve.fastOutSlowIn,
                    pauseAutoPlayOnTouch: Duration(seconds: 10),
                    enlargeCenterPage: true,
                    //      onPageChanged: callbackFunction,
                    scrollDirection:Axis.vertical,

                  ),



                      Center(


                        child: Text("",
                          style: TextStyle(fontSize: 60.0
                          ,
                            color: Colors.red
                          ),


                            )

                        ,
                      ),
    ]

//                      child: Image.network(
//
//
//                    ,
//                        fit: BoxFit.fitWidth,
//                      ),
//                      padding: const EdgeInsets.all(2.0),
                      );
//                  };
                } else {
                  return new Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white70,
                      child:
                          new Center(child: new CircularProgressIndicator()));
                }
              }),
        ));
  }
}

void function(Map<dynamic, dynamic> map, List<Widget> items) {
  print(map);
//  items.add(const Image(
//
//      map.values.toList()[0]["image"] ,
//  );
  items.clear();
  for(int i=0 ; i<map.length ; i++){
  try {
    items.add( Image(
        image: NetworkImage(

            map.values.toList()[i]["image"],
    )
    ,
    fit: BoxFit.fill,
    )

    );
  } catch (e) {
    print(e);
  }

  }
//  try{
//  items.add(const Image(
//      image: NetworkImage(
//        map.values.toList()[0]["image"] ,
//
//)
//);
}
