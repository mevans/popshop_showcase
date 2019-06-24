import 'package:flutter/material.dart';
import 'package:popshop/data/data.dart';
import 'package:popshop/models/event.dart';
import 'package:popshop/screens/event_detail_page/event_detail_page.dart';

class EventListItem extends StatelessWidget {
  final Event event;

  EventListItem({this.event});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
              border: Border.all(color: Color(0xffe8e5e5)),
              borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                child: Text(
                  event.venue.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Color(0xff263238)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(
                  "${event.venue.neighborhood.city} | ${event.venue.neighborhood
                      .name}",
                  style: TextStyle(color: Color(0xff959595), fontSize: 12),
                ),
              ),
              Image.network(
                event.coverThumbnail,
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding:
                EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: event.communities.map((c) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 50,
                            height: 50,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: Image.network(
                                c.logo ?? "",
                                fit: BoxFit.cover,
                              ),
                            ),
                            foregroundDecoration: BoxDecoration(
                                border: Border.all(color: Color(0xffe8e5e5))),
                          ),
                          SizedBox(width: 10),
                          Text(
                            c.brandName,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xff263238),
                                fontFamily: "Montserrat"),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                      color: Color(0xff263238),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                      child: Text(
                        event.slotsLeft != 0
                            ? "JOIN FROM ${event.pricing.perSlotPerDayDisplay}"
                            : "FULL",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Montserrat"),
                      ))),
              Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                    color: Color(0xfff9f9f9),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${Data.months[event.startDate.month - 1].substring(
                          0, 3)} ${event.startDate.day} - ${Data.months[event
                          .endDate.month - 1].substring(0, 3)} ${event.endDate
                          .day} ",
                      style: TextStyle(color: Color(0xff263238), fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
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
                            EventDetailPage(
                              eventID: event.id,
                            ),
                      ),
                    );
                  },
                )))
      ],
    );
  }
}
