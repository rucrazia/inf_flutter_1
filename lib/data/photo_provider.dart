import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'api.dart';

class PhotoProvider extends InheritedWidget {
  final PixabayApi api;

  const PhotoProvider({
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

  // 위젯이 변경되면 알려줘야 하는데 이걸 확인.
  @override
  bool updateShouldNotify(covariant PhotoProvider oldWidget) {
    return oldWidget.api != api; // 이전 api와 현재 api가 바뀌면 바뀐 것으로 보자.
  }

}
