import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:ozay_restaurant_app/core/User/bloc/user_bloc.dart';
import 'package:ozay_restaurant_app/view/cart_page.dart';
import 'package:ozay_restaurant_app/view/home_page.dart';
import 'package:ozay_restaurant_app/view/login_view.dart';
import 'package:ozay_restaurant_app/view/profile_edit_page.dart';
import 'package:ozay_restaurant_app/view/register_view.dart';
import '../core/User/model/user_model.dart';
import '../products/components/bottom_bar.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Profile",
        ),
      ),
      body: ScreenUtilInit(
        builder: (context, child) {
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state.isUserLoggedIn == false) {
                return Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Please login to see your profile"),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginView()),
                          );
                        },
                        child: Text("Login"),
                      ),
                      Text("Don't you have account?"),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterView()),
                          );
                        },
                        child: Text("Register"),
                      ),
                    ],
                  )),
                );
              }
              return SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 18.r, bottom: 15.r),
                        margin: EdgeInsets.only(top: 25.r),
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              Image.asset('assets/images/user_avatar.png')
                                  .image,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.r),
                        child: Text(
                          '${state.user!.name.toString()}${state.user!.surname.toString()}',
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
                        onTap: () {
                          final UserModel? userModel = state.user;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileEditPage(
                                      user: userModel,
                                    )),
                          );
                        },
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
                            'Other Informations',
                            style: TextStyle(
                              color: Color(0xff1E1E1E),
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Poppins-Regular.ttf',
                            ),
                          ),
                        ),
                      ]),
                      applicationSettingListTile(
                          "Cart", "View products in your cart", () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CartPage()),
                        );
                      }),
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<UserBloc>()
                              .add(LogoutEvent(context: context));
                        },
                        child: Text("Logout"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const BottomBar(),
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
