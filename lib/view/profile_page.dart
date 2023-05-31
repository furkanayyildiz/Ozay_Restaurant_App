import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/User/bloc/user_bloc.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import '../products/widget/profile/constants.dart';
import '../products/widget/profile/profile_list_item.dart';
import "../products/widget/pop_appbar.dart";

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenUtilInit(
        builder: (context, child) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20.r, top: 20.r),
                            height: 34.h,
                            width: 34.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff236BFD),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: const Center(
                                child: Icon(
                                  Icons.arrow_left_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20.r, top: 20.r),
                            height: 25.h,
                            width: 100.w,
                            child: const Text(
                              "Profile",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins-Regular.ttf',
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.r),
                            height: 25.h,
                            width: 20.w,
                          )
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.r),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              Image.asset('assets/images/logo.png').image,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.r),
                        child: Text(
                          '${state.user!.name.toString()} ${state.user!.surname.toString()}',
                          style: const TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 25,
                              fontFamily: 'Poppins-Regular.ttf',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.r),
                        child: Text(
                          state.user!.email.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff666666),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular.ttf',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.r),
                        child: Text(
                          state.user!.phone.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xff666666),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular.ttf',
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15.r),
                        child: const Divider(
                          height: 10,
                          thickness: 2,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.r, left: 15.r),
                            child: const Text(
                              'Account Setting',
                              style: TextStyle(
                                  color: Color(0xff1E1E1E),
                                  fontSize: 19,
                                  fontFamily: 'Poppins-Regular.ttf',
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      ListTile(
                        onTap: () {},
                        title: const Text(
                          'Your Info',
                          style: TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 15,
                              fontFamily: 'Poppins-Regular.ttf',
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: const Text(
                          "Edit and view your information",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xff666666),
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Poppins-Regular.ttf',
                          ),
                        ),
                        trailing: InkWell(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(top: 10.r),
                            child: const Icon(
                              Icons.arrow_forward_ios_sharp,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 0.r),
                          child: const Divider(
                            height: 10,
                            thickness: 2,
                          )),
                      Row(children: [
                        Container(
                          margin: EdgeInsets.only(top: 15.r, left: 15.r),
                          child: const Text(
                            'Application Settings',
                            style: TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins-Regular.ttf',
                            ),
                          ),
                        ),
                      ]),
                      applicationSettingListTile("hey", "hey", () {
                        MaterialPageRoute(
                            builder: (context) => const HomePage());
                      }),
                      applicationSettingListTile("hey", "hey", () {
                        MaterialPageRoute(
                            builder: (context) => const HomePage());
                      }),
                      applicationSettingListTile("hey", "hey", () {
                        MaterialPageRoute(
                            builder: (context) => const HomePage());
                      }),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          margin: EdgeInsets.only(top: 15.r),
                          child: Text(
                            'Log Out',
                            style: const TextStyle(
                                color: Color(0xffFE0000),
                                fontSize: 20,
                                fontFamily: 'Poppins-Regular.ttf',
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  ListTile applicationSettingListTile(
      String title, String subtitle, Function() onTap) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Color(0xff666666),
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins-Regular.ttf',
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          fontSize: 12,
          color: Color(0xff666666),
          fontWeight: FontWeight.normal,
          fontFamily: 'Poppins-Regular.ttf',
        ),
      ),
      trailing: InkWell(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.only(top: 10.r),
          child: const Icon(
            Icons.arrow_forward_ios_sharp,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
