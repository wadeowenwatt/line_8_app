import 'package:flutter/material.dart';

class EventCardWidget extends StatelessWidget {
  const EventCardWidget({
    super.key,
    // required this.item,
  });

  // final Request item;

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
            const Text(
              "Abcdef",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: Colors.grey,
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
                        text: const TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.access_time,
                                size: 17,
                                color: Colors.blue,
                              ),
                            ),
                            TextSpan(
                              text: "12 Jan 21, 09:00 AM",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
                      ),
                      const Text(
                        "asdasdasdkasdmsakdmkamsdmakmsdkamsdkmakmsdkmakmsdkamksdmkamsdkmkmasdm",
                        style: TextStyle(color: Colors.black),
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
