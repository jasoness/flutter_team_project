import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_team_project/design/Board/boardPage.dart';

class ModifyForm extends StatefulWidget {
  ModifyForm({Key? key, required this.sDocId}) : super(key: key);

  final BoardData sDocId;

  @override
  ModifyFormState createState() => ModifyFormState();
}

class ModifyFormState extends State<ModifyForm> {
  final _formKey = GlobalKey<FormState>();

  DateTime now = new DateTime.now();

  @override
  void initState() {
    super.initState();
    // print('게시글 수정 위젯 생성 (initState)');
  }

  // 게시글 제목 , 게시글 내용 controller

  var _titleController = TextEditingController();
  var _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    _titleController.dispose();
    super.dispose();
    // print('게시글 수정 위젯 종료 (dispose)');
  }

  @override
  Widget build(BuildContext context) {
    // print('게시글 수정 실행 (build)');
    // _contentController.text = widget.get_data_for_modifying.description;
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('게시판')
            .doc(widget.sDocId.docName)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _titleController.text = snapshot.data!['title'];
            _contentController.text = snapshot.data!['content'];
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.blueAccent,
                title: Text(
                  '게시글 수정',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              body: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    // 회색 구분 선
                    Container(
                      color: Colors.black12,
                      height: 1,
                    ),

                    // 게시글 제목 입력 필드 박스
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: _titleController,
                                autofocus: true,
                                validator: (value) {
                                  if (value == "") {
                                    return '제목 누락';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '제목',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 사진 및 파일 첨부 UI (보류)
                    Container(
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              height: 2,
                              color: Colors.black12,
                            ),
                            // Text('board.dart의 변수 출력 : '+board.i.toString()+' / '),
                            // Text(_titleController.text+' / '),
                            // Text(_contentController.text+' / '),
                            // Text('list 길이 : '+board.list.length.toString()),
                            // OutlinedButton(
                            //   onPressed: () {
                            //
                            //   },
                            //   child: Text('파일 첨부'),
                            //   style: OutlinedButton.styleFrom(
                            //     minimumSize: Size(125, 36),
                            //     //textStyle: ThemeData().textTheme.button,
                            //
                            //   ),
                            //
                            // ),
                            //
                            // OutlinedButton(
                            //   onPressed: () {
                            //
                            //   },
                            //   child: Text('사진 첨부'),
                            //   style: OutlinedButton.styleFrom(
                            //     minimumSize: Size(125, 36),
                            //   ),
                            //
                            // ),
                          ],
                        ),
                      ),
                    ),

                    // 회색 구분 선
                    Container(
                      color: Colors.black12,
                      height: 1,
                    ),
                    // 게시글 내용 입력 필드 박스
                    Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                controller: _contentController,
                                validator: (value) {
                                  if (value == "") {
                                    return '내용 누락';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '내용',
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                maxLines: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 회색 구분 선
                    Container(
                      color: Colors.black12,
                      height: 1,
                    ),

                    // 등록 및 수정 버튼

                    Container(
                      color: Colors.white10,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              child: Text(
                                '수정',
                                textScaleFactor: 1.5,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                minimumSize: Size(125, 45),
                                shadowColor: ThemeData(
                                  shadowColor: Colors.white10,
                                ).shadowColor,
                              ),
                              onPressed: () {
                                if (_titleController.text == '') {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('입력 오류'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('제목을 입력해주세요.'),
                                            ],
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            24.0, 24.0, 24.0, 10.0),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('확인'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else if (_contentController.text == '') {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('입력 오류'),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: <Widget>[
                                              Text('내용을 입력해주세요.'),
                                            ],
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.fromLTRB(
                                            24.0, 24.0, 24.0, 10.0),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('확인'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }else{
                                  FirebaseFirestore.instance.collection('게시판').doc(widget.sDocId.docName).update({
                                    'title' : _titleController.text,
                                    'content' : _contentController.text,
                                    'modify_time' : FieldValue.serverTimestamp(),
                                  });
                                  setState(() {
                                    Navigator.pop(context);
                                  });

                                }

                                // if (_formKey.currentState.validate()) {
                                //
                                //   DateTime datetime = DateTime.now();
                                //
                                //   String year = datetime.year.toString();
                                //   String month = datetime.month.toString();
                                //   String day = datetime.day.toString();
                                //
                                //   String hour = datetime.hour.toString();
                                //   String minute = datetime.minute.toString();
                                //   String second = datetime.second.toString();
                                //
                                //   String thisTime = year+'-'+month+'-'+day+' '+hour+':'+minute+':'+second;
                                //
                                //   final change_item = new BoardData(
                                //       widget.get_data_for_modifying.listSortingNum, widget.get_data_for_modifying.listNum, widget.get_data_for_modifying.writer,
                                //       _titleController.text,
                                //       _contentController.text, thisTime, widget.get_data_for_modifying.isNoModify);
                                //
                                //   Navigator.pop(context, change_item);
                                // }
                              },
                            ),
                            ElevatedButton(
                              child: Text(
                                '취소',
                                textScaleFactor: 1.5,
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blueAccent,
                                minimumSize: Size(125, 45),
                                shadowColor: ThemeData(
                                  shadowColor: Colors.white10,
                                ).shadowColor,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: <Widget>[
                                            Text('취소 하시겠습니까?'),
                                            Text('작업 내역이 저장되지않습니다.'),
                                          ],
                                        ),
                                      ),
                                      contentPadding: EdgeInsets.fromLTRB(
                                          24.0, 24.0, 24.0, 10.0),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            // stack에서 alert 창 pop
                                            Navigator.pop(context);

                                            // stack에서 게시글 수정 위젯 pop
                                            Navigator.pop(context);
                                          },
                                          child: Text('확인'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('취소'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    // 수정 버튼 부분 끝
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('게시글 수정'),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }
}
