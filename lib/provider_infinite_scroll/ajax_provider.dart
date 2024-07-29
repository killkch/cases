// ignore_for_file: unused_element, unnecessary_null_comparison, unused_local_variable

import 'package:flutter/foundation.dart';

class AjaxProvider extends ChangeNotifier {
  //?
  List<int> cache = [];

  bool loading = false;
  bool hasMore = true;

  _makeRequest({
    required int nextId,
  }) async {
    assert(nextId != null);
    await Future.delayed(Duration(seconds: 1));

    return List.generate(20, (index) => nextId + index);
  }

  fetchItems({
    int? nextId,
  }) async {
    nextId ??= 0;


    /**
     * 값이 바뀔 떄마다 리스너를 실행시킨다 .
     * 그래야 바뀐 값이 적용이 된다. 
     * 
     */
    loading = true;

    notifyListeners();

    final items = await _makeRequest(nextId: nextId);

    this.cache = [
      ...this.cache,
      ...items,
    ];

    loading = false;

    notifyListeners();
  }
}
