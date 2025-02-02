import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NotesPreviewCard extends StatefulWidget {

  final String title;
  final String body;
  final bool favorite;
  final String? creationTime;
  const NotesPreviewCard({Key? mykey, required this.title, required this.body, required this.favorite, required this.creationTime}) : super(key: mykey);

  @override
  State<NotesPreviewCard> createState() => _NotesPreviewCardState(title, body, favorite, creationTime);
}

class _NotesPreviewCardState extends State<NotesPreviewCard> {
  final title;
  final body;
  final favorite;
  final creationTime;

  _NotesPreviewCardState(this.title, this.body, this.favorite, this.creationTime);
  @override
  Widget build(BuildContext context) {
    int? year = DateTime.parse(creationTime).year;
    int? month = DateTime.parse(creationTime).month;
    int? day = DateTime.parse(creationTime).day;
    int? hour = DateTime.parse(creationTime).hour;
    int? minute = DateTime.parse(creationTime).minute;

    //This is the preview card of every note
    return Card(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      shadowColor: null,
      elevation: 0,

      //color of card when elevation is applied
      surfaceTintColor: null,
      borderOnForeground: true,

      //shape of the card will take effect on the child
      //if this is set to none the color of the child will be above the card shape and color
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        
        decoration: const BoxDecoration(
          color: Color(0xffe7dccb),
          //Gradient Color
          // gradient: LinearGradient(
          // colors: [Color(0xffd4ebec), Color(0xffbdc8cb), Color(0xffbdc8cb), Color(0xffb0bbbe)],
          // begin: Alignment.topCenter,
          // end: Alignment.bottomCenter,
          // stops: [0, 0.7, 0.7, 1]
          // ),
        ),
        width: 50,
        height: 100,
        padding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //The output of each card and styling
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),), 
            const SizedBox(height: 12),
            Container(
              width: 100,
              height: 80,
              child: Text(body, style: const TextStyle(overflow: TextOverflow.clip)),
            ),
            Row(
              children: [
                Container(
                  child: favorite ? 
                  Icon(
                    Icons.favorite,
                    color: Color(0xfffb7aa6),
                  ) : Icon(
                    Icons.favorite,
                    color: Colors.grey,
                  )
                ),
                Text("         "),
                Text("$year -$month -$day")
              ],
            )
            
            
            ],
        ),
      ),
    );
  }
}