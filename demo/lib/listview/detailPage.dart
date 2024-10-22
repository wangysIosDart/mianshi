import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String text;
  final ValueChanged<bool> onChange;

  const DetailPage({super.key, required this.text, required this.onChange});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool change = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.text)),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  change = !change;
                });
                widget.onChange(change);
              },
              child: Container(
                width: 200,
                height: 50,
                color: Colors.green,
                child: Text(
                  change == true ? '点击:true' : '点击:false',
                  style: const TextStyle(fontSize: 30),
                ),
              ),
            ),
            Text(
              widget.text,
              style: const TextStyle(fontSize: 50),
            ),
          ],
        ));
  }
}
