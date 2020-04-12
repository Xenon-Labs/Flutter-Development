import 'package:flutter/material.dart';

typedef UpdateCallback = Function(String value, String id);
typedef DeleteCallback = Function(String id);

class Task extends StatelessWidget {
  Task(
      {@required this.content,
      @required this.id,
      @required this.update,
      @required this.delete});

  final String content, id;
  final UpdateCallback update;
  final DeleteCallback delete;
  final TextEditingController updateText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    updateText.text = content;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: TextField(
                controller: updateText,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500)),
          ),
          Row(
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.cloud_upload,
                      color: Colors.blueAccent, size: 20.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0.0),
                  onPressed: () =>
                      update(updateText.text.toString(), id)),
              IconButton(
                  icon: Icon(Icons.delete,
                      color: Colors.redAccent, size: 20.0),
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0.0),
                  onPressed: () => delete(id))
            ],
          )
        ],
      ),
    );
  }
}
