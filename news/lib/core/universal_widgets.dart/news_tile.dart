import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsTile extends StatelessWidget {
  const NewsTile({
    required this.imgUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.publishedAt,
    required this.height,
    required this.width,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String imgUrl;
  final String title;
  final String description;
  final String author;
  final DateTime publishedAt;
  final double? height;
  final double? width;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(18.0),
        padding: const EdgeInsets.all(18.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
              )
            ],
            border:
                Border.all(color: Colors.white.withOpacity(0.2), width: 1.0),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CachedNetworkImage(
              imageUrl: imgUrl,
              height: 250,
              width: width,
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text("by $author")),
                Text(" on ${DateFormat('yyyy-MM-dd').format(publishedAt)}"),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// class NewsTile2 extends StatelessWidget {
//   const NewsTile2(
//       {required this.imgUrl,
//       required this.title,
//       required this.description,
//       required this.author,
//       required this.publishedAt,
//       required this.height,
//       required this.width,
//       required this.onTap,
//       super.key});

//   final String imgUrl;
//   final String title;
//   final String description;
//   final String author;
//   final DateTime publishedAt;
//   final double? height;
//   final double? width;
//   final void Function()? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(18.0),
//       padding: const EdgeInsets.all(18.0),
//       height: height,
//       width: width,
//       child: Flexible(
//         child: Row(
//           // crossAxisAlignment: CrossAxisAlignment.end,

//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CachedNetworkImage(
//               imageUrl: imgUrl,
//               height: 250,
//               width: width,
//             ),
//             Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   "title",
//                   style: const TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   "description",
//                   maxLines: 5,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Expanded(child: Text("by $author")),
//                     Text(" on ${DateFormat('yyyy-MM-dd').format(publishedAt)}"),
//                   ],
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
