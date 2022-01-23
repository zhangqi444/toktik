// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:toktik/model/request/follow_request.dart';
import 'package:toktik/generated/json/follow_request.g.dart';
import 'package:toktik/model/request/publish_feed_request.dart';
import 'package:toktik/generated/json/publish_feed_request.g.dart';
import 'package:toktik/model/request/report_request.dart';
import 'package:toktik/generated/json/report_request.g.dart';
import 'package:toktik/model/response/feed_list_response.dart';
import 'package:toktik/generated/json/feed_list_response.g.dart';
import 'package:toktik/model/response/follow_response.dart';
import 'package:toktik/generated/json/follow_response.g.dart';
import 'package:toktik/model/response/like_response.dart';
import 'package:toktik/generated/json/like_response.g.dart';
import 'package:toktik/model/response/login_response.dart';
import 'package:toktik/generated/json/login_response.g.dart';
import 'package:toktik/model/response/logout_response.dart';
import 'package:toktik/generated/json/logout_response.g.dart';
import 'package:toktik/model/response/publish_feed_response.dart';
import 'package:toktik/generated/json/publish_feed_response.g.dart';
import 'package:toktik/model/response/register_response.dart';
import 'package:toktik/generated/json/register_response.g.dart';
import 'package:toktik/model/response/report_response.dart';
import 'package:toktik/generated/json/report_response.g.dart';
import 'package:toktik/model/response/upload_response.dart';
import 'package:toktik/generated/json/upload_response.g.dart';
import 'package:toktik/model/response/upload_token_response.dart';
import 'package:toktik/generated/json/upload_token_response.g.dart';
import 'package:toktik/model/response/user_info_ex_response.dart';
import 'package:toktik/generated/json/user_info_ex_response.g.dart';
import 'package:toktik/model/response/user_info_response.dart';
import 'package:toktik/generated/json/user_info_response.g.dart';
import 'package:toktik/model/response/user_work_list_response.dart';
import 'package:toktik/generated/json/user_work_list_response.g.dart';
import 'package:toktik/model/response/view_response.dart';
import 'package:toktik/generated/json/view_response.g.dart';

JsonConvert jsonConvert = JsonConvert();

class JsonConvert {

  T? convert<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    return asT<T>(value);
  }

  List<T?>? convertList<T>(List<dynamic>? value) {
    if (value == null) {
      return null;
    }
    try {
      return value.map((dynamic e) => asT<T>(e)).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }

  List<T>? convertListNotNull<T>(dynamic value) {
    if (value == null) {
      return null;
    }
    try {
      return (value as List<dynamic>).map((dynamic e) => asT<T>(e)!).toList();
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return <T>[];
    }
  }
  T? asT<T extends Object?>(dynamic value) {
    if (value is T) {
      return value;
    }
		final String type = T.toString();
    try {
      final String valueS = value.toString();
      if (type == "String") {
        return valueS as T;
      } else if (type == "int") {
        final int? intValue = int.tryParse(valueS);
        if (intValue == null) {
          return double.tryParse(valueS)?.toInt() as T?;
        } else {
          return intValue as T;
        }      } else if (type == "double") {
        return double.parse(valueS) as T;
      } else if (type ==  "DateTime") {
        return DateTime.parse(valueS) as T;
      } else if (type ==  "bool") {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return JsonConvert.fromJsonAsT<T>(value);
      }
    } catch (e, stackTrace) {
      print('asT<$T> $e $stackTrace');
      return null;
    }
  } 
	//Go back to a single instance by type
	static M? _fromJsonSingle<M>(Map<String, dynamic> json) {
		final String type = M.toString();
		if(type == (FollowRequest).toString()){
			return FollowRequest.fromJson(json) as M;
		}
		if(type == (PublishFeedRequest).toString()){
			return PublishFeedRequest.fromJson(json) as M;
		}
		if(type == (PublishFeedContent).toString()){
			return PublishFeedContent.fromJson(json) as M;
		}
		if(type == (PublishFeedContentTag).toString()){
			return PublishFeedContentTag.fromJson(json) as M;
		}
		if(type == (PublishFeedContentAt).toString()){
			return PublishFeedContentAt.fromJson(json) as M;
		}
		if(type == (PublishFeedContentAttachmants).toString()){
			return PublishFeedContentAttachmants.fromJson(json) as M;
		}
		if(type == (PublishFeedContentMusic).toString()){
			return PublishFeedContentMusic.fromJson(json) as M;
		}
		if(type == (PublishFeedLocation).toString()){
			return PublishFeedLocation.fromJson(json) as M;
		}
		if(type == (ReportRequest).toString()){
			return ReportRequest.fromJson(json) as M;
		}
		if(type == (FeedListResponse).toString()){
			return FeedListResponse.fromJson(json) as M;
		}
		if(type == (FeedListList).toString()){
			return FeedListList.fromJson(json) as M;
		}
		if(type == (FeedListListContent).toString()){
			return FeedListListContent.fromJson(json) as M;
		}
		if(type == (FeedListListContentTag).toString()){
			return FeedListListContentTag.fromJson(json) as M;
		}
		if(type == (FeedListListContentAt).toString()){
			return FeedListListContentAt.fromJson(json) as M;
		}
		if(type == (FeedListListContentAttachmants).toString()){
			return FeedListListContentAttachmants.fromJson(json) as M;
		}
		if(type == (FeedListListContentMusic).toString()){
			return FeedListListContentMusic.fromJson(json) as M;
		}
		if(type == (FeedListListLocation).toString()){
			return FeedListListLocation.fromJson(json) as M;
		}
		if(type == (FeedListListUser).toString()){
			return FeedListListUser.fromJson(json) as M;
		}
		if(type == (FollowResponse).toString()){
			return FollowResponse.fromJson(json) as M;
		}
		if(type == (LikeResponse).toString()){
			return LikeResponse.fromJson(json) as M;
		}
		if(type == (LoginResponse).toString()){
			return LoginResponse.fromJson(json) as M;
		}
		if(type == (LogoutResponse).toString()){
			return LogoutResponse.fromJson(json) as M;
		}
		if(type == (PublishFeedResponse).toString()){
			return PublishFeedResponse.fromJson(json) as M;
		}
		if(type == (RegisterResponse).toString()){
			return RegisterResponse.fromJson(json) as M;
		}
		if(type == (ReportResponse).toString()){
			return ReportResponse.fromJson(json) as M;
		}
		if(type == (UploadResponse).toString()){
			return UploadResponse.fromJson(json) as M;
		}
		if(type == (UploadTokenResponse).toString()){
			return UploadTokenResponse.fromJson(json) as M;
		}
		if(type == (UploadTokenToken).toString()){
			return UploadTokenToken.fromJson(json) as M;
		}
		if(type == (UploadTokenTokensHeaders).toString()){
			return UploadTokenTokensHeaders.fromJson(json) as M;
		}
		if(type == (UserInfoExResponse).toString()){
			return UserInfoExResponse.fromJson(json) as M;
		}
		if(type == (UserInfoExUser).toString()){
			return UserInfoExUser.fromJson(json) as M;
		}
		if(type == (UserInfoResponse).toString()){
			return UserInfoResponse.fromJson(json) as M;
		}
		if(type == (UserWorkListResponse).toString()){
			return UserWorkListResponse.fromJson(json) as M;
		}
		if(type == (UserWorkListList).toString()){
			return UserWorkListList.fromJson(json) as M;
		}
		if(type == (UserWorkListListContent).toString()){
			return UserWorkListListContent.fromJson(json) as M;
		}
		if(type == (UserWorkListListContentTag).toString()){
			return UserWorkListListContentTag.fromJson(json) as M;
		}
		if(type == (UserWorkListListContentAt).toString()){
			return UserWorkListListContentAt.fromJson(json) as M;
		}
		if(type == (UserWorkListListContentAttachmants).toString()){
			return UserWorkListListContentAttachmants.fromJson(json) as M;
		}
		if(type == (UserWorkListListContentMusic).toString()){
			return UserWorkListListContentMusic.fromJson(json) as M;
		}
		if(type == (UserWorkListListLocation).toString()){
			return UserWorkListListLocation.fromJson(json) as M;
		}
		if(type == (UserWorkListListUser).toString()){
			return UserWorkListListUser.fromJson(json) as M;
		}
		if(type == (ViewResponse).toString()){
			return ViewResponse.fromJson(json) as M;
		}

		print("$type not found");
	
		return null;
}

  //list is returned by type
	static M? _getListChildType<M>(List<Map<String, dynamic>> data) {
		if(<FollowRequest>[] is M){
			return data.map<FollowRequest>((Map<String, dynamic> e) => FollowRequest.fromJson(e)).toList() as M;
		}
		if(<PublishFeedRequest>[] is M){
			return data.map<PublishFeedRequest>((Map<String, dynamic> e) => PublishFeedRequest.fromJson(e)).toList() as M;
		}
		if(<PublishFeedContent>[] is M){
			return data.map<PublishFeedContent>((Map<String, dynamic> e) => PublishFeedContent.fromJson(e)).toList() as M;
		}
		if(<PublishFeedContentTag>[] is M){
			return data.map<PublishFeedContentTag>((Map<String, dynamic> e) => PublishFeedContentTag.fromJson(e)).toList() as M;
		}
		if(<PublishFeedContentAt>[] is M){
			return data.map<PublishFeedContentAt>((Map<String, dynamic> e) => PublishFeedContentAt.fromJson(e)).toList() as M;
		}
		if(<PublishFeedContentAttachmants>[] is M){
			return data.map<PublishFeedContentAttachmants>((Map<String, dynamic> e) => PublishFeedContentAttachmants.fromJson(e)).toList() as M;
		}
		if(<PublishFeedContentMusic>[] is M){
			return data.map<PublishFeedContentMusic>((Map<String, dynamic> e) => PublishFeedContentMusic.fromJson(e)).toList() as M;
		}
		if(<PublishFeedLocation>[] is M){
			return data.map<PublishFeedLocation>((Map<String, dynamic> e) => PublishFeedLocation.fromJson(e)).toList() as M;
		}
		if(<ReportRequest>[] is M){
			return data.map<ReportRequest>((Map<String, dynamic> e) => ReportRequest.fromJson(e)).toList() as M;
		}
		if(<FeedListResponse>[] is M){
			return data.map<FeedListResponse>((Map<String, dynamic> e) => FeedListResponse.fromJson(e)).toList() as M;
		}
		if(<FeedListList>[] is M){
			return data.map<FeedListList>((Map<String, dynamic> e) => FeedListList.fromJson(e)).toList() as M;
		}
		if(<FeedListListContent>[] is M){
			return data.map<FeedListListContent>((Map<String, dynamic> e) => FeedListListContent.fromJson(e)).toList() as M;
		}
		if(<FeedListListContentTag>[] is M){
			return data.map<FeedListListContentTag>((Map<String, dynamic> e) => FeedListListContentTag.fromJson(e)).toList() as M;
		}
		if(<FeedListListContentAt>[] is M){
			return data.map<FeedListListContentAt>((Map<String, dynamic> e) => FeedListListContentAt.fromJson(e)).toList() as M;
		}
		if(<FeedListListContentAttachmants>[] is M){
			return data.map<FeedListListContentAttachmants>((Map<String, dynamic> e) => FeedListListContentAttachmants.fromJson(e)).toList() as M;
		}
		if(<FeedListListContentMusic>[] is M){
			return data.map<FeedListListContentMusic>((Map<String, dynamic> e) => FeedListListContentMusic.fromJson(e)).toList() as M;
		}
		if(<FeedListListLocation>[] is M){
			return data.map<FeedListListLocation>((Map<String, dynamic> e) => FeedListListLocation.fromJson(e)).toList() as M;
		}
		if(<FeedListListUser>[] is M){
			return data.map<FeedListListUser>((Map<String, dynamic> e) => FeedListListUser.fromJson(e)).toList() as M;
		}
		if(<FollowResponse>[] is M){
			return data.map<FollowResponse>((Map<String, dynamic> e) => FollowResponse.fromJson(e)).toList() as M;
		}
		if(<LikeResponse>[] is M){
			return data.map<LikeResponse>((Map<String, dynamic> e) => LikeResponse.fromJson(e)).toList() as M;
		}
		if(<LoginResponse>[] is M){
			return data.map<LoginResponse>((Map<String, dynamic> e) => LoginResponse.fromJson(e)).toList() as M;
		}
		if(<LogoutResponse>[] is M){
			return data.map<LogoutResponse>((Map<String, dynamic> e) => LogoutResponse.fromJson(e)).toList() as M;
		}
		if(<PublishFeedResponse>[] is M){
			return data.map<PublishFeedResponse>((Map<String, dynamic> e) => PublishFeedResponse.fromJson(e)).toList() as M;
		}
		if(<RegisterResponse>[] is M){
			return data.map<RegisterResponse>((Map<String, dynamic> e) => RegisterResponse.fromJson(e)).toList() as M;
		}
		if(<ReportResponse>[] is M){
			return data.map<ReportResponse>((Map<String, dynamic> e) => ReportResponse.fromJson(e)).toList() as M;
		}
		if(<UploadResponse>[] is M){
			return data.map<UploadResponse>((Map<String, dynamic> e) => UploadResponse.fromJson(e)).toList() as M;
		}
		if(<UploadTokenResponse>[] is M){
			return data.map<UploadTokenResponse>((Map<String, dynamic> e) => UploadTokenResponse.fromJson(e)).toList() as M;
		}
		if(<UploadTokenToken>[] is M){
			return data.map<UploadTokenToken>((Map<String, dynamic> e) => UploadTokenToken.fromJson(e)).toList() as M;
		}
		if(<UploadTokenTokensHeaders>[] is M){
			return data.map<UploadTokenTokensHeaders>((Map<String, dynamic> e) => UploadTokenTokensHeaders.fromJson(e)).toList() as M;
		}
		if(<UserInfoExResponse>[] is M){
			return data.map<UserInfoExResponse>((Map<String, dynamic> e) => UserInfoExResponse.fromJson(e)).toList() as M;
		}
		if(<UserInfoExUser>[] is M){
			return data.map<UserInfoExUser>((Map<String, dynamic> e) => UserInfoExUser.fromJson(e)).toList() as M;
		}
		if(<UserInfoResponse>[] is M){
			return data.map<UserInfoResponse>((Map<String, dynamic> e) => UserInfoResponse.fromJson(e)).toList() as M;
		}
		if(<UserWorkListResponse>[] is M){
			return data.map<UserWorkListResponse>((Map<String, dynamic> e) => UserWorkListResponse.fromJson(e)).toList() as M;
		}
		if(<UserWorkListList>[] is M){
			return data.map<UserWorkListList>((Map<String, dynamic> e) => UserWorkListList.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListContent>[] is M){
			return data.map<UserWorkListListContent>((Map<String, dynamic> e) => UserWorkListListContent.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListContentTag>[] is M){
			return data.map<UserWorkListListContentTag>((Map<String, dynamic> e) => UserWorkListListContentTag.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListContentAt>[] is M){
			return data.map<UserWorkListListContentAt>((Map<String, dynamic> e) => UserWorkListListContentAt.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListContentAttachmants>[] is M){
			return data.map<UserWorkListListContentAttachmants>((Map<String, dynamic> e) => UserWorkListListContentAttachmants.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListContentMusic>[] is M){
			return data.map<UserWorkListListContentMusic>((Map<String, dynamic> e) => UserWorkListListContentMusic.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListLocation>[] is M){
			return data.map<UserWorkListListLocation>((Map<String, dynamic> e) => UserWorkListListLocation.fromJson(e)).toList() as M;
		}
		if(<UserWorkListListUser>[] is M){
			return data.map<UserWorkListListUser>((Map<String, dynamic> e) => UserWorkListListUser.fromJson(e)).toList() as M;
		}
		if(<ViewResponse>[] is M){
			return data.map<ViewResponse>((Map<String, dynamic> e) => ViewResponse.fromJson(e)).toList() as M;
		}

		print("${M.toString()} not found");
	
		return null;
}

  static M? fromJsonAsT<M>(dynamic json) {
		if(json == null){
			return null;
		}		if (json is List) {
			return _getListChildType<M>(json.map((e) => e as Map<String, dynamic>).toList());
		} else {
			return _fromJsonSingle<M>(json as Map<String, dynamic>);
		}
	}
}