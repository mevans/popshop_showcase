import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:popshop/common_widgets/app_bar.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/community.dart';
import 'package:popshop/screens/community_detail_page/community_detail_page.dart';

class CommunitiesListPage extends StatefulWidget {
  final List<String> filters = [
    "All Brands",
    "Apparel",
    "Beauty",
    "Health",
    "Lifestyle",
    "Homegoods",
    "Furniture",
    "Jewelry & accessories"
  ];

  @override
  _CommunitiesListPageState createState() => _CommunitiesListPageState();
}

class _CommunitiesListPageState extends State<CommunitiesListPage> {
  String currentFilter = "All Brands";
  PagewiseLoadController<Community> pagewiseLoadController;

  @override
  void initState() {
    refreshPagewiseController();
    super.initState();
  }

  void refreshPagewiseController() {
    setState(() {
      pagewiseLoadController = PagewiseLoadController(
          pageFuture: (i) {
            return RestDatasource()
                .getCommunities(page: i + 1, category: currentFilter);
          },
          pageSize: 24);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PopshopAppBar(
        title: "Communities",
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            height: 40,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: widget.filters.map((s) {
                  bool selected = currentFilter == s;
                  bool firstItem = widget.filters.first == s;
                  bool lastItem = widget.filters.last == s;
                  return Container(
                    margin: EdgeInsets.only(
                        right: 8.0 + (lastItem ? 8 : 0),
                        left: firstItem ? 16 : 0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        refreshPagewiseController();
                        setState(() {
                          currentFilter = s;
                        });
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        padding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: selected
                            ? BoxDecoration(
                            color: Color(0xff263238),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(100))
                            : BoxDecoration(
                            border: Border.all(color: Color(0xffd9d9d9)),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(s,
                                style: TextStyle(
                                    color: selected
                                        ? Colors.white
                                        : Color(0xff8c8e8f),
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500))),
                      ),
                    ),
                  );
                }).toList()),
          ),
          Expanded(
            child: PagewiseGridView<Community>.count(
              pageLoadController: pagewiseLoadController,
              padding: EdgeInsets.only(left: 20, bottom: 20, right: 20),
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              itemBuilder: (ctx, entry, index) {
                return CommunityListItem(
                  community: entry,
                );
              },
//              pageFuture: (i) {
//                print("https://backend.popshop.com/api/vendor_list?page=${i + 1}${currentFilter != "All Brands" ? "&category=$currentFilter": ""}");
//                return RestDatasource().getCommunities(page: i + 1, category: currentFilter);
//              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityListItem extends StatelessWidget {
  final Community community;

  CommunityListItem({this.community});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(community.logoSmall),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10)),
                foregroundDecoration: BoxDecoration(
                    border: Border.all(color: Colors.black12, width: 0.8),
                    borderRadius: BorderRadius.circular(10)),
              ),
              aspectRatio: 1,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              community.brandName,
              maxLines: 1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xff263238),
                  fontFamily: "Monsterrat"),
            ),
            SizedBox(height: 3),
            Text(
              community.category,
              style: TextStyle(fontSize: 10, color: Color(0xff606060)),
              maxLines: 1,
            )
          ],
        ),
        Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (ctx) =>
                              CommunityDetailPage(communityID: community.id)));
                },
              ),
            )),
      ],
    );
  }
}
