import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class menuPage extends StatefulWidget {
  const menuPage({Key? key}) : super(key: key);

  @override
  _menuPageState createState() => _menuPageState();
}

class _menuPageState extends State<menuPage> {
  Color searchBackGround = Colors.transparent;
  Color searchIconColor = Colors.white;
  bool searched = false;
  bool answerOpacity = false;
  bool summarized = false;
  var summarizedText = "";
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff202125),
      body: Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              top: searched ? -width * 0.05 : -width * 0.02,
              left: searched ? -height * 0.05 : -height * 0.02,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4285F4),
                ),
              )),
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              top: searched ? height * 0.3 : height * 0.1,
              left: searched ? -width * 0.05 : width * 0.01,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFDB4437),
                ),
              )),
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              top: searched ? height * 0.35 : height * 0.1,
              left: searched ? width * 0.24 : width * 0.05,
              child: AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeInOutQuart,
                width: searched ? width * 0.5 : width * 0.25,
                height: searched ? height * 0.5 : width * 0.25,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4B401),
                  borderRadius: searched
                      ? BorderRadius.circular(20)
                      : BorderRadius.circular(1000),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    searched
                        ? summarized
                            ? summarizedText
                            : ''
                        : '',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              )),
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              top: searched ? height * 0.75 : height * 0.7,
              left: searched ? width * 0.75 : width * 0.7,
              child: Container(
                width: width * 0.5,
                height: height * 0.5,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF0F9D58),
                ),
              )),
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.fastOutSlowIn,
            top: searched ? height * 0.1 : height * 0.4,
            left: width * 0.3,
            child: MouseRegion(
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
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          child: TextField(
                            controller: controller,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
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
          ),
          AnimatedPositioned(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              top: searched ? height * 0.15 : height * 0.5,
              left: width * 0.38,
              child: Padding(
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
                        onPressed: () async {
                          await sentSummarizeRequest();
                          setState(() {
                            searched = true;
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                answerOpacity = true;
                              });
                            });
                          });
                        }),

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
                          onPressed: () {
                            setState(() {
                              searched = false;
                              answerOpacity = false;
                              summarized = false;
                            });
                          }),
                    ),
                  ],
                ),
              )),
          Positioned(
            top: height * 0.4,
            left: width * 0.3,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeIn,
              opacity: answerOpacity ? 1.0 : 0.0,
              child: SizedBox(
                height: searched ? height * 0.35 : 0,
                width: searched ? width * 0.4 : 0,
                child: const Text(
                  '',
                  style: TextStyle(fontSize: 25),
                ),
              ),
            ),
          )
        ],
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

  Future<void> sentSummarizeRequest() async {
    var url = Uri.parse("http://127.0.0.1:5000/summarize");
    var res = await http.post(url, headers: {
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Methods": "*",
    }, body: {
      "query": controller.text
    });
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        summarized = true;
        summarizedText = res.body;
      });
    });
    return;
  }
}
