import 'package:dwarf_doc/page/node_page.dart';
import 'package:dwarf_doc/page/popular_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.white,
            title: Text("V2EX"),
          ),
          body: TabBarView(children: <Widget>[
            PopularPage(),
            NodePage(),
          ]),
          bottomNavigationBar: Material(
            child: SafeArea(
                child: Container(
              height: 65,
              decoration:
                  BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 3,
                    spreadRadius: 2,
                    offset: Offset(-1, -1))
              ]),
              child: TabBar(
                indicatorColor: Theme.of(context).highlightColor,
                indicatorWeight: 3,
                labelColor: Theme.of(context).highlightColor,
                unselectedLabelColor: Theme.of(context).primaryColor,
                tabs: <Widget>[
                  Tab(
                    text: "热门",
                    icon: Icon(Icons.whatshot),
                  ),
                  Tab(
                    text: "节点",
                    icon: Icon(Icons.widgets),
                  )
                ],
              ),
            )),
          ),
        ));
  }
}
