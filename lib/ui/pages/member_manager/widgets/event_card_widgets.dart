import 'package:flutter/material.dart';
import 'package:flutter_base/models/entities/event/event_entity.dart';
import 'package:flutter_base/models/entities/request/request_entity.dart';
import 'package:flutter_base/utils/app_date_utils.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({
    super.key,
    required this.item,
  });

  final Event item;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title!,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    image: DecorationImage(
                      image:
                          AssetImage("assets/images/event_image_default.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: [
                            const WidgetSpan(
                              child: Icon(
                                Icons.access_time,
                                size: 17,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text: item.timeStart!.toDate().toDateTimeString(),
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        item.details!,
                        style: const TextStyle(color: Colors.black),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
