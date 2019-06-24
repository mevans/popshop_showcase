import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextFieldFocusElevation extends StatefulWidget {
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String hint;
  final bool password;

  const TextFieldFocusElevation({Key key,
    this.textEditingController,
    this.hint,
    this.textInputType = TextInputType.text,
    this.password = false})
      : super(key: key);

  @override
  _TextFieldFocusElevationState createState() =>
      _TextFieldFocusElevationState();
}

class _TextFieldFocusElevationState extends State<TextFieldFocusElevation> {
  FocusNode focusNode = FocusNode();
  bool hasFocus = false;
  bool viewObscured = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        hasFocus = focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(hasFocus);
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: hasFocus
              ? [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: Colors.black.withOpacity(0.1))
          ]
              : []),
      child: TextFormField(
        obscureText: widget.password && !viewObscured,
        keyboardType: widget.textInputType,
        validator: (s) {
          focusNode.unfocus();
          if (s.isEmpty) return "This field is required";
        },
        focusNode: focusNode,
        controller: widget.textEditingController,
        decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: widget.password
                  ? InkWell(
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 200),
                  child: Icon(
                    !viewObscured ? Icons.visibility : Icons.visibility_off,
                    size: 20,
                    color: Colors.black26,
                    key: Key(viewObscured.toString()),
                  ),
                ),
                onTap: () {
                  setState(() {
                    viewObscured = !viewObscured;
                  });
                },
              )
                  : null,
            ),
            hintText: widget.hint,
            hintStyle: TextStyle(
                fontWeight: hasFocus ? FontWeight.bold : FontWeight.normal),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.1),
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
                borderSide: BorderSide(color: Colors.black26))),
      ),
    );
  }
}
