import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popshop/data/data.dart';
import 'package:popshop/models/detailed_models/detailed_space.dart';
import 'package:popshop/screens/add_card.dart';

//import 'package:stripe_payment/stripe_payment.dart';

class BookSpace extends StatefulWidget {
  final DetailedSpace space;

  const BookSpace({Key key, this.space}) : super(key: key);

  @override
  _BookSpaceState createState() => _BookSpaceState();
}

class _BookSpaceState extends State<BookSpace> {
  DateTime startDate;
  DateTime endDate;

  @override
  void initState() {
    startDate = DateTime.now();
    endDate = startDate.add(Duration(days: widget.space.minDays));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int days = endDate
        .difference(startDate)
        .inDays + 2;
    String perType = "day";
    if (days >= 7) {
      perType = "week";
    }
    if (days >= 30) {
      perType = "month";
    }
    if (days < widget.space.minDays) {
      setState(() {
        endDate = startDate.add(Duration(days: widget.space.minDays));
      });
    }
    Widget checkedBox = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          color: Theme
              .of(context)
              .primaryColor,
          borderRadius: BorderRadius.circular(3)),
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
    Widget uncheckedBox = Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
          ),
          borderRadius: BorderRadius.circular(3)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Booking",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(32),
        children: <Widget>[
          Text(
            "Minimum of ${widget.space.minDays} days",
            style: TextStyle(color: Colors.black54),
          ),
          SizedBox(height: 4),
          DateContainer(
              firstAvailable: DateTime.now().subtract(Duration(days: 1)),
              date: startDate,
              onChanged: (d) {
                if (d != null) {
                  setState(() {
                    startDate = d;
                  });
                }
              }),
          SizedBox(height: 10),
          Text(
            "TO",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          DateContainer(
              firstAvailable:
              startDate.add(Duration(days: widget.space.minDays)),
              date: endDate,
              onChanged: (d) {
                if (d != null) {
                  setState(() {
                    endDate = d;
                  });
                }
              }),
          SizedBox(
            height: 24,
          ),
          Container(
            width: double.infinity,
            height: 1.5,
            color: Colors.black12,
          ),
          SizedBox(
            height: 24,
          ),
          Text(
            "Estimated Cost ($days days)",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w900, fontSize: 17),
          ),
          SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              perType == "day" ? checkedBox : uncheckedBox,
              Text(
                "\$${widget.space.pricePerDay.toInt()} / day",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              perType == "week" ? checkedBox : uncheckedBox,
              Text(
                "\$${widget.space.pricePerWeek.toInt()} / week",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              perType == "month" ? checkedBox : uncheckedBox,
              Text(
                "\$${widget.space.pricePerMonth.toInt()} / month",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(
            width: double.infinity,
            height: 1.5,
            color: Colors.black12,
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Service",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "\$${widget.space.serviceCost}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Cleaning",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "\$${widget.space.cleaningCost}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Security",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "\$${widget.space.securityDeposit}",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (ctx) => AddCard());
//              StripeSource.addSource().then((String token) {
//                print(token); //your stripe card source token
//              });
            },
            child: Container(
              decoration: BoxDecoration(color: Theme
                  .of(context)
                  .primaryColor, borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(
                      "BOOK NOW",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateContainer extends StatelessWidget {
  final DateTime date;
  final ValueChanged<DateTime> onChanged;
  final DateTime firstAvailable;

  const DateContainer({Key key, this.date, this.onChanged, this.firstAvailable})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDatePicker(
            context: context,
            initialDate: date,
            firstDate: firstAvailable,
            lastDate: DateTime.now().add(Duration(days: 730)),
            builder: (ctx, c) {
              return Theme(
                data: ThemeData(
                    primaryColor: Theme.of(context).primaryColor,
                    accentColor: Theme.of(context).primaryColor),
                child: c,
              );
            }).then(onChanged);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${date.day} ${Data.months[date.month - 1].substring(0, 3)} ${date.year}",
              style: TextStyle(fontSize: 17),
            ),
            Icon(
              Icons.today,
              color: Colors.black26,
            )
          ],
        ),
      ),
    );
  }
}
