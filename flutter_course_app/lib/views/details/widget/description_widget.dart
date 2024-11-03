import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/data/space_style.dart';
import 'package:course_app_flutter/theme/data/style_text.dart';
import 'package:course_app_flutter/theme/data/style_toast.dart';
import 'package:flutter/material.dart';
import '../../../models/course.dart';
import '../../../provider/favorite_provider.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {

    final favoriteProvider = FavoriteProvider.stateFavoriteManagement(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.orange.withOpacity(0.9)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Center(
                    child: Text(course.company, style: TextStyleApp.textStyleForm(24, FontWeight.w700, kPrimaryColor),),
                  ),
                ),
              ),
              TextButton(
                  onPressed: (){
                bool check = favoriteProvider.addFavorite(course);
                if(check){
                  ToastStyle.toastSuccess("Add favorite course success");
                }
                ToastStyle.toastSuccess("Add favorite course failed");
              }, child: SizedBox(width: 30,height: 30,child: favoriteProvider.isFavorite ? Image.asset("assets/images/save.png")  : Image.asset("assets/images/save_click.png"),))
            ],
          ),
          SpaceStyle.boxSpaceHeight(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextStyleApp.normalText("⭐ ${course.rating}  (${course.totalReviews} views)", 14, FontWeight.w500, Colors.white60),
              TextStyleApp.normalText("🕔 ${course.time}", 14, FontWeight.w500, Colors.white60),
            ],
          ),
          SpaceStyle.boxSpaceHeight(10),
          Row(
            children: [
              Expanded(
                child: Wrap(
                  children: [
                    Text(course.description,style: TextStyleApp.textStyleForm(14, FontWeight.w500, Colors.white60),)
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
