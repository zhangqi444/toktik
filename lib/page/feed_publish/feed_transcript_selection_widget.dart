import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class FeedTranscriptSelectionWidget extends StatefulWidget {
  final Function onNext;
  final String subtitleFileUri;

  FeedTranscriptSelectionWidget(
      {required this.onNext, required this.subtitleFileUri});

  @override
  _FeedTranscriptSelectionWidgetState createState() {
    // TODO: implement createState
    return _FeedTranscriptSelectionWidgetState();
  }
}

class _FeedTranscriptSelectionWidgetState
    extends State<FeedTranscriptSelectionWidget> {
  List<SubtitleSegment> subtitleSegments = [];

  List<int> selectedIndexes = [];
  @override
  void initState() {
    super.initState();

    Dio dio = Dio();
    dio.get<String>(widget.subtitleFileUri).then((response) {
      String subtitleTxt = response.data ?? "";
      List<SubtitleSegment> subtitleSegments = subtitleTxt
          .trim()
          .split("\n\n")
          .map(this._parseSubtitleSegment)
          .toList();

      setState(() {
        this.subtitleSegments = subtitleSegments;
      });
    }).catchError((error) {
      print("error $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _topLayout(context),
        _bottomLayout(context),
      ],
    );
  }

  SubtitleSegment _parseSubtitleSegment(String subtitleSegment) {
    List<String> parts = subtitleSegment.trim().split("\n");
    // process start time
    List<String> times = parts[1].split(" --> ");
    List<int> startTimeParts = times[0].split(":").map((p) {
      return int.parse(p.replaceAll(",", ""));
    }).toList();
    int startTimeMillis =
        (startTimeParts[0] * 3600 + startTimeParts[1] * 60) * 1000 +
            startTimeParts[2];

    // process end time
    List<int> endTimeParts = times[1].split(":").map((p) {
      return int.parse(p.replaceAll(",", ""));
    }).toList();
    int endTimeMillis = (endTimeParts[0] * 3600 + endTimeParts[1] * 60) * 1000 +
        endTimeParts[2];

    return SubtitleSegment(
        content: parts[2],
        startTimeMillis: startTimeMillis,
        endTimeMillis: endTimeMillis);
  }

  Widget _topLayout(BuildContext context) {
    return Expanded(
        flex: 1,
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
          itemBuilder: (BuildContext context, int index) {
            SubtitleSegment data = subtitleSegments[index];
            int startTimeMinutePart = data.startTimeMillis ~/ 1000 ~/ 60;
            int startTimeSecondPart =
                data.startTimeMillis ~/ 1000 - startTimeMinutePart * 60;

            bool isSelected = selectedIndexes.contains(index);
            return GestureDetector(
              onTap: () {
                if (!isSelected) {
                  // added segment must be at the edge of the range
                  if (selectedIndexes.length == 0 ||
                      index == selectedIndexes[0] - 1 ||
                      index ==
                          selectedIndexes[selectedIndexes.length - 1] + 1) {
                    setState(() {
                      selectedIndexes
                        ..add(index)
                        ..sort();
                    });
                  } else {
                    _showSelectingErrorDialog();
                  }
                } else {
                  // removed segment must be at the edge of the range
                  if (selectedIndexes.length == 1 ||
                      index == selectedIndexes[0] ||
                      index == selectedIndexes[selectedIndexes.length - 1]) {
                    setState(() {
                      selectedIndexes.removeWhere((val) => val == index);
                    });
                  } else {
                    _showSelectingErrorDialog();
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(8, 0, 17, 0),
                child: Row(
                  children: [
                    Text(
                      "${startTimeMinutePart.toString().padLeft(2, '0')}:${startTimeSecondPart.toString().padLeft(2, '0')}",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                    ),
                    SizedBox(width: 12),
                    Flexible(
                      child: Text(data.content,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w300)),
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
          itemCount: subtitleSegments.length,
        ));
  }

  _bottomLayout(BuildContext context) {
    int selectedTimeRange = 0;
    if (selectedIndexes.length > 0) {
      SubtitleSegment startSegment = subtitleSegments[selectedIndexes[0]];
      SubtitleSegment endSegment =
          subtitleSegments[selectedIndexes[selectedIndexes.length - 1]];

      selectedTimeRange =
          endSegment.endTimeMillis - startSegment.startTimeMillis;
    }

    int minutePart = selectedTimeRange ~/ 1000 ~/ 60;
    int secondPart = selectedTimeRange ~/ 1000 - minutePart * 60;

    return Container(
      padding: EdgeInsets.fromLTRB(0, 18, 15, 18),
      decoration:
          BoxDecoration(border: Border(top: BorderSide(color: Colors.black12))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "${minutePart.toString().padLeft(2, '0')}:${secondPart.toString().padLeft(2, '0')}min selected (2min max)",
            textAlign: TextAlign.center,
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: Text(
                "Complete",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () async {
                await showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Notice'),
                      content: Text('Next step would be video editing'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Close'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
                widget.onNext();
              },
              style: TextButton.styleFrom(
                backgroundColor: Color(0xff39CBE3),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showSelectingErrorDialog() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notice'),
          content: Text('You must select a sequence of segments'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class SubtitleSegment {
  String content = "";
  int startTimeMillis = 0;
  int endTimeMillis = 0;

  SubtitleSegment({
    required this.content,
    required this.startTimeMillis,
    required this.endTimeMillis,
  });
}
