import 'package:flutter/material.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
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
          // color: ColorRes.color_2,
          // width: MediaQuery.of(context).size.width,
          // height: _widgetHeight,
        )
    );
  }
  //头像等
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
  //登录用户返回
  _getLoginUser(){
    return InkWell(
      onTap: (){
        Get.toNamed(Routers.editUserInfo);
      },
      child: Container(
        height: 37,
        margin: EdgeInsets.only(left: 10,right: 16),
        decoration: BoxDecoration(
          color: ColorRes.color_1.withAlpha(20),
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.center,
        child: Text('Edit Profile',style: TextStyle(color: Colors.black,fontSize: 15),),
      ),
    );
  }
  //一般用户返回
  _getCommonUser(){
    return InkWell(
      onTap: (){
        setState(() {
          focus = !focus;
        });
      },
      child: Container(
        height: 37,
        margin: EdgeInsets.only(left: 10,right: 16),
        decoration: BoxDecoration(
          color: focus?ColorRes.color_2.withAlpha(20):ColorRes.color_3,
          borderRadius: BorderRadius.circular(2),
        ),
        alignment: Alignment.center,
        child: Text(focus?'Unfollow':'+  Follow',style: TextStyle(color: Colors.black,fontSize: 15),),
      ),
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
            Text(userEx == null ? '' : userEx.username,
              style: TextStyle(color: ColorRes.text_color, fontSize: 16),),
            SizedBox(height: 24,),
            // SizedBox(height: 5,),
            // Text('ID：${widget.id}',
            //   style: TextStyle(color: ColorRes.color_1,fontSize: 12),
            // ),
            // SizedBox(height: 10,),
            // Divider(color: Colors.black.withAlpha(100),height: 0.05,),
            // SizedBox(height: 10,),
            // Text(user == null ? '' : user.bio,
            //   style: TextStyle(color: Colors.black,fontSize: 14),),
            // SizedBox(height: 5,),
            // _getSexCity(),
            // SizedBox(height: 10,),
            _getNumberLayout(),
            SizedBox(height: 10,),
          ],
        )
      );
    });
  }

  _getSexCity(user) {
    return Row(
      children: [
        //性别
        Container(
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: ColorRes.color_2.withAlpha(50),
            borderRadius: BorderRadius.circular(2),
          ),
          // child: Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     _getImgGender(context),
          //     SizedBox(width: 2,),
          //     _getAge(context)
          //   ],
          // ),
        ),
        //城市
        Container(
          padding: EdgeInsets.all(3),
          margin: EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
            color: ColorRes.color_2.withAlpha(50),
            borderRadius: BorderRadius.circular(2),
          ),
          child:  Text(user == null || user.city == null
              ? ''
              : user.city,
            style: TextStyle(color: Colors.black,fontSize: 10),),
        ),
      ],
    );
  }
  //获赞数、关注数、粉丝
  _getNumberLayout() {
    return Obx(() {
      var response = _userController.userExMap[widget.id];
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Column(
            children: [
              Text(response == null ? '' : response.followingCount.toString(),
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
              SizedBox(width: 2,),
              Text('Following',
                  style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
            ],
          ),
          SizedBox(width: 32,),
          Column(
            children: [
              Text(response == null ?'':response.followerCount.toString(),
                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),
              SizedBox(width: 2,),
              Text('Followers',
                  style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
            ],
          ),
          SizedBox(width: 32,),
          Column(
            children: [
              Text(response == null ? '' : response.likeCount.toString(),
                  style: TextStyle(color: ColorRes.text_color,fontWeight: FontWeight.bold,fontSize: 16)),
              SizedBox(width: 2,),
              Text('Likes',
                  style: TextStyle(color: ColorRes.text_color,fontSize: 13)),
              SizedBox(width: 15,),
            ],
          ),
        ]);
    });
  }

  //获取性别图标
  _getImgGender(BuildContext context) {
    return Obx((){
      var user = _userController.userExMap[widget.id].user;
      if(user == null || user.gender == null){
        return Image.asset('assets/images/male.webp',
          width: 10,
          height: 10,
        );
      } else {
        int? gender = 2;
        if(user != null) gender = user.gender;
        return Image.asset(gender == 2?'assets/images/male.webp':'assets/images/famale.webp',
          width: 10,
          height: 10,
        );
      }
    });
  }
  //获取年龄
  _getAge(BuildContext context) {
    return Obx((){
      var user = _userController.userExMap[widget.id].user;
      if(user == null || user.birth == null) {
        return Container();
      }else{
        String birth = user.birth;
        List<String> tempArr = birth.split('-');
        int age = DateTime.now().year - int.parse(tempArr[0]);
        return  Text('$age',
          style: TextStyle(color: Colors.black,fontSize: 10),);
      }
    });
  }
}