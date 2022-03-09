// 데이터 담는 곳을 정의한 코드
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:inf_project1/model/photo.dart';
import 'api.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;
  List<Photo> _photos = [];

  final _photoStreamController = StreamController<List<Photo>>()..add([]);
  Stream<List<Photo>> get photoStream => _photoStreamController.stream;

  PhotoProvider({
    Key? key,
    required this.api,
    required Widget child,
  }) : super(key: key, child: child);

  // context : 위젯 트리에 대한 정보를 갖고 있음
  static PhotoProvider of(BuildContext context) {
    // 위젯 트리 정보에서 가장 가까운 photoprovider를 찾아서 return. 만약 못찾으면 assert에서 에러.
    final PhotoProvider? result = context.dependOnInheritedWidgetOfExactType<
        PhotoProvider>();

    assert(result != null, 'No PixabayApi found in context');
    return result!;
  }

  Future<void> fetch(String query) async{
    final result = await api.fetch(query);
    _photoStreamController.add(result);
}
  // 위젯이 변경되면 알려줘야 하는데 이걸 확인.
  @override
  bool updateShouldNotify(covariant PhotoProvider oldWidget) {
    return oldWidget.api != api; // 이전 api와 현재 api가 바뀌면 바뀐 것으로 보자.
  }

}
