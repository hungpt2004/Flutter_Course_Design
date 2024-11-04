import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/provider/course_provider.dart';
import 'package:course_app_flutter/provider/loading_provider.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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

    final courseProvider = CourseProvider.stateCourseManagement(context);

    return Column(
      children: [
        TabBar(
          dividerColor: homeBackgroundColor,
          indicatorWeight: 3,
          unselectedLabelColor: Colors.orange.withOpacity(0.9),
          indicatorColor: Colors.orange.withOpacity(0.9),
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
            SupportWidget(),
            CommentWidget()
          ]),
        )
      ],
    );
  }
}

class LessonContentWidget extends StatefulWidget {
  const LessonContentWidget({super.key});

  @override
  State<LessonContentWidget> createState() => _LessonContentWidgetState();
}

class _LessonContentWidgetState extends State<LessonContentWidget> {

  @override
  Widget build(BuildContext context) {
    final courseProvider = CourseProvider.stateCourseManagement(context);
    final loadingProvider = LoadingProvider.stateLoadingProvider(context);

    return ListView.builder(
      itemCount: courseProvider.currentCourse.videos.length,
      itemBuilder: (context, index) {
        final videos = courseProvider.currentCourse.videos;
        final videoIndex = videos[index];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Card(
            elevation: 10,
            shadowColor: Colors.grey.withOpacity(0.5),
            color: Colors.orange.withOpacity(0.9),
            child: Column(
              children: [
                ListTile(
                  leading: IconButton(
                    onPressed: ()  {
                      loadingProvider.toggleExpanded(index);
                    },
                    icon: const Icon(Icons.play_circle_outline_outlined),
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    videoIndex.title,
                    style: TextStyleApp.textStyleForm(
                        16, FontWeight.w700, kPrimaryColor),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: loadingProvider.currentIndex == index ? 180 : 0,
                  child: loadingProvider.currentIndex == index
                      ? VideoItem(urlVideo: videoIndex.url,)
                      : null,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

// VIDEO TAB VIEW
class VideoItem extends StatefulWidget {
  const VideoItem({super.key, required this.urlVideo});

  final String urlVideo;

  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late FlickManager flickManager;
  
  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.asset(widget.urlVideo)
        ..initialize().then((_) {
          // Rebuild after initialization to display the video properly
          setState(() {});
        }),
    );
    super.initState();
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 4), // Padding around the video
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: FlickVideoPlayer(
            flickManager: flickManager),
      ),
    );
  }
}

// SUPPORT TAB VIEW
class SupportWidget extends StatelessWidget {
  const SupportWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("SUPPORT");
  }
}

// COMMENT TAB VIEW
class CommentWidget extends StatelessWidget {
  const CommentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("COMMENT");
  }
}
