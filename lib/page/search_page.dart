import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.white,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.black12))),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      width: 336,
                      height: 40,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.search),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Search")
                        ],
                      ),
                    ),
                    Icon(Icons.qr_code)
                  ],
                ),
              ),
            ])));
  }
}
