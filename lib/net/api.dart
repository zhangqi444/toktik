import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:amplify_analytics_pinpoint/amplify_analytics_pinpoint.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:toktik/common/sp_keys.dart';
import 'package:toktik/enum/auth_status.dart';
import 'package:toktik/model/request/follow_request.dart';
import 'package:toktik/model/request/publish_feed_request.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/model/response/follow_response.dart';
import 'package:toktik/model/response/like_response.dart';
import 'package:toktik/model/response/login_response.dart';
import 'package:toktik/model/response/logout_response.dart';
import 'package:toktik/model/response/publish_feed_response.dart';
import 'package:toktik/model/response/register_response.dart';
import 'package:toktik/model/response/upload_token_response.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/model/response/user_info_response.dart';
import 'package:toktik/model/brand_rank_model.dart';
import 'package:toktik/model/city_item_model.dart';
import 'package:toktik/model/living_rank_model.dart';
import 'package:toktik/model/message_model.dart';
import 'package:toktik/model/music_rank_model.dart';
import 'package:toktik/model/response/user_work_list_response.dart';
import 'package:toktik/model/response/view_response.dart';
import 'package:toktik/model/star_model.dart';
import 'package:toktik/model/user_model.dart';
import 'package:toktik/model/video_model.dart';
import 'package:toktik/model/living_commend_model.dart';
import 'package:toktik/models/ModelProvider.dart';
import 'package:toktik/net/http/http_manager.dart';
import 'package:toktik/net/http/http_method.dart';
import 'package:toktik/net/http_constant.dart';
import 'package:toktik/util/sp_util.dart';

import '../model/comment_model.dart';

class Api{
  /// ----------------------------------接口api--------------------------------------------------------
  //

  ///登录
  static Future<LoginResponse> login(String username, String password) async {

    await logout();

    Map<String, dynamic> result = HashMap();
    result['username'] = username;
    result['isSignedIn'] = false;
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      if(res != null && res.nextStep.signInStep == "DONE") {
        result['isSignedIn'] = res.isSignedIn;
        result["status"] = AuthStatus.SIGN_IN_DONE.toShortString();
        result['token'] = await _fetchAuthSession();
      }
    } on AuthException catch (e, stacktrack) {
      if(e is InvalidStateException) {
        result['isSignedIn'] = true;
        result["status"] = AuthStatus.SIGN_IN_DONE.toShortString();
        result['token'] = await _fetchAuthSession();
      } else if(e is UserNotFoundException) {
        result["status"] = AuthStatus.USER_NOT_FOUND.toShortString();
      } else if(e is NotAuthorizedException) {
        result["status"] = AuthStatus.NOT_AUTHORIZED.toShortString();
      } else {
        print("Fail to sign in: " + e.toString() + '\n' + stacktrack.toString());
      }
    }
    return LoginResponse().fromJson(result);
  }

  static Future<String> _fetchAuthSession() async{
    AuthSession authSession = await Amplify.Auth.fetchAuthSession(
      options: CognitoSessionOptions(getAWSCredentials: true),
    );
    if(authSession != null && (authSession as CognitoAuthSession).identityId != null) {
      return (authSession as CognitoAuthSession).userPoolTokens.accessToken;
    }
  }

  static Future<LogoutResponse> logout() async {
    try {
      var result = await Amplify.Auth.signOut();
      return result != null ? LogoutResponse().fromJson({}) : null;
    } on AuthException catch (e, stacktrack) {
      print("Fail to sign out: " + e.toString() + '\n' + stacktrack.toString());
    }
  }

  static Future<LoginResponse> getCurrentUser() async {
    try {
      var result = await Amplify.Auth.getCurrentUser();
      return result != null ? LoginResponse().fromJson({}) : null;
    } on AuthException catch (e, stacktrack) {
      print("Fail to get current user info: " + e.toString() + '\n' + stacktrack.toString());
    }
  }

  static Future<RegisterResponse> resendSignUpCode(String username) async{
    Map<String, dynamic> result = HashMap();
    result['username'] = username;
    try {
      ResendSignUpCodeResult res = await Amplify.Auth.resendSignUpCode(username: username);
      if(res != null && res.codeDeliveryDetails != null) {
        result["status"] = AuthStatus.CONFIRM_SIGN_UP_STEP;
      }
    } on AuthException catch (e, stacktrack) {
      if(e is UserNotFoundException) {
        result["status"] = AuthStatus.USER_NOT_FOUND.toShortString();
      } else {
        result["status"] = AuthStatus.UNKNOWN.toShortString();
      }
      print("Fail to sign up: " + e.toString() + '\n' + stacktrack.toString());
    }
    return RegisterResponse().fromJson(result);
  }

  ///注册
  static Future<RegisterResponse> registerByEmail(String email, String username, String pwd, String pwdRepeat) async{
    Map<String, dynamic> result = HashMap();
    result['username'] = username;
    try {
      Map<String, String> userAttributes = HashMap();
      userAttributes['email'] = email;
      SignUpResult res = await Amplify.Auth.signUp(
        username: username,
        password: pwd,
        options: CognitoSignUpOptions(
            userAttributes: userAttributes
        )
      );
      if(res != null) {
        result["isSignUpComplete"] = res.isSignUpComplete;
        result["status"] = res.nextStep.signUpStep;
      }
    } on AuthException catch (e, stacktrack) {
      result["isSignUpComplete"] = false;
      if(e is UsernameExistsException) {
        result["status"] = AuthStatus.USERNAME_EXISTS.toShortString();
      } else if(e is InvalidPasswordException) {
        result["status"] = AuthStatus.INVALID_PASSWORD.toShortString();
      } else if(e is InvalidParameterException) {
        result["isSignUpComplete"] = true;
        result["status"] = AuthStatus.SIGN_UP_DONE.toShortString();
      } else {
        print("Fail to sign up: " + e.toString() + '\n' + stacktrack.toString());
        result["status"] = AuthStatus.UNKNOWN.toShortString();
      }
    }
    return result.length == 0 ? null : RegisterResponse().fromJson(result);
  }

  ///注册
  static Future<RegisterResponse> confirmSignUp(
      String username, String confirmationCode, ConfirmSignUpOptions options) async {
    Map<String, dynamic> result = HashMap();
    try {
      SignUpResult res = await Amplify.Auth.confirmSignUp(
          username: username, confirmationCode: confirmationCode, options: options);
      if(res != null && res.isSignUpComplete && res.nextStep.signUpStep == "DONE") {
        result["isSignUpComplete"] = res.isSignUpComplete;
        result["status"] = AuthStatus.SIGN_UP_DONE.toShortString();
      } else {
        result = null;
      }
    } on AuthException catch (e, stacktrack) {
      if(e is NotAuthorizedException) {
        result["isSignUpComplete"] = true;
        result["status"] = AuthStatus.SIGN_UP_DONE.toShortString();
      } else if(e is AliasExistsException) {
        result["isSignUpComplete"] = false;
        result["status"] = AuthStatus.ALIAS_EXISTS.toShortString();
      } else {
        print("Fail to sign up: " + e.toString() + '\n' + stacktrack.toString());
      }
    }
    return RegisterResponse().fromJson(result);
  }

  static Future<RegisterResponse> resetPassword(
      String username, {ResetPasswordOptions options}) async {
    Map<String, dynamic> result = HashMap();
    result['username'] = username;
    try {
      ResetPasswordResult res = await Amplify.Auth.resetPassword(
          username: username,
          options: options
      );
      if(res != null) {
        result["isPasswordReset"] = res.isPasswordReset;
        result["status"] = res.nextStep.updateStep;
      }
    } on AuthException catch (e, stacktrack) {
      result["isPasswordReset"] = false;
      if(e is UserNotFoundException) {
        result["status"] = AuthStatus.USER_NOT_FOUND.toShortString();
      } else if(e is InvalidParameterException) {
        result["status"] = AuthStatus.INVALID_PASSWORD.toShortString();
      } else {
        print("Fail to sign up: " + e.toString() + '\n' + stacktrack.toString());
        result["status"] = AuthStatus.UNKNOWN.toShortString();
      }
    }
    return result.length == 0 ? null : RegisterResponse().fromJson(result);
  }

  static Future<RegisterResponse> confirmResetPassword(
      String username, String newPassword, String confirmationCode,
      {ConfirmResetPasswordOptions options}) async {
    Map<String, dynamic> result = HashMap();
    try {
      UpdatePasswordResult res = await Amplify.Auth.confirmResetPassword(
          username: username, newPassword: newPassword, confirmationCode: confirmationCode, options: options);
      if(res != null) {
        result["isPasswordReset"] = true;
        result["status"] = AuthStatus.RESET_PASSWORD_DONE.toShortString();
      } else {
        result = null;
      }
    } on AuthException catch (e, stacktrack) {
      if(e is NotAuthorizedException) {
        result["isPasswordReset"] = true;
        result["status"] = AuthStatus.SIGN_UP_DONE.toShortString();
      } else if(e is AliasExistsException) {
        result["isPasswordReset"] = false;
        result["status"] = AuthStatus.ALIAS_EXISTS.toShortString();
      } else {
        print("Fail to sign up: " + e.toString() + '\n' + stacktrack.toString());
      }
    }
    return RegisterResponse().fromJson(result);
  }

  static Future<UserInfoExResponse> createUser({String username, String email, String phoneNumber}) async {
    try {
      User user = User(username: username, email: email, phoneNumber: phoneNumber);
      await Amplify.DataStore.save(user);
      return _parseUsers([user], {username: username});
    } catch (e, stacktrace) {
      print("Could not create user: " + e.toString() + '\n' + stacktrace.toString());
    }
  }
  //

  ///获取用户资料信息(扩展)
  static Future<UserInfoExResponse> getUserInfoExByUsername(String username) async {
    try {
      List<User> users = await Amplify.DataStore.query(User.classType, where: User.USERNAME.eq(username));
      return _parseUsers(users, {username: username});
    } catch (e, stacktrace) {
      print("Could not query server: " + e.toString() + '\n' + stacktrace.toString());
    }
  }

  static Future<UserInfoExResponse> getUserInfoEx(String id) async{
    try {
      List<User> users = await Amplify.DataStore.query(User.classType, where: User.ID.eq(id));
      return _parseUsers(users, {id: id});
    } catch (e, stacktrace) {
      print("Could not query server: " + e.toString() + '\n' + stacktrace.toString());
    }
  }

  static UserInfoExResponse _parseUsers(List<User> users, Map<String, dynamic> params) {
    Map<String, dynamic> convert(User user) {
      Map<String, dynamic> result = {};
      var userJson = user.toJson();
      result['user'] = userJson;
      if(result['user']['username'] == null) {
        result['user']['username'] = params['username'];
      }
      if(result['user']['id'] == null) {
        result['user']['id'] = params['id'];
      }
      // TODO: generate counts from server side
      var rng = new Random();
      result['followerCount'] = rng.nextInt(100);
      result['followingCount'] = rng.nextInt(100);
      result['likeCount'] = rng.nextInt(100);
      result['relation'] = '';
      return result;
    }

    var parsed = users.map((user) => convert(user)).toList();
    return (parsed != null && parsed.length > 0) ? UserInfoExResponse().fromJson(parsed[0]) : null;
  }

  static void recordEvent(String eventName, Map<String, dynamic> events) {
    AnalyticsEvent event = AnalyticsEvent(eventName);
    events.forEach((key, value) {
      if(value is String) {
        event.properties.addStringProperty(key, value);
      } else if(value is bool) {
        event.properties.addBoolProperty(key, value);
      } else if(value is int) {
        event.properties.addIntProperty(key, value);
      } else if(value is double) {
        event.properties.addDoubleProperty(key, value);
      } else {
        return;
      }
    });

    Amplify.Analytics.recordEvent(event: event);
    // TODO: flush the event for every recording, as current the data is very sparse.
    Amplify.Analytics.flushEvents();
  }

  ///更新用户资料信息
  static Future<UserInfoResponse> updateUserInfo(Map<String,dynamic> map) async{
    var result = await HttpManager.getInstance().put(url: HttpConstant.userInfo+map['id'].toString(), cancelTokenTag: 'getUserInfo',data: map);
    return UserInfoResponse().fromJson(result);
  }

  ///获取上传文件凭证
  static Future<UploadTokenResponse> getSingleUploadToken(List<String> filePathList) async{
    Map<String,List> map = HashMap();
    List resources = [];
    for(int i=0;i<filePathList.length;i++){
      Map<String,String> mapTemp = HashMap();
      mapTemp['type'] = filePathList[i];
      resources.add(mapTemp);
    }
    map['resources'] = resources;
    var result = await HttpManager.getInstance().post(url: HttpConstant.uploadToken, cancelTokenTag: "getUploadToken",data: map);
    return UploadTokenResponse().fromJson(result);
  }

  ///上传文件
  static Future<bool> uploadSingleFile(File file,UploadTokenResponse tokenResponse,String fileSuffix) async{
    Stream<List<int>> listStream = file.openRead();
    UploadTokenTokensHeaders headers = tokenResponse.tokens[0].headers;
    UploadTokenToken tokenToken = tokenResponse.tokens[0];
    bool success = await HttpManager.getInstance().uploadFile(
        url: tokenToken.uploadUrl,
        cancelTokenTag: 'uploadFile',
        data: listStream,
        method: HttpMethod.PUT,
        options: Options(
          headers: {
            'Content-Type':headers.contentType,
            'Date':headers.date,
            'Authorization':headers.authorization
          }
        ),

    );
    return success;
  }

  ///发布feed
  static Future<PublishFeedResponse> publishFeed(PublishFeedRequest publishFeedRequest) async{
    var result = await HttpManager.getInstance().post(url: HttpConstant.publishFeed, cancelTokenTag: 'publishFeed',data: publishFeedRequest.toJson());
    return PublishFeedResponse().fromJson(result);
  }

  ///获取用户作品列表
  static Future<UserWorkListResponse> getUserFeedList(String id, int cursor,int count)async{
    var result = await HttpManager.getInstance().get(url: HttpConstant.userFeedList+'?id=$id&cursor=$cursor&count=$count', cancelTokenTag: 'getUserFeedList');
    return UserWorkListResponse().fromJson(result);
  }

  ///获取热门作品列表
  static Future<FeedListResponse> getHotFeedList(int cursor,int limit, String userId) async{
    try {
      var response;
      var localPosts;
      if(userId == null || userId.isEmpty) {
        localPosts = await SPUtil.getString(SPKeys.POSTS);
        if(localPosts != null) {
          localPosts = jsonDecode(localPosts);
        }
        response = await _query(
          '''query ListPosts(\$limit: Int) {
            listPosts(limit: \$limit) {
              items {
                id attachments music { id } text likeCount
                user { id nickname username portrait }
              }
            }
          }''',
          { 'limit': limit },
          'listPosts'
        );
      } else {
        response = await _query(
          '''query ListPostExs(\$limit: Int, \$userId: ID!) {
            listPostExs(limit: \$limit, userId: \$userId) {
              items {
                id attachments music { id } text likeCount isLiked { value }
                user { id nickname username portrait }
              }
            }
          }''',
          { 'limit': limit, 'userId': userId },
          'listPostExs'
        );
      }

      var rng = new Random(DateTime.now().millisecondsSinceEpoch);
      List posts = response['items']..shuffle(rng);
      posts = posts.where((f) => f['attachments'] != null).toList();
      Future<Map<String, dynamic>> convert(Map<String, dynamic> post) async{
        post['content'] = {
          'attachments': jsonDecode(post['attachments'])['data'],
          'music': post['music'] != null ? post['music'] : null,
          'text': post['text'],
        };
        post['likeCount'] = post['likeCount'] != null ? post['likeCount'] : 0;

        if(post['isLiked'] != null && post['isLiked']['value'] != null) {
          post['isLiked'] = post['isLiked']['value'];
        } else {
          // TODO: remove if the sign in status is required for like
          post['isLiked'] = false;
          if(localPosts != null && localPosts[post['id']] != null && localPosts[post['id']]['isLiked']['value'] != null) {
            post['isLiked'] = localPosts[post['id']]['isLiked']['value'];
          }
        }
        return post;
      }

      var parsed = await Future.wait(posts.map((post) async => await convert(post)));
      return FeedListResponse().fromJson({'list': parsed.toList()});
    } catch (e, stacktrace) {
      print("Fail to get post lists: " + stacktrace.toString());
    }
  }

  static Future<dynamic> _mutation(document, variables, key) async {
    try {
      var operation = Amplify.API.mutate(
          request: GraphQLRequest<String>(document: document, variables: variables)
      );
      var result = await operation.response;
      if(result == null || result.data == null || result.errors.length > 0) {
        debugPrint("Could not query server:" + result.errors.toString() + "\n" + document);
        return null;
      }
      return jsonDecode(result.data)[key];
    } catch (e, stacktrace) {
      print("Could not query server: " + document + '\n' + e.message + '\n' + stacktrace.toString());
    }
  }

  static Future<dynamic> _query(document, variables, key) async {
    try {
      var operation = Amplify.API.query(
          request: GraphQLRequest<String>(
              document: document, variables: variables)
      );
      var result = await operation.response;
      if(result == null || result.data == null || result.errors.length > 0) {
        debugPrint("Could not query server:" + result.errors.toString() + "\n" + document);
        return null;
      }
      return jsonDecode(result.data)[key];
    } catch (e, stacktrace) {
      debugPrint("Could not query server: " + document + '\n' + e.message + '\n' + stacktrace.toString());
    }
  }

  static Future<ViewResponse> viewPost(String postId, String userId) async{
    try {
      var view = await _mutation(
          '''mutation ViewPost(\$input: CreateViewInput!) {
            viewPost(input: \$input) { id }
          }''',
          {
            'input': { 'viewPostId': postId, 'viewUserId': userId },
          },
          'viewPost'
      );
      return ViewResponse().fromJson(view);
    } catch (e, stacktrace) {
      print("Fail to view post: " + stacktrace.toString());
    }
  }

  static Future<LikeResponse> likePost(String postId, String userId, bool value) async{
    try {
      var result;
      if(userId != null) {
        result = await _mutation(
            '''mutation LikePost(\$input: CreateLikeInput!) {
              likePost(input: \$input) { id, value }
            }''',
            {
              'input': {
                'likePostId': postId,
                'likeUserId': userId,
                'value': value
              },
            },
            'likePost'
        );
      } else {
        // TODO: remove if the sign in status is required for like
        var localPosts = await SPUtil.getString(SPKeys.POSTS);
        localPosts = localPosts != null ? jsonDecode(localPosts) : {};
        if(localPosts == null) localPosts = {};
        localPosts[postId] = { "isLiked": {"value": value} };
        SPUtil.set(SPKeys.POSTS, jsonEncode(localPosts));
        result = localPosts[postId]["isLiked"];
      }

      return LikeResponse().fromJson(result);
    } catch (e, stacktrace) {
      print("Could not query server: " + e.toString() + '\n' + stacktrace.toString());
    }
  }

  ///获取好友作品列表
  static Future<FeedListResponse> getFriendFeedList(int cursor,int count) async{
    var result = await HttpManager.getInstance().get(url: HttpConstant.friendFeedList+'?cursor=$cursor&count=$count', cancelTokenTag: 'getFriendFeedList',);
    return FeedListResponse().fromJson(result);
  }

  static Future<FollowResponse> follow(FollowRequest request) async{
    var result = await HttpManager.getInstance().post(url: HttpConstant.follow, cancelTokenTag: 'follow',data: request.toJson());
    return FollowResponse().fromJson(result);
  }

  /// ----------------------------------本地数据--------------------------------------------------------

  // //获取推荐页面的视频列表
  // static List<VideoModel> getRecommendVideoList(){
  //   List<VideoModel> list = [];
  //   for(int i = 0;i < 6;i ++){
  //     VideoModel videoModel = VideoModel();
  //     videoModel.title = videoTitleList[i];
  //     videoModel.author = authorList[i];
  //     videoModel.authorHeaderUrl = authorHeaderUrlList[i];
  //     videoModel.videoUrl = videoUrlList[i];
  //     videoModel.favorite = false;
  //     videoModel.like = false;
  //     videoModel.likeNumber = '266${i}w';
  //     videoModel.commentList = commentList;
  //     videoModel.shareNumber = '18${i}w';
  //     videoModel.videoMusicImage = videoMusicImageList[i];
  //     videoModel.videoMusicName = videoMusicNameList[i];
  //     list.add(videoModel);
  //   }
  //   return list;
  // }
  //
  // //获取朋友页面的视频列表
  // static List<VideoModel> getFriendVideoList(){
  //   List<VideoModel> list = [];
  //   for(int i = 0;i < 6;i ++){
  //     VideoModel videoModel = VideoModel();
  //     videoModel.title = videoTitleList[i];
  //     videoModel.author = authorList[i];
  //     videoModel.authorHeaderUrl = authorHeaderUrlList[i];
  //     videoModel.videoUrl = videoUrlList[i];
  //     videoModel.favorite = false;
  //     videoModel.like = false;
  //     videoModel.likeNumber = '266${i}w';
  //     videoModel.commentList = commentList;
  //     videoModel.shareNumber = '18${i}w';
  //     videoModel.videoMusicImage = videoMusicImageList[i];
  //     videoModel.videoMusicName = videoMusicNameList[i];
  //     list.add(videoModel);
  //   }
  //   return list;
  // }
  //
  // //获取关注页面的视频列表
  // static List<VideoModel> getFocusVideoList(){
  //   List<VideoModel> list = [];
  //   for(int i = 0;i < 6;i ++){
  //     VideoModel videoModel = VideoModel();
  //     videoModel.title = videoTitleList[i];
  //     videoModel.author = authorList[i];
  //     videoModel.authorHeaderUrl = authorHeaderUrlList[i];
  //     videoModel.videoUrl = videoUrlList[i];
  //     videoModel.favorite = false;
  //     videoModel.like = false;
  //     videoModel.likeNumber = '266${i}w';
  //     videoModel.commentList = commentList;
  //     videoModel.shareNumber = '18${i}w';
  //     videoModel.videoMusicImage = videoMusicImageList[i];
  //     videoModel.videoMusicName = videoMusicNameList[i];
  //     list.add(videoModel);
  //   }
  //   return list;
  // }
  //
  // //获取城市页面的视频列表
  // static List<CityItemModel> getCityVideoList(){
  //   List<CityItemModel> list = [];
  //   for(int i = 0;i < 6;i ++){
  //     CityItemModel cityItemModel = CityItemModel();
  //     cityItemModel.user = userModelList[i];
  //     cityItemModel.imgCoverUrl = gifList[i];
  //     cityItemModel.distance = '0.8${i}km';
  //     list.add(cityItemModel);
  //   }
  //   return list;
  // }



}





List<UserModel> userModelList = List.generate(6, (i) {
  UserModel userModel = UserModel();
  userModel.name = authorList[i];
  userModel.headerBgImage = headerBgImageList[i];
  userModel.headerImg = authorHeaderUrlList[i];
  userModel.douYinNumber = '19234$i';
  userModel.introduction = introductionList[i];
  userModel.male = i%2 == 0?true:false;
  userModel.city = '杭州';
  userModel.likeTotalNumber = '156${i}w';
  userModel.focusNumber = '45${i}w';
  userModel.fansNumber = '88${i}w';

  List<VideoModel> list = [];
  list.addAll(videoModelList);
  list.addAll(videoModelList);
  list.addAll(videoModelList);
  list.addAll(videoModelList);

  userModel.worksVideo = list;
  userModel.likeVideo = list;

  List<String> gifListTemp = [];
  gifListTemp.addAll(gifList);
  gifListTemp.addAll(gifList);
  gifListTemp.addAll(gifList);
  gifListTemp.addAll(gifList);
  gifListTemp.addAll(gifList);

  userModel.worksVideoGif = gifListTemp;
  userModel.likeVideoGif = gifListTemp;

  return userModel;
});

UserModel loginUserModel = UserModel(
  name: '钉某人',
  loginUser: true,
  headerBgImage: 'assets/images/bg_1.jpg',
  headerImg: 'assets/images/header_holder.jpg',
  douYinNumber: '19423900',
  introduction: 'Flutter小战士\nGithub:https://github.com/DingMouRen\n简书:https://www.jianshu.com/u/4abd568623a2\nB站:搜索[码农钉某人]',
  male: true,
  city: '杭州',
  likeTotalNumber: '66w',
  focusNumber: '66w',
  fansNumber: '888',
  worksVideo: videoModelList,
  likeVideo: videoModelList,
  likeVideoGif: gifList,
  worksVideoGif: gifList

);

List<VideoModel> videoModelList = List.generate(6, (i) {
  VideoModel videoModel = VideoModel();
  videoModel.title = videoTitleList[i];
  videoModel.author = authorList[i];
  videoModel.authorHeaderUrl = authorHeaderUrlList[i];
  videoModel.videoUrl = videoUrlList[i];
  videoModel.favorite = false;
  videoModel.like = false;
  videoModel.likeNumber = '266${i}w';
  videoModel.commentList = commentList;
  videoModel.shareNumber = '18${i}w';
  videoModel.videoMusicImage = videoMusicImageList[i];
  videoModel.videoMusicName = videoMusicNameList[i];
  return videoModel;
});


//评论的本地假数据
List<CommentModel> commentList = [
  CommentModel('Alis',  'assets/images/header_0.jpg','千秋无绝色！悦目是佳人！倾国倾城貌！惊为天下人！', false, 234, '2分钟前'),
  CommentModel('一条小团团',  'assets/images/header_1.jpg','芙蓉不及美人妆，水殿风来珠翠香', false, 688, '9分钟前'),
  CommentModel('伊素婉',  'assets/images/header_2.jpg', '届笑春桃兮，云堆翠髻；唇绽樱颗兮，榴齿含香',false, 7567, '6分钟前'),
  CommentModel('超级马里奥',  'assets/images/header_3.jpg','朱粉不深匀,闲花淡淡香。细看诸处好,人人道,柳腰身', false, 3543, '23分钟前'),
  CommentModel('肖了个邦',  'assets/images/header_4.jpg', '头上金爵钗，腰佩翠琅玕。明珠交玉体，珊瑚间木难。罗衣何飘飘，轻裾随风远。顾盼遗光彩，长啸气若兰',false, 234, '4小时前'),
  CommentModel('惠子',  'assets/images/header_5.jpg', '皎皎兮似轻云之蔽月，飘飘兮若回风之流雪',false, 888, '4分钟前'),
  CommentModel('爱丽丝',  'assets/images/header_0.jpg','千秋无绝色！悦目是佳人！倾国倾城貌！惊为天下人！', false, 234, '2分钟前'),
  CommentModel('一条小团团',  'assets/images/header_1.jpg','芙蓉不及美人妆，水殿风来珠翠香', false, 688, '9分钟前'),
  CommentModel('伊素婉',  'assets/images/header_2.jpg', '届笑春桃兮，云堆翠髻；唇绽樱颗兮，榴齿含香',false, 7567, '6分钟前'),
  CommentModel('超级马里奥',  'assets/images/header_3.jpg','朱粉不深匀,闲花淡淡香。细看诸处好,人人道,柳腰身', false, 3543, '23分钟前'),
  CommentModel('肖了个邦',  'assets/images/header_4.jpg', '头上金爵钗，腰佩翠琅玕。明珠交玉体，珊瑚间木难。罗衣何飘飘，轻裾随风远。顾盼遗光彩，长啸气若兰',false, 234, '4小时前'),
  CommentModel('惠子',  'assets/images/header_5.jpg', '皎皎兮似轻云之蔽月，飘飘兮若回风之流雪',false, 888, '4分钟前'),
  CommentModel('爱丽丝',  'assets/images/header_0.jpg','千秋无绝色！悦目是佳人！倾国倾城貌！惊为天下人！', false, 234, '2分钟前'),
  CommentModel('一条小团团',  'assets/images/header_1.jpg','芙蓉不及美人妆，水殿风来珠翠香', false, 688, '9分钟前'),
  CommentModel('伊素婉',  'assets/images/header_2.jpg', '届笑春桃兮，云堆翠髻；唇绽樱颗兮，榴齿含香',false, 7567, '6分钟前'),
  CommentModel('超级马里奥',  'assets/images/header_3.jpg','朱粉不深匀,闲花淡淡香。细看诸处好,人人道,柳腰身', false, 3543, '23分钟前'),
  CommentModel('肖了个邦',  'assets/images/header_4.jpg', '头上金爵钗，腰佩翠琅玕。明珠交玉体，珊瑚间木难。罗衣何飘飘，轻裾随风远。顾盼遗光彩，长啸气若兰',false, 234, '4小时前'),
  CommentModel('惠子',  'assets/images/header_5.jpg', '皎皎兮似轻云之蔽月，飘飘兮若回风之流雪',false, 888, '4分钟前'),
];



//视频本地标题
List<String> videoTitleList = [
  '信手拈来的从容，都是厚积薄发的沉淀。',
  '只有坚持别人无法坚持的坚持，才能拥有别人无法拥有的拥有。',
  '我于颓废中睁眼，亦从灰烬中重燃。',
  '光荣与梦想千篇一律，自律与忍耐万里挑一。',
  '你要知道，别人的辉煌在现在，而你的辉煌在未来。',
  '当你觉得坚持不下去的时候，恰恰是你需要坚持下去的时候。',
];

//视频作者
List<String> authorList = [
  'Alis',
  'Tom',
  'GreenBeast',
  'Mario',
  'Chopin',
  'Jerry',
];
//作者头像
List<String> authorHeaderUrlList = [
  'assets/images/header_0.jpg',
  'assets/images/header_1.jpg',
  'assets/images/header_2.jpg',
  'assets/images/header_3.jpg',
  'assets/images/header_4.jpg',
  'assets/images/header_5.jpg',
];

//视频本地地址
List<String> videoUrlList = [
  'assets/video/video_0.mp4',
  'assets/video/video_1.mp4',
  'assets/video/video_2.mp4',
  'assets/video/video_3.mp4',
  'assets/video/video_4.mp4',
  'assets/video/video_5.mp4',
];

//本地视频对应得gif
List<String> gifList = [
  'assets/images/video_0.gif',
  'assets/images/video_1.gif',
  'assets/images/video_2.gif',
  'assets/images/video_3.gif',
  'assets/images/video_4.gif',
  'assets/images/video_5.gif',
];

//视频音乐的名称
List<String> videoMusicNameList = [
  '《隐形的翅膀》- 张韶涵',
  '《挥着翅膀的女孩》 - 容祖儿',
  '《永不退缩》 - 任贤齐',
  '《最初的梦想》 - Remix',
  '《改变自己》 - 王力宏',
  '《奔跑》 - 羽泉',
];

//视频音乐的头像
List<String> videoMusicImageList = [
  'assets/images/header_0.jpg',
  'assets/images/header_1.jpg',
  'assets/images/header_2.jpg',
  'assets/images/header_3.jpg',
  'assets/images/header_4.jpg',
  'assets/images/header_5.jpg',
];

//个人页头部背景
List<String> headerBgImageList = [
  'assets/images/bg_0.jpg',
  'assets/images/bg_1.jpg',
  'assets/images/bg_2.jpg',
  'assets/images/bg_3.jpg',
  'assets/images/bg_4.jpg',
  'assets/images/bg_5.jpg',
];

//个人页简介
List<String> introductionList = [
  '能让人感觉到快乐的不是只有爱情\n还有努力之后的成就感',
  '要悄悄地努力\n会有人在尽头处等你',
  '工作很累\n生活很闷\n但是走过这些艰苦的日子\n迎接你的就是锦绣前程',
  'Calm your mind\n secretly become very strong',
  '心里装着希望\n全力以赴\n才能不负自己',
  '现在付出更多的努力\n未来才会有更多的选择',
];

//消息列表
List<MessageModel> messageList = List.generate(20, (index) {
  MessageModel model = MessageModel();
  model.imgUrl = videoMusicImageList[index%6];
  model.title = authorList[index%6];
  model.desc = index%2 == 0?'started following you · 2h':'Just viewed the video you shared · 2w';
  return model;
});
//明星列表
List<StarModel> starList = [
  StarModel('赵丽颖', 'assets/images/star_0.jpeg', '888.3w 影响力'),
  StarModel('杨幂', 'assets/images/star_1.jpeg', '756.3w 影响力'),
  StarModel('高圆圆', 'assets/images/star_2.jpeg', '743.3w 影响力'),
  StarModel('李沁', 'assets/images/star_3.jpeg', '739.3w 影响力'),
  StarModel('迪丽热巴', 'assets/images/star_4.jpeg', '722.3w 影响力'),
  StarModel('彭于晏', 'assets/images/star_5.jpeg', '700.3w 影响力'),
];

//直播榜列表
List<LivingRankModel> livingList = [
  LivingRankModel('赵丽颖', 'assets/images/star_0.jpeg', '888.3w 人气'),
  LivingRankModel('杨幂', 'assets/images/star_1.jpeg', '756.3w 人气'),
  LivingRankModel('高圆圆', 'assets/images/star_2.jpeg', '743.3w 人气'),
  LivingRankModel('李沁', 'assets/images/star_3.jpeg', '739.3w 人气'),
  LivingRankModel('迪丽热巴', 'assets/images/star_4.jpeg', '722.3w 人气'),
  LivingRankModel('彭于晏', 'assets/images/star_5.jpeg', '700.3w 人气'),
];
//音乐榜列表
List<MusicRankModel> musicList = [
  MusicRankModel('千年之恋', 'assets/images/search_music_0.jpg', '1624.7 w'),
  MusicRankModel('Lydia', 'assets/images/search_music_1.jpg', '1624.7 w'),
  MusicRankModel('我们的爱', 'assets/images/search_music_2.jpg', '1624.7 w'),
  MusicRankModel('月牙湾', 'assets/images/search_music_3.jpg', '1624.7 w'),
  MusicRankModel('亚特兰提斯', 'assets/images/search_music_4.jpg', '1624.7 w'),
  MusicRankModel('雨樱花', 'assets/images/search_music_5.jpg', '1624.7 w'),
];
//品牌榜
List<BrandRankModel> brandList = [
  BrandRankModel('华为', 'assets/images/brand_0.jpg', '1645'),
  BrandRankModel('小米', 'assets/images/brand_1.jpg', '1625'),
  BrandRankModel('vivo', 'assets/images/brand_2.jpg', '1612'),
  BrandRankModel('海尔', 'assets/images/brand_3.jpg', '1569'),
  BrandRankModel('萤石', 'assets/images/brand_4.jpg', '1459'),
  BrandRankModel('阿里', 'assets/images/brand_5.jpg', '1023'),
];

//直播页评论
List<LivingCommendModel> livingCommendList = [
  LivingCommendModel('小冰人','cool'),
  LivingCommendModel('张靓颖','好帅呀,cool'),
  LivingCommendModel('Jack','主播牛逼呀，厉害呢'),
  LivingCommendModel('一朵花花','主播牛逼呀，厉害呢'),
  LivingCommendModel('小红','好帅呀，俺要嫁给你，么么哒~~~'),
  LivingCommendModel('小黄人','好帅呀，左手一只鸭，右手一只鸡，啊啊'),
];