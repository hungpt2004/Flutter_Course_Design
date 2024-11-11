import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/document_provider.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_image.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:course_app_flutter/theme/responsive/style_responsive.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentDetailScreen extends StatelessWidget {
  const DocumentDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final docProvider = DocumentProvider.documentStateManagement(context);

    return Scaffold(
      backgroundColor: homeBackgroundColor,
      appBar: TextStyleApp.appbarStyle("Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: StyleSize(context).figmaWidth,
              height: StyleSize(context).heightPercent(150),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child:
                    ImageNetworkStyle.networkImage(docProvider.document!.url),
              ),
            ),
            SpaceStyle.boxSpaceHeight(10, context),
            Center(
                child: TextStyleApp.normalText(docProvider.content!.title, 35,
                    FontWeight.w700, kCardTitleColor)),
            SpaceStyle.boxSpaceHeight(10, context),
            Container(
              width: StyleSize(context).screenWidth,
              height: StyleSize(context).heightPercent(100),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.withOpacity(0.2)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Author 👤: ${docProvider.content!.author}",style: TextStyleApp.textStyleForm(16, FontWeight.w500, kPrimaryColor),),
                    Text("Date publish 📅: ${DateTime.parse(docProvider.content!.createdAt)}",style: TextStyleApp.textStyleForm(16, FontWeight.w500, kPrimaryColor),),
                  ],
                ),
              )
            ),
            SpaceStyle.boxSpaceHeight(10, context),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                  docProvider.content!
                      .description, // Giả sử contentText là nội dung của tài liệu
                  style: TextStyleApp.textStyleForm(
                      18, FontWeight.w500, kCardTitleColor)),
            ),
            SpaceStyle.boxSpaceHeight(20, context),
            Row(
              children: [
                Text(
                  "Read more:",
                  style: TextStyleApp.textStyleForm(
                      16, FontWeight.w500, kCardTitleColor),
                ),
                SizedBox(
                  width: StyleSize(context).widthPercent(StyleSize(context).figmaWidth * 0.65),
                  child: MaterialButton(onPressed: (){
                    launchUrl(Uri.parse(docProvider.content!.bookUrl));
                  },child: TextStyleApp.underlineText("Link Docs Here", 16, FontWeight.w500, kCardTitleColor),)
                )
              ],
            ),
            SpaceStyle.boxSpaceHeight(20, context),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
