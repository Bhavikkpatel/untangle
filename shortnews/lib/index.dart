import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Color searchBackGround = Colors.transparent;
  Color searchIconColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff202125),
      body: SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Search Bar
            MouseRegion(
              onEnter: searchBackGroundChange,
              onExit: searchBackGroundExited,
              child: Container(
                width: width * 0.4,
                height: height * 0.08,
                decoration: BoxDecoration(
                  color: searchBackGround,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_sharp,
                        size: 30,
                        color: searchIconColor,
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              border: InputBorder.none,
                              hintText: 'Enter a search',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Search Button
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xff202125),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                              color: Colors.blueAccent,
                            ),
                            borderRadius: BorderRadius.circular(100.0)),
                        primary: Colors.white.withOpacity(0.9),
                      ),
                      child: SizedBox(
                        height: height * 0.07,
                        width: width * 0.07,
                        child: const Center(
                          child: Text('search',
                              style: TextStyle(
                                fontSize: 20,
                              )),
                        ),
                      ),
                      onPressed: () {}),

                  // history

                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: ElevatedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xff202125),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.blueAccent,
                              ),
                              borderRadius: BorderRadius.circular(100.0)),
                          primary: Colors.white.withOpacity(0.9),
                        ),
                        child: SizedBox(
                          height: height * 0.07,
                          width: width * 0.07,
                          child: const Center(
                            child: Text('history',
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                          ),
                        ),
                        onPressed: () {}),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void searchBackGroundChange(PointerEvent pointer) {
    setState(() {
      searchBackGround = const Color(0xff3B3B3B);
    });
  }

  void searchBackGroundExited(PointerEvent pointer) {
    setState(() {
      searchBackGround = Colors.transparent;
    });
  }
}
