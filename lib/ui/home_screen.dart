import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inf_project1/data/api.dart';
import 'package:inf_project1/data/photo_provider.dart';
import 'package:inf_project1/model/photo.dart';
import 'package:inf_project1/ui/widget/photo_widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _constroller = TextEditingController();

  List<Photo> _photos = [];



  @override
  void dispose() {
    _constroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = PhotoProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '이미지 검색 앱',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _constroller,
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () async {
                        final photos = await photoProvider.api.fetch(_constroller.text);
                        setState(() {
                          _photos = photos;
                        });
                      },
                      icon: const Icon(Icons.search))),
            ),
          ),
          Expanded(
            child: GridView.builder(
                padding: EdgeInsets.all(16.0),
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final photo = _photos[index];
                  return PhotoWidget(
                    photo: photo,
                  );
                }),
          )
        ],
      ),
    );
  }
}
