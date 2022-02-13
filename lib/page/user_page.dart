import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toktik/common/router_manager.dart';
import 'package:toktik/controller/main_page_scroll_controller.dart';
import 'package:toktik/controller/user_controller.dart';
import 'package:toktik/controller/self_controller.dart';
import 'package:toktik/controller/user_page_controller.dart';
import 'package:toktik/page/widget/spinner_widget.dart';
import 'package:toktik/page/widget/user_info_widget.dart';
import 'package:toktik/page/widget/user_item_grid_widget.dart';
import 'package:toktik/page/widget/user_more_bottom_sheet.dart';
import 'package:toktik/page/widget/user_work_list_widget.dart';
import 'package:toktik/res/colors.dart';
import 'package:get/get.dart';
import 'package:toktik/util/string_util.dart';

import '../enum/navigation_argument.dart';

const TAB_SIZE = 1;

class UserPage extends StatefulWidget {
  bool? _isLoginUser;
  String? id;
  UserPage({bool? isLoginUser, String? id}){
    this._isLoginUser = isLoginUser;
    this.id = id;
  }

  @override
  _UserPageState createState() {
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  MainPageScrollController _mainController = Get.find();
  UserPageController _userPageController = Get.put(UserPageController());
  TabController? _tabController;
  PageController _pageController = PageController(keepPage: true);
  ScrollController _scrollController = ScrollController();
  UserController _userController = Get.put(UserController());
  SelfController _selfController = Get.put(SelfController());
  dynamic argumentData = Get.arguments;
  var amplifyConfiguredListner;

  @override
  void initState() {
    super.initState();

    if(argumentData != null) {
      widget.id = argumentData[NavigationArgument.ID];
      widget._isLoginUser = argumentData[NavigationArgument.IS_LOGIN_USER];
    }

    _tabController = TabController(length: TAB_SIZE, vsync: this);
    _scrollController.addListener(() {
      double position =_scrollController.offset;
      bool showTitle = _userPageController.showTitle.value;
      if(position > 145 && !showTitle){
        _userPageController.setShowTitle(true);
      }else if(position < 145 && showTitle){
        _userPageController.setShowTitle(false);
      }
    });

    WidgetsBinding.instance!.addPostFrameCallback((_bottomBarLayout) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    });

    initData();
  }

  void initData() async {
    String? id = widget.id;
    if(id != null) {
      await _userController.loadUserInfoExById(id);
    }
    return;
    // TODO: disbale before we have the api reday.
    // _userController.getUserWorkList(id);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    if(amplifyConfiguredListner != null) {
      amplifyConfiguredListner.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() =>
      Stack(
        children: [
          Scaffold(
            backgroundColor: ColorRes.color_2,
            body: CustomScrollView(
              controller: _scrollController,
              physics: BouncingScrollPhysics(),
              slivers: [
                _getSliverAppBar(),
                _getSliverUserInfo(),
                _getTabBarLayout(),
                _getTabViewLayout(),
              ],
            )
          ),
          SpinnerWidget(isStringNullOrEmpty(widget.id) || _userController.userExMap[widget.id] == null),
        ]
      )
    );
  }

  _getSliverAppBar(){
    return  SliverAppBar(
      brightness:Brightness.light,
      backgroundColor:ColorRes.light_background_color,
      pinned: true,
      expandedHeight: 50,
      leading: widget._isLoginUser!?null:IconButton(
        onPressed: (){
          Get.back();
        },
        icon: Icon(Icons.arrow_back_ios_rounded,color: ColorRes.light_icon_color,),
      ),
      actions: [
        IconButton(
          onPressed: (){
            if( widget._isLoginUser!){
              Get.toNamed(Routers.setting);
            }else{
              _showMore();
            }
          },
          icon: Icon( widget._isLoginUser!?Icons.menu:Icons.more_horiz_rounded,color: ColorRes.light_icon_color,),
        ),
      ],
      elevation: 0,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: [StretchMode.zoomBackground],
        collapseMode: CollapseMode.parallax,
        title: Obx(()=> Text(_userPageController.showTitle.value?_userController.userExMap[widget.id].user.username:'')),
        centerTitle:true,
      ),
      // stretchTriggerOffset:145,
      onStretchTrigger:(){
        print('onStretchTrigger');
        return;
      } as Future<void> Function()?,
    );
  }

  _getSliverUserInfo() {
    return SliverToBoxAdapter(
      child: UserInfoWidget(
        isLoginUser: widget._isLoginUser,
        id: widget.id,
      ),
    );
  }

  _getTabBarLayout() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Container(
            color: ColorRes.color_2,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                TabBar(
                  controller: _tabController,
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 2.0, color: ColorRes.tab_bottom_border_color),
                    insets: EdgeInsets.symmetric(horizontal: 174.0, vertical: 5),
                  ),
                  labelStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.black),
                  unselectedLabelStyle:TextStyle(fontSize: 15,color: Colors.grey),
                  tabs: <Widget>[
                    new Container(
                      height: 50,
                      width: 80,
                      child: Tab(
                        child: Icon(Icons.grid_view, color: Colors.black),
                      ),
                    ),
                    // Tab(
                    //   child: Icon(Icons.favorite_border, color: Colors.black),
                    // ),
                  ],
                  // onTap: (index){
                  //   _pageController.animateToPage(index, duration: Duration(milliseconds: 200), curve: Curves.linear);
                  // },
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: ColorRes.divider_color, width: 1),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _getTabViewLayout() {
    //计算Item的高度
    double itemWidth = MediaQuery.of(context).size.width / 3;
    double itemHeight = itemWidth / 9 * 16;

    return SliverToBoxAdapter(
      child: Obx(()=>
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              minWidth: MediaQuery.of(context).size.width,
              maxHeight:itemHeight * _userController.userWorkList.length / 3,
            ),
            child:  PageView.builder(
              controller: _pageController,
              itemCount:2,
              itemBuilder: (context,index){
                return index == 0?UserWorkListWidget():_getPageLayout(index);
              },
              onPageChanged: (index){
                _tabController!.animateTo(index);
              },
            ),
          ),
      ),
    );
  }

  //获取PageView的每页
  Widget _getPageLayout(int index) {

    return Container(
      color: ColorRes.color_2,
      child: GridView.builder(
        //处理GridView顶部空白
        padding: EdgeInsets.zero,
        itemCount: _userController.userWorkList.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 3,
            //纵轴间距
            mainAxisSpacing: 1,
            //横轴间距
            crossAxisSpacing: 1,
            //子组件宽高长度比例
            childAspectRatio: 9/16),
        itemBuilder: (BuildContext context, int index) {
          return UserItemGridWidget(
            url: _userController.userWorkList[index]!.content!.attachments![0]!.cover,
            onTap: (){
              // Navigator.push(context, MaterialPageRoute(builder: (context) => VideoListPage(videoList: _userModel.worksVideo,)));
            },
          );
        },
      ),
    );
  }

  void _showMore() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: false, //可滚动 解除showModalBottomSheet最大显示屏幕一半的限制
        shape: RoundedRectangleBorder(borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),),
        builder: (context){
          return UserMoreBottomSheet();
        });
  }

}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize child;

  StickyTabBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
