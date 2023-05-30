import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/User/bloc/user_bloc.dart';
import 'package:ozay_restaurant_app/products/widget/pop_appbar.dart';
import '../products/widget/profile/constants.dart';
import '../products/widget/profile/profile_list_item.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      context,
      designSize: const Size(414, 896),
    );
    return ThemeSwitchingArea(
      child: Builder(
        builder: (context) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Scaffold(
                body: Column(
                  children: <Widget>[
                    SizedBox(height: kSpacingUnit.w * 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(width: kSpacingUnit.w * 3),
                        IconButton(
                          icon: Icon(
                            LineAwesomeIcons.arrow_left,
                            size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: kSpacingUnit.w * 10,
                                width: kSpacingUnit.w * 10,
                                margin:
                                    EdgeInsets.only(top: kSpacingUnit.w * 3),
                                child: Stack(
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: kSpacingUnit.w * 5,
                                      backgroundImage:
                                          AssetImage('assets/images/logo.png'),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: kSpacingUnit.w * 2.5,
                                        width: kSpacingUnit.w * 2.5,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          heightFactor: kSpacingUnit.w * 1.5,
                                          widthFactor: kSpacingUnit.w * 1.5,
                                          child: Icon(
                                            LineAwesomeIcons.pen,
                                            color: kDarkPrimaryColor,
                                            size: ScreenUtil()
                                                .setSp(kSpacingUnit.w * 1.5),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: kSpacingUnit.w * 2),
                              Text(
                                state.user!.name + "" + state.user!.surname,
                                style: kTitleTextStyle,
                              ),
                              SizedBox(height: kSpacingUnit.w * 0.5),
                              Text(
                                state.user!.email,
                                style: kCaptionTextStyle,
                              ),
                              SizedBox(height: kSpacingUnit.w * 2),
                              Container(
                                height: kSpacingUnit.w * 4,
                                width: kSpacingUnit.w * 20,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(kSpacingUnit.w * 3),
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                ),
                                child: Center(
                                  child: Text(
                                    'Upgrade to PRO',
                                    style: kButtonTextStyle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ThemeSwitcher(
                          builder: (context) {
                            return AnimatedCrossFade(
                              duration: Duration(milliseconds: 200),
                              crossFadeState: Theme.of(context).brightness ==
                                      Brightness.dark
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              firstChild: GestureDetector(
                                onTap: () => ThemeSwitcher.of(context)
                                    .changeTheme(theme: kLightTheme),
                                child: Icon(
                                  LineAwesomeIcons.sun,
                                  size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                                ),
                              ),
                              secondChild: GestureDetector(
                                onTap: () => ThemeSwitcher.of(context)
                                    .changeTheme(theme: kDarkTheme),
                                child: Icon(
                                  LineAwesomeIcons.moon,
                                  size: ScreenUtil().setSp(kSpacingUnit.w * 3),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(width: kSpacingUnit.w * 3),
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        children: const [
                          ProfileListItem(
                            icon: LineAwesomeIcons.user_shield,
                            text: 'Privacy',
                          ),
                          ProfileListItem(
                            icon: LineAwesomeIcons.history,
                            text: 'Purchase History',
                          ),
                          ProfileListItem(
                            icon: LineAwesomeIcons.question_circle,
                            text: 'Help & Support',
                          ),
                          ProfileListItem(
                            icon: LineAwesomeIcons.cog,
                            text: 'Settings',
                          ),
                          ProfileListItem(
                            icon: LineAwesomeIcons.user_plus,
                            text: 'Invite a Friend',
                          ),
                          ProfileListItem(
                            icon: LineAwesomeIcons.alternate_sign_out,
                            text: 'Logout',
                            hasNavigation: false,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
