import 'package:flutter/material.dart';
import 'package:popshop/PopshopIcons.dart';
import 'package:popshop/common_widgets/header_with_underline.dart';
import 'package:popshop/common_widgets/image_overlay_back_button.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/detailed_models/detailed_community.dart';
import 'package:popshop/screens/full_screen_image.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityDetailPage extends StatelessWidget {
  final String communityID;

  CommunityDetailPage({this.communityID});

  Widget buildSocialIcon(String type, String url) {
    IconData iconData;
    switch (type) {
      case "twitter":
        iconData = PopshopIcons.twitter;
        break;
      case "facebook":
        iconData = PopshopIcons.facebook;
        break;
      case "snapchat":
        iconData = PopshopIcons.snapchat;
        break;
      case "instagram":
        iconData = PopshopIcons.instagram;
        break;
      case "linkedin":
        iconData = PopshopIcons.linkedin;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      width: 35,
      height: 35,
      decoration:
      BoxDecoration(shape: BoxShape.circle, color: Color(0xff32c3ce)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            if (await canLaunch(url)) launch(url);
          },
          child: Icon(
            iconData,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget buildSocialRow(DetailedCommunity c) {
    List<Widget> widgets = [];
    if (c.twitterUrl.isNotEmpty)
      widgets.add(buildSocialIcon("twitter", c.twitterUrl));
    if (c.facebookUrl.isNotEmpty)
      widgets.add(buildSocialIcon("facebook", c.facebookUrl));
    if (c.instagramUrl.isNotEmpty)
      widgets.add(buildSocialIcon("instagram", c.instagramUrl));
    if (c.snapchatUrl.isNotEmpty)
      widgets.add(buildSocialIcon("snapchat", c.snapchatUrl));
    if (c.linkedinUrl.isNotEmpty)
      widgets.add(buildSocialIcon("linkedin", c.linkedinUrl));
    return Row(
      children: widgets,
      mainAxisSize: MainAxisSize.min,
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Build");
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DetailedCommunity>(
        future: RestDatasource().getDetailedCommunity(id: communityID),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          DetailedCommunity community = snapshot.data;
          return ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Image.network(
                        community.brandThumbnail,
                        color: Color(0xff263238),
                        colorBlendMode: BlendMode.hardLight,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 75,
                      ),
                    ],
                  ),
                  Positioned(
                    top: 70,
                    left: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ImageOverlayBackButton(),
                        SizedBox(height: 20),
                        Image.network(
                          community.logo,
                          width: 150,
                          height: 150,
                        ),
                        SizedBox(height: 10),
                        Text(
                          community.brandName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              fontFamily: "Montserrat"),
                        ),
                        Text(
                          community.category,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          shrinkWrap: true,
                          itemBuilder: (ctx, index) {
                            return Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(
                                children: <Widget>[
                                  Hero(
                                    tag: community.photos[index].image,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        community.photos[index].image,
                                        height: 150,
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          onTap: () {
                                            print(
                                                community.photos[index].venue);
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (ctx) =>
                                                    FullScreenImage(
                                                      community.photos[index]
                                                          .image,
                                                      tag: community
                                                          .photos[index].image,
                                                      title: community
                                                          .brandName,
                                                    ),
                                              ),
                                            );
                                          },
                                        ),
                                      ))
                                ],
                              ),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: community.photos.length,
                        ),
                      )),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              HeaderWithUnderline("ABOUT ${community.brandName.toUpperCase()}"),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  community.about,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(color: Color(0xfff5f5f5)),
                alignment: Alignment.center,
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          launch(community.websiteUrl);
                        },
                        child: Text(
                          "Find us @ ${community.websiteUrl.replaceAll("http://", "").replaceAll("www.", "").replaceAll("https://", "")}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildSocialRow(community)
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
