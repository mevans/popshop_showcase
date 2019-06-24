import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stripe_api/card_number_formatter.dart';
import 'package:stripe_api/stripe_api.dart';

class AddCard extends StatelessWidget {
  final TextEditingController cardNumberController = TextEditingController();
  final TextEditingController expDateController = TextEditingController();
  final TextEditingController cvcController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Add Card", style: TextStyle(fontSize: 22)),
              SizedBox(height: 8),
              TextField(
                controller: cardNumberController,
                decoration: InputDecoration(
                    labelText: "Card Number", hintText: "1234 1234 1234 1234"),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[0-9 ]")),
                  CardNumberFormatter()
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                  child: TextField(
                    controller: expDateController,
                    decoration: InputDecoration(
                        labelText: "Exp. Date", hintText: "01/22"),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp("[0-9/]")),
                      MaskedTextInputFormatter(mask: "xx/xx", separator: "/")
                    ],
                  ),
                ),
                SizedBox(width: 30),
                Expanded(
                  child: TextField(
                    controller: cvcController,
                    keyboardType: TextInputType.number,
                    decoration:
                        InputDecoration(labelText: "CVC", hintText: "411"),
                    maxLength: 3,
                  ),
                ),
              ]),
              SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                FlatButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                RaisedButton(
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Theme.of(context).primaryColor,
                  elevation: 0,
                  onPressed: () async{
                    int expMonth =
                        int.parse(expDateController.text.split("/")[0]);
                    int expYear =
                        int.parse(expDateController.text.split("/")[1]);
                    Token token = await Stripe.instance.createCardToken(new StripeCard(
                        number: cardNumberController.text,
                        cvc: cvcController.text,
                        expMonth: expMonth,
                        expYear: expYear)).then((t) {
                          print(t);
                    });
                    Stripe.instance.
                    return Navigator.pop(context);
                  },
                ),
              ])
            ]),
      ),
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    @required this.mask,
    @required this.separator,
  }) {
    assert(mask != null);
    assert(separator != null);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
