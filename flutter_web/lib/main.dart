import 'package:flutter/material.dart';
import 'dart:html' as html;

import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '전주망실 데이터로거 엑셀파일 저장'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // setState(() {
    //   // This call to setState tells the Flutter framework that something has
    //   // changed in this State, which causes it to rerun the build method below
    //   // so that the display can reflect the updated values. If we changed
    //   // _counter without calling setState(), then the build method would not be
    //   // called again, and so nothing would appear to happen.
    //   _counter++;
    // });

    // html.window.open('https://www.naver.com', 'new tab');
    html.window.open(
        'http://zwfarm.ddns.net:8080/jj_netroom/query?start=2022-10-01&end=2022-10-01&interval=600&type=xls',
        'new tab');
  }

  DateTime _dateTimeS = DateTime.now(); // start
  DateTime _dateTimeE = DateTime.now(); // end
  // final String _startDate = '2022-12-12';
  // final String _endDate = '2022-12-13';

  final _intervalList = ['1분', '10분', '30분', '1시간'];
  String _selectedInterval = '10분';

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Center(
                              child: Text('시작 일시',
                                  style: TextStyle(fontSize: 20)))),
                      Expanded(
                        flex: 6,
                        child: TextButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2024))
                                  .then((date) {
                                print('start date=' + date.toString());
                                setState(() {
                                  _dateTimeS = date!;
                                });
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Center(
                                  child: Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(_dateTimeS),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Center(
                              child: Text('종료 일시',
                                  style: TextStyle(fontSize: 20)))),
                      Expanded(
                        flex: 6,
                        child: TextButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2021),
                                      lastDate: DateTime(2024))
                                  .then((date) {
                                print('end date=' + date.toString());
                                setState(() {
                                  _dateTimeE = date!;
                                });
                              });
                            },
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              color: Colors.blue,
                              child: Center(
                                  child: Text(
                                      DateFormat('yyyy-MM-dd')
                                          .format(_dateTimeE),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20))),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 4,
                          child: Center(
                              child: Text('시간 간격',
                                  style: TextStyle(fontSize: 20)))),
                      Expanded(
                        flex: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                            focusColor: Colors.white,
                            dropdownColor: Colors.white,
                            value: _selectedInterval,
                            items: _intervalList.map((String item) {
                              return DropdownMenuItem<String>(
                                child: Text(
                                  '$item',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                value: item,
                              );
                            }).toList(),
                            onChanged: (dynamic value) {
                              setState(() {
                                _selectedInterval = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          color: Colors.blue,
                          child: TextButton(
                            onPressed: () {
                              print('_selectedInterval=' + _selectedInterval);
                              int interval = 60 * 10; // 10min
                              switch (_selectedInterval) {
                                case '1분':
                                  interval = 60;
                                  break;
                                case '10분':
                                  interval = 60 * 10;
                                  break;
                                case '30분':
                                  interval = 60 * 30;
                                  break;
                                case '1시간':
                                  interval = 60 * 60;
                                  break;
                              }

                              String url =
                                  'http://zwfarm.ddns.net:8080/jj_netroom/query?start=${DateFormat('yyyy-MM-dd').format(_dateTimeS)}&end=${DateFormat('yyyy-MM-dd').format(_dateTimeE)}&interval=${interval.toString()}&type=xls';
                              print('url=' + url);
                              html.window.open(url, 'new tab');
                            },
                            child: const Text(
                              '엑셀 데이터 요청',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      )),
                      // Expanded(
                      //     child: Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     height: 50,
                      //     color: Colors.grey,
                      //     child: TextButton(
                      //       onPressed: () {},
                      //       child: const Text(
                      //         '취소',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // )),
                    ],
                  )
                ],
              ),
            ),
            // RaisedButton(
            //   child: Text('Pick a Date'),
            //   onPressed: () {
            //     showDatePicker(
            //             context: context,
            //             initialDate: DateTime.now(),
            //             firstDate: DateTime(2021),
            //             lastDate: DateTime(2024))
            //         .then((date) {});
            //   },
            // )
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
