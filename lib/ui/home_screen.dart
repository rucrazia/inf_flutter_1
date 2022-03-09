import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:inf_project1/data/photo_provider.dart';
import 'package:inf_project1/model/photo.dart';
import 'package:inf_project1/ui/widget/photo_widget.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _constroller = TextEditingController();

  List<Photo> _photos = []; // 데이터 담는 부분. ui에 있으면 안되는데 차후 수정 예정



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
                        photoProvider.fetch(_constroller.text);
                      },
                      icon: const Icon(Icons.search))),
            ),
          ),
          StreamBuilder<List<Photo>>(
            stream: photoProvider.photoStream,
            builder: (context, snapshot) {
              //데이터가 스냅샵을 통해서 들어온다.
              if (!snapshot.hasData){
                return const CircularProgressIndicator();
              }
              final photos = snapshot.data!;

              return Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemCount: photos.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemBuilder: (context, index) {
                      final photo = photos[index];
                      return PhotoWidget(
                        photo: photo,
                      );
                    }),
              );
            }
          )
        ],
      ),
    );
  }
}
