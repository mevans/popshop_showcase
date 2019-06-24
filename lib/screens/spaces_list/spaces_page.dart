import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/space.dart';
import 'package:popshop/screens/menu/menu_page.dart';
import 'package:popshop/screens/space_detail_page/space_detail_page.dart';

class SpacesPage extends StatefulWidget {
  @override
  _SpacesPageState createState() => _SpacesPageState();
}

class _SpacesPageState extends State<SpacesPage> {
  TextEditingController searchController = TextEditingController();
  double appBarHeight = 200;
  PagewiseLoadController<Space> pagewiseLoadController;
  SpacesFilter spacesFilter = SpacesFilter();

  @override
  void initState() {
    super.initState();
    refreshPagewiseController();
  }

  void refreshPagewiseController() {
    setState(() {
      pagewiseLoadController = PagewiseLoadController(
        pageFuture: (i) =>
            RestDatasource()
                .getSpaces(page: i + 1, search: searchController.text),
        pageSize: 24,);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            pinned: true,
            title: Text(
              "Spaces",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (ctx) => MenuPage()));
                },
              )
            ],
            expandedHeight: 150,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.none,
              background: SafeArea(
                child: Container(
                  child: Padding(
                    padding:
                    const EdgeInsets.only(left: 32.0, right: 32, top: 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: searchController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(color: Colors.white54),
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 24),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(100)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(100)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(100)),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      searchController.text = "";
                                      refreshPagewiseController();
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      refreshPagewiseController();
                                    },
                                  ),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(10),
            sliver: PagewiseSliverGrid<Space>.count(
              pageLoadController: pagewiseLoadController,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              itemBuilder: (ctx, entry, index) {
                return SpaceGridItem(
                  space: entry,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class SpaceGridItem extends StatelessWidget {
  final Space space;

  SpaceGridItem({this.space});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Color(0xffe8e5e5), width: 1),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(7),
                      topRight: Radius.circular(7)),
                  child: Image.network(
                    space.thumbnailTall,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      space.name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff263238),
                          fontFamily: "Muli"),
                    ),
                    Text(
                      "${space.neighborhood.city} | ${space.neighborhood
                          .name}\n${space.totalAreaSqFt} Sq Ft",
                      style: TextStyle(color: Color(0xff959595), fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(7),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (ctx) => SpaceDetailPage(spaceID: space.id)));
              },
            )
        )
      ],
    );
  }
}

class SpacesFilter {
  String sort;

  List<Space> sortSpaces(List<Space> spaces) {
    if (sort == "Sort by Price") return spaces;
    if (sort == "Sort by Square FT.")
      return spaces..sort((s1, s2) => s2.totalAreaSqFt - s1.totalAreaSqFt);
    return spaces;
  }
}

List<String> sorts = ["Sort by Price", "Sort by Square FT."];
