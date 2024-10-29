import 'package:course_app_flutter/constant/color.dart';
import 'package:course_app_flutter/theme/style/space_style.dart';
import 'package:course_app_flutter/theme/style/style_text.dart';
import 'package:course_app_flutter/views/form/widget/form_login.dart';
import 'package:course_app_flutter/views/form/widget/form_register.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  bool isLoading1 = false;
  bool isLoading2 = false;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SpaceStyle.boxSpaceHeight(80),
                Container(
                  width: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: Colors.white, // Màu văn bản khi không chọn
                          labelColor: kPrimaryColor,
                          indicator: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          dividerColor: Colors.transparent,
                          controller: tabController,
                          tabs: [
                            Tab(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextStyleApp.tabviewText("Sign In", 16,
                                    FontWeight.w700),
                              ),
                            ),
                            Tab(
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: TextStyleApp.tabviewText("Sign Up", 16,
                                    FontWeight.w700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: const [
                      FormLoginWidget(),
                      FormRegiterWidget(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
