import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/utils/global_value.dart';
import 'entity/note.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({
    required this.id,
  });
  final int id;

  @override
  State<StatefulWidget> createState() {
    return ReadPageState();
  }
}

class ReadPageState extends State<ReadPage> with WidgetsBindingObserver {
  String note = "";
  String title = "";
  late Note noteEntity;
  @override
  void initState() {
    print(widget.id);
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    DbUtil.noteDbHelper.getNoteById(widget.id).then((notes) {
    setState(() {
        note = notes!.content;
        noteEntity = notes;
        title = notes!.title;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 244, 244, 1),
        title: Text('内容详情'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WritePage(

                  );
                }));
              })
        ],
      ),
      body: Container(
        child: CustomScrollView(
          shrinkWrap: false,
          primary: false,
          // 回弹效果
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: SizedBox(
                height: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Text(
                  note,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //组件即将销毁时调用
  @override
  void dispose() {
    super.dispose();
    // WidgetsBinding.instance.removeObserver(this);
  }
}

class WritePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return WritePageState();
  }

}

class WritePageState extends State<WritePage> {
  String notes = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          title: Text("书写日记"),
          actions: <Widget>[
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Container(
                    color: Colors.white,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                      minWidth: MediaQuery.of(context).size.width,
                    ),
                    padding: EdgeInsets.only(
                        left: 16.0, right: 16.0, top: 8.0, bottom: 4.0),
                    child: TextField(
                      controller: TextEditingController.fromValue(TextEditingValue(
                        // 设置内容
                          text: notes,
                          // 保持光标在最后
                          selection: TextSelection.fromPosition(TextPosition(
                              affinity: TextAffinity.downstream,
                              offset: notes.length)))),
                      onChanged: (text) {
                        setState(() {
                          notes = text;
                        });
                      },
                      maxLines: null,
                      style: TextStyle(),
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration.collapsed(
                        hintText: "点此输入你的内容",
                      ),
                    ),
                  )),
              Row(
                children: <Widget>[
                  Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.wb_sunny,
                          color: Colors.grey,
                        ),
                        onPressed: () {}),
                  ),
                  Container(
                    child: IconButton(
                        icon: Icon(
                          Icons.star_border,
                          color: Colors.grey,
                        ),
                        onPressed: () {}),
                  ),
                ],
              )
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}