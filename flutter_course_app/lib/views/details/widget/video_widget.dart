import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../models/course.dart';
import '../../../theme/data/style_button.dart';

class VideoPlayWidget extends StatefulWidget {
  const VideoPlayWidget({super.key, required this.course});

  final Course course;

  @override
  State<VideoPlayWidget> createState() => _VideoPlayWidgetState();
}

class _VideoPlayWidgetState extends State<VideoPlayWidget> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController: VideoPlayerController.asset(widget.course.url)
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          }));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
              children: [
                Stack(
                  children: [
                    FlickVideoPlayer(flickManager: flickManager),
                    Positioned(
                      top: 0,
                      left: 15,
                      child: ButtonStyleApp.backButton(context),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
