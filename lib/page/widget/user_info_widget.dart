import 'package:flutter/material.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

///用户信息
class UserInfoWidget extends StatefulWidget {
  bool? isLoginUser;
  String? id;

  UserInfoWidget({bool? isLoginUser, String? id}){
    this.isLoginUser = isLoginUser;
    this.id = id;
  }

  @override
  _UserInfoWidgetState createState() {
    return  _UserInfoWidgetState();
  }
}

class _UserInfoWidgetState extends State<UserInfoWidget> {
  UserController _userController = Get.put(UserController());
  double _widgetHeight = 320;
  bool focus = false;
  bool isLoginUser = true;

  @override
  void initState() {
    super.initState();
  }

  //获取控件高度
  double getWidgetHeight(){
    return _widgetHeight;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var userEx = _userController.userExMap[widget.id] != null
          ? _userController.userExMap[widget.id].user
          : null;

      if (userEx == null) {
        return Container();
      }

      return Stack(
        children: [
          //背景颜色
          _getBackgroundColor(),
          Column(
            children: [
              //头像、用户名、关注
              _getHeaderLayout(),
              //用户信息
              _getUserInfoLayout(),
            ],
          ),
        ],
      );
    });
  }


  //背景颜色
  _getBackgroundColor() {
    return Positioned(
        top: 0,
        child: Container(
          color: ColorRes.light_background_color,
        )
    );
  }
  
  //头像
  _getHeaderLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          var userEx = _userController.userExMap[widget.id].user;
          return Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                    image: ((userEx == null || userEx.portrait == null || userEx.portrait.isEmpty)
                        ? AssetImage('assets/images/person_holder.png')
                        : NetworkImage(userEx.portrait)) as ImageProvider<Object>,
                    fit: BoxFit.cover
                )
            ),
          );
        }),
         // Expanded(
         //   child: _userController.isLoginUser.value?_getLoginUser():_getCommonUser(),
         // ),
      ],
    );
  }

  _getUserInfoLayout() {
    return Obx(() {
      var userEx = _userController.userExMap[widget.id].user;
      return Container(
        margin: EdgeInsets.only(left: 12,right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 12,),
            Text(userEx == null ? '' : '@' + userEx.username,
              style: TextStyle(color: ColorRes.text_color, fontSize: 18),),
            SizedBox(height: 22,),
            _getNumberLayout(),
            SizedBox(height: 20,),
          ],
        )
      );
    });
  }

  //获赞数、关注数、粉丝
  _getNumberLayout() {
    return Obx(() {
      var response = _userController.userExMap[widget.id];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(response == null ? '' : response.followingCount.toString(),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                SizedBox(width: 2,),
                Text('Following',
                    style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(response == null ?'':response.followerCount.toString(),
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
                SizedBox(width: 2,),
                Text('Followers',
                    style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(response == null ? '' : response.likeCount.toString(),
                    style: TextStyle(color: ColorRes.text_color,fontWeight: FontWeight.bold,fontSize: 16)),
                SizedBox(width: 2,),
                Text('Likes',
                    style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
              ],
            ),
          )
        ]);
    });
  }
}