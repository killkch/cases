import 'package:cases/provider_infinite_scroll/ajax_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InfiniteScroll extends StatefulWidget {
  const InfiniteScroll({super.key});

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  @override
  void initState() {
    super.initState();
    /**
     * 빌드가 되기 전에 setState가 실행이 되면 에러가 난다. 런닝에러인가 아니면 빌드 에러인가 ? 
     * listen을 false로 만들어 주어야 한다. 
     * 잠깐 기다리라는 뜻을 가지고 있다. 
     */

    Future.microtask(() {
      Provider.of<AjaxProvider>(context, listen: false).fetchItems();
    });
  }

  _renderListView() {
    final provider = Provider.of<AjaxProvider>(context);

    final cache = provider.cache;

    final loading = provider.loading;

    /**
     * 로딩중이면서 캐시에 아무것도 없는 상황 
     * 딱 한번만 일어난다. 
     */
    if (loading && cache.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (!loading && cache.length == 0) {
      return Center(
        child: Text("아이템이 없습니다."),
      );
    }

    return ListView.builder(
      itemCount: cache.length + 1,
      itemBuilder: (context, index) {
        if (index < cache.length) {
          return ListTile(
            title: Text(
              cache[index].toString(),
            ),
          );
        }

        if (!provider.loading) {
          Future.microtask(() {
            provider.fetchItems(nextId: index);
          });
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.black87,
        title: Text(
          "Infinite Scroll",
          style: TextStyle(
            color: Colors.white,
            letterSpacing: -1,
          ),
        ),
      ),
      body: _renderListView(),
    );
  }
}
