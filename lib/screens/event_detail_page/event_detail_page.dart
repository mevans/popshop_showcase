import 'package:flutter/material.dart';
import 'package:popshop/common_widgets/header_with_underline.dart';
import 'package:popshop/data/data.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/detailed_models/detailed_event.dart';
import 'package:popshop/screens/community_detail_page/community_detail_page.dart';

class EventDetailPage extends StatelessWidget {
  final String eventID;

  EventDetailPage({this.eventID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Event Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<DetailedEvent>(
          future: RestDatasource().getDetailedEvent(id: eventID),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            DetailedEvent event = snapshot.data;
//            print(event.vendors.length);
            return ListView(
              padding:
                  EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 24),
              children: <Widget>[
                Text(
                  "${event.space.name}\n${event.space.neighborhood.city}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      fontSize: 24),
                ),
                SizedBox(height: 4),
                Text(
                  "${Data.months[event.startDate.month - 1].substring(0, 3)} ${event.startDate.day} - ${Data.months[event.endDate.month - 1].substring(0, 3)} ${event.endDate.day}"
                      .toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                SizedBox(height: 24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    event.coverImage?.image ?? "",
                    fit: BoxFit.cover,
                  ),
                ),
                event.vendors.length != 0
                    ? Column(
                        children: <Widget>[
                          SizedBox(height: 32),
                          HeaderWithUnderline("BRANDS IN EVENT"),
                          SizedBox(height: 24),
                          GridView.count(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            childAspectRatio: 0.8,
                            crossAxisSpacing: 24,
                            mainAxisSpacing: 8,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: event.vendors.map((dc) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (ctx) =>
                                          CommunityDetailPage(
                                            communityID: dc.id,)));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .stretch,
                                  children: <Widget>[
                                    Text(dc.brandName),
                                    SizedBox(height: 8),
                                    Expanded(
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Container(
                                          foregroundDecoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(8),
                                              border: Border.all(
                                                  color: Colors.black12)),
                                          child: ClipRRect(
                                            child: Image.network(
                                              dc.logo,
                                              fit: BoxFit.cover,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                            shrinkWrap: true,
                          )
                        ],
                      )
                    : Container(),
                SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {},
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xff263238)),
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                            child: Text(
                              event.slotsLeft != 0
                                  ? "JOIN FROM ${event.pricing
                                  .perSlotPerDayDisplay}/DAY"
                                  : "FULL",
                              style: TextStyle(
                                  color: Color(0xff263238),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Montserrat"),
                            ))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    event.space.about,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child:
                                  Text("${event.space.totalAreaSqFt} sq ft.")),
                          Expanded(
                              child: Text(
                                  "Ideal For: ${event.space.idealFor.join(", ")}"))
                        ],
                      ),
                      SizedBox(
                          height: event.space.amenities.length != 0 ? 16 : 0),
                      Wrap(
                        children: event.space.amenities.map((s) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text("- $s"),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                )
              ],
            );
          }),
    );
  }
}
