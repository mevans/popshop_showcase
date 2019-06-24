import 'package:flutter/material.dart';
import 'package:popshop/common_widgets/app_bar.dart';
import 'package:popshop/common_widgets/switcher.dart';
import 'package:popshop/models/event.dart';
import 'package:popshop/screens/events_list/event_list_item.dart';
import 'package:popshop/utils/network_util.dart';

class EventListPage extends StatefulWidget {
  final List<String> filters = ["All Events", "Looking for Collaborators"];

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  String currentFilter = "All Events";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PopshopAppBar(
        title: "Events",
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
            child: Switcher(
              widget.filters,
              onPressed: (s) {
                setState(() {
                  currentFilter = s;
                });
              },
              value: currentFilter,
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future:
              NetworkUtil().get(
                  "https://backend.popshop.com/popshopapiv1/events"),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                Map<String, dynamic> j = snapshot.data;
                List<Event> events = List.from(
                    j["results"].map((d) => Event.fromJson(d)).toList())
                  ..sort((e1, e2) => e1.startDate.compareTo(e2.startDate));
                if (currentFilter == "Looking for Collaborators") {
                  events.retainWhere((e) =>
                      e.slotsLeft > 0 && e.endDate.isAfter(DateTime.now()));
                }
                return ListView.separated(
                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  itemBuilder: (ctx, index) {
                    Event event = events[index];
                    return EventListItem(
                      event: event,
                    );
                  },
                  itemCount: events.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 16,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
