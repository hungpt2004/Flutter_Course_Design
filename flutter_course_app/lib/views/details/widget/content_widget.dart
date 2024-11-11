import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flutter/material.dart';
import 'content_widget/comment_content_widget.dart';
import 'content_widget/lesson_content_widget.dart';
import 'content_widget/support_content_widget.dart';

class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<ContentWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        TabBar(
          dividerColor: kCardTitleColor,
          indicatorWeight: 3,
          unselectedLabelColor: kCardTitleColor,
          indicatorColor: kPrimaryColor,
          tabAlignment: TabAlignment.fill,
          controller: _tabController,
          tabs: [
            TextStyleApp.tabviewText("Content", 16, FontWeight.w500),
            TextStyleApp.tabviewText("Support", 16, FontWeight.w500),
            TextStyleApp.tabviewText("Comment", 16, FontWeight.w500)
          ],
        ),
        Expanded(
          child: TabBarView(controller: _tabController, children: const [
            LessonContentWidget(),
            SupportContentWidget(),
            CommentContentWidget()
          ]),
        )
      ],
    );
  }
}




