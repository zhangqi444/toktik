import 'package:flutter/material.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/model/response/user_work_list_response.dart';
import 'package:toktik/page/widget/user_item_grid_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';

class UserWorkListWidget extends StatefulWidget {
  String? id;
  UserWorkListWidget({ String? id }) {
    this.id = id;
  }

  @override
  _UserWorkListWidgetState createState() {
    return _UserWorkListWidgetState();
  }
}

class _UserWorkListWidgetState extends State<UserWorkListWidget> {
  UserController _userController = Get.find();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.cover_list_background_color,
      body: _getBody(context),
    );
  }

  _getBody(BuildContext context) {
    List<String> workList = _userController.userVideoCoverList[widget.id];
    if(null == workList || workList.length == 0){
      return Container();
    }else{
      return Container(
        padding: EdgeInsets.only(top: 8),
        color: ColorRes.cover_list_background_color,
        child: GridView.builder(
          //处理GridView顶部空白
          padding: EdgeInsets.zero,
          itemCount: workList.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
              crossAxisCount: 3,
              //纵轴间距
              mainAxisSpacing: 1,
              //横轴间距
              crossAxisSpacing: 5,
              //子组件宽高长度比例
              childAspectRatio: 4/6),
          itemBuilder: (BuildContext context, int index) {
            return UserItemGridWidget(
              url: workList[index],
              onTap: (){
                // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoListPage(videoList: _userModel.worksVideo,)));
              },
            );
          },
        ),
      );
    }
  }
}