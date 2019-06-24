import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:popshop/common_widgets/header_with_underline.dart';
import 'package:popshop/common_widgets/image_overlay_back_button.dart';
import 'package:popshop/common_widgets/rounded_dark_button.dart';
import 'package:popshop/data/data.dart';
import 'package:popshop/data/rest_ds.dart';
import 'package:popshop/models/detailed_models/detailed_photo.dart';
import 'package:popshop/models/detailed_models/detailed_space.dart';
import 'package:popshop/models/event.dart';
import 'package:popshop/screens/book_space/book_space.dart';
import 'package:popshop/screens/event_detail_page/event_detail_page.dart';
import 'package:popshop/screens/full_screen_image.dart';
import 'package:popshop/utils/network_util.dart';
import 'package:share/share.dart';

class SpaceDetailPage extends StatelessWidget {
  final String spaceID;
  final ScrollController imageCarouselController = ScrollController();

  SpaceDetailPage({this.spaceID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder<DetailedSpace>(
        future: RestDatasource().getDetailedSpace(id: spaceID),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: CircularProgressIndicator(),
            );
          DetailedSpace space = snapshot.data;
          return Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(bottom: 24),
                  children: <Widget>[
                    ImageCarousel(
                      space.photos,
                      belowIndicator: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 32,
                            ),
                            onPressed: () {
                              Share.share(
                                  "Check out this awesome space in ${space.neighborhood.city}");
                            },
                          ),
                          RoundedDarkButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (ctx) => FullScreenImage(
                                            space.floorPlanImage,
                                            title: "Floor Plan",
                                          )));
                            },
                            text: "VIEW FLOOR PLAN",
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 32,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "${space.name}\n${space.neighborhood.city}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          fontSize: 24),
                    ),
                    FutureBuilder(
                        future: NetworkUtil().get(
                            "https://backend.popshop.com/popshopapiv1/events?kind=upcoming&venue_id=$spaceID"),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return Container();
                          List<Event> events = [];
//                          print(snapshot.data);
                          snapshot.data["results"].forEach((s) {
//                            print(s);
                            events.add(Event.fromJson(s));
                          });
                          if (events.length != 0) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 24),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 24.0, bottom: 12),
                                  child: Text(
                                    "Upcoming Popups",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16),
                                  ),
                                ),
                                Container(
                                  height: 200,
                                  child: ListView.separated(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24),
                                    separatorBuilder: (ctx, index) => SizedBox(
                                          width: 10,
                                        ),
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      Event event = events[index];
                                      return InkWell(
                                        borderRadius: BorderRadius.circular(10),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (ctx) =>
                                                      EventDetailPage(
                                                          eventID: event.id)));
                                        },
                                        child: Container(
                                            height: 200,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black12),
                                                borderRadius:
                                                BorderRadius.circular(10)),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    "${Data.months[event.startDate.month - 1].substring(0, 3)} ${event.startDate.day} - ${Data.months[event.endDate.month - 1].substring(0, 3)} ${event.endDate.day} ",
                                                    style: TextStyle(
                                                        color:
                                                        Color(0xff263238),
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                Expanded(
                                                    child: Image.network(
                                                      event.coverThumbnail,
                                                      width: 150,
                                                      fit: BoxFit.cover,
                                                    )),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                                  child: Text(
                                                    event.slotsLeft == 0
                                                        ? "Full"
                                                        : "${event.slotsLeft} slot left",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                      BorderRadius.only(
                                                          bottomRight:
                                                          Radius
                                                              .circular(
                                                              10),
                                                          bottomLeft: Radius
                                                              .circular(
                                                              10)),
                                                      color: Color(0xff263238)),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                    itemCount: events.length,
                                    scrollDirection: Axis.horizontal,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        }),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        children: <Widget>[
                          Column(children: [
                            Text("SIZE",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16)),
                            SizedBox(
                              height: 8,
                            ),
                            Text("MINIMUM RENTAL",
                                style: TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 16)),
                          ], crossAxisAlignment: CrossAxisAlignment.start),
                          SizedBox(width: 32),
                          Column(children: [
                            Text(
                              "${space.totalAreaSqFt} sq ft",
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${space.minDays} days",
                              style: TextStyle(fontSize: 16),
                            ),
                          ], crossAxisAlignment: CrossAxisAlignment.start),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 18),
                      child: Column(
                        children: <Widget>[
                          HeaderWithUnderline("THE SPACE"),
                          SizedBox(height: 8),
                          Text(
                            space.about,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 18),
                      child: Column(
                        children: <Widget>[
                          HeaderWithUnderline("THE NEIGHBORHOOD"),
                          SizedBox(height: 8),
                          Text(
                            space.neighborhood.about,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Container(
                      height: 300,
                      child: FutureBuilder<LatLng>(
                        future: RestDatasource()
                            .coordinatesFromAddress(space.address),
                        builder: (ctx, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: CircularProgressIndicator());
                          LatLng location = snapshot.data;
                          return FlutterMap(
                            options: MapOptions(center: location, zoom: 18),
                            layers: [
                              TileLayerOptions(
                                urlTemplate: "https://api.tiles.mapbox.com/v4/"
                                    "{id}/{z}/{x}/{y}@2x.png?access_token=pk.eyJ1IjoibWF0dGhld2V2YW5zbWFwYm94IiwiYSI6ImNqdTJ0a2MzOTBlcm80M3BwOGhyb3FrM2kifQ.nj2DoqAq7pJDNEZDJYnVZw",
                                additionalOptions: {
                                  'accessToken':
                                      'pk.eyJ1IjoibWF0dGhld2V2YW5zbWFwYm94IiwiYSI6ImNqdTJ0a2MzOTBlcm80M3BwOGhyb3FrM2kifQ.nj2DoqAq7pJDNEZDJYnVZw',
                                  'id': 'mapbox.streets',
                                },
                              ),
                              MarkerLayerOptions(markers: [
                                Marker(
                                    width: 50,
                                    height: 50,
                                    point: location,
                                    builder: (ctx) => Image.asset(
                                          "assets/marker.png",
                                        ),
                                    anchorPos: AnchorPos.align(AnchorAlign.top))
                              ])
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 80,
                child: Material(
                  color: Color(0xff32c3ce),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (ctx) => BookSpace(space: space)));
                    },
                    child: Center(
                        child: Text(
                          "Request to Book",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900),
                        )),
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

class ImageCarousel extends StatefulWidget {
  final List<DetailedPhoto> images;
  final Widget belowIndicator;

  ImageCarousel(this.images, {this.belowIndicator});

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController;
  int page = 0;

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      setState(() {
        page = (scrollController.offset / MediaQuery.of(context).size.width)
            .round();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Container(
          height: 450,
          child: ListView.builder(
            controller: scrollController,
            cacheExtent:
            MediaQuery
                .of(context)
                .size
                .width * widget.images.length,
            physics: PageScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: CachedNetworkImage(
                  imageUrl: widget.images[index].image,
                  fit: BoxFit.cover,
                  fadeInDuration: Duration(seconds: 0),
                  fadeOutDuration: Duration(seconds: 0),
                  placeholder: (ctx, s) =>
                      Image.network(
                        widget.images[index].thumbnail,
                        fit: BoxFit.cover,
                      ),
                ),
              );
            },
            scrollDirection: Axis.horizontal,
            itemCount: widget.images.length,
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: SafeArea(child: ImageOverlayBackButton()),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//            color: Colors.black26,
            child: Column(
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.images.length, (i) {
                      bool selected = page == i;
                      return Flexible(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          margin: EdgeInsets.symmetric(horizontal: 2),
                          width: selected ? 15 : 10,
                          height: selected ? 15 : 10,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                              selected ? Color(0xff32c3ce) : Colors.white),
                        ),
                      );
                    })),
                SizedBox(height: 16),
                widget.belowIndicator
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
