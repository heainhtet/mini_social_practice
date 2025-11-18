import 'package:flutter/material.dart';

class PrimaryListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool isMe;
  final bool isHome;
  final String? time;
  const PrimaryListTile({
    super.key,
    required this.title,
    required this.subTitle,
    this.isMe = false,
    this.isHome = false,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.secondary,
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(4),
      ),
      // padding: EdgeInsets.all(8),
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(8),
        margin: isHome
            ? isMe
                  ? EdgeInsets.only(left: 80)
                  : EdgeInsets.only(right: 80)
            : null,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: isHome
              ? isMe
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start
              : CrossAxisAlignment.start,
          children: [
            isHome
                ? Row(
                    mainAxisAlignment: isMe
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Text(
                        "$time",
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 10,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            Text(
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              subTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );

    // Padding(
    //   padding:  EdgeInsets.symmetric(horizontal: 16,vertical: 2),
    //   child: ListTile(
    //     tileColor: Theme.of(context).colorScheme.primary,
    //     title: Text(title),
    //     subtitle: Text(
    //       subTitle,
    //       style: TextStyle(
    //         fontWeight: FontWeight.bold,
    //         color: Theme.of(context).colorScheme.secondary),
    //     ),
    //   ),
    // );
  }
}
