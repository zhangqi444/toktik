import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/user_work_list_response.dart';

UserWorkListResponse $UserWorkListResponseFromJson(Map<String, dynamic> json) {
	final UserWorkListResponse userWorkListResponse = UserWorkListResponse();
	final List<UserWorkListList?>? xList = jsonConvert.convertList<UserWorkListList>(json['list']);
	if (xList != null) {
		userWorkListResponse.xList = xList;
	}
	final int? cursor = jsonConvert.convert<int>(json['cursor']);
	if (cursor != null) {
		userWorkListResponse.cursor = cursor;
	}
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		userWorkListResponse.count = count;
	}
	final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
	if (hasMore != null) {
		userWorkListResponse.hasMore = hasMore;
	}
	return userWorkListResponse;
}

Map<String, dynamic> $UserWorkListResponseToJson(UserWorkListResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.xList?.map((v) => v?.toJson()).toList();
	data['cursor'] = entity.cursor;
	data['count'] = entity.count;
	data['hasMore'] = entity.hasMore;
	return data;
}

UserWorkListList $UserWorkListListFromJson(Map<String, dynamic> json) {
	final UserWorkListList userWorkListList = UserWorkListList();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userWorkListList.id = id;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		userWorkListList.type = type;
	}
	final UserWorkListListContent? content = jsonConvert.convert<UserWorkListListContent>(json['content']);
	if (content != null) {
		userWorkListList.content = content;
	}
	final UserWorkListListLocation? location = jsonConvert.convert<UserWorkListListLocation>(json['location']);
	if (location != null) {
		userWorkListList.location = location;
	}
	final String? device = jsonConvert.convert<String>(json['device']);
	if (device != null) {
		userWorkListList.device = device;
	}
	final int? aclType = jsonConvert.convert<int>(json['aclType']);
	if (aclType != null) {
		userWorkListList.aclType = aclType;
	}
	final int? commentType = jsonConvert.convert<int>(json['commentType']);
	if (commentType != null) {
		userWorkListList.commentType = commentType;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		userWorkListList.createTime = createTime;
	}
	final UserWorkListListUser? user = jsonConvert.convert<UserWorkListListUser>(json['user']);
	if (user != null) {
		userWorkListList.user = user;
	}
	final int? likeCount = jsonConvert.convert<int>(json['likeCount']);
	if (likeCount != null) {
		userWorkListList.likeCount = likeCount;
	}
	final int? commentCount = jsonConvert.convert<int>(json['commentCount']);
	if (commentCount != null) {
		userWorkListList.commentCount = commentCount;
	}
	final int? shareCount = jsonConvert.convert<int>(json['shareCount']);
	if (shareCount != null) {
		userWorkListList.shareCount = shareCount;
	}
	final int? viewCount = jsonConvert.convert<int>(json['viewCount']);
	if (viewCount != null) {
		userWorkListList.viewCount = viewCount;
	}
	final bool? isFollow = jsonConvert.convert<bool>(json['isFollow']);
	if (isFollow != null) {
		userWorkListList.isFollow = isFollow;
	}
	final bool? isLiked = jsonConvert.convert<bool>(json['isLiked']);
	if (isLiked != null) {
		userWorkListList.isLiked = isLiked;
	}
	return userWorkListList;
}

Map<String, dynamic> $UserWorkListListToJson(UserWorkListList entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['type'] = entity.type;
	data['content'] = entity.content?.toJson();
	data['location'] = entity.location?.toJson();
	data['device'] = entity.device;
	data['aclType'] = entity.aclType;
	data['commentType'] = entity.commentType;
	data['createTime'] = entity.createTime;
	data['user'] = entity.user?.toJson();
	data['likeCount'] = entity.likeCount;
	data['commentCount'] = entity.commentCount;
	data['shareCount'] = entity.shareCount;
	data['viewCount'] = entity.viewCount;
	data['isFollow'] = entity.isFollow;
	data['isLiked'] = entity.isLiked;
	return data;
}

UserWorkListListContent $UserWorkListListContentFromJson(Map<String, dynamic> json) {
	final UserWorkListListContent userWorkListListContent = UserWorkListListContent();
	final String? text = jsonConvert.convert<String>(json['text']);
	if (text != null) {
		userWorkListListContent.text = text;
	}
	final List<UserWorkListListContentTag?>? tag = jsonConvert.convertList<UserWorkListListContentTag>(json['tag']);
	if (tag != null) {
		userWorkListListContent.tag = tag;
	}
	final List<UserWorkListListContentAt?>? at = jsonConvert.convertList<UserWorkListListContentAt>(json['at']);
	if (at != null) {
		userWorkListListContent.at = at;
	}
	final List<UserWorkListListContentAttachmants?>? attachments = jsonConvert.convertList<UserWorkListListContentAttachmants>(json['attachments']);
	if (attachments != null) {
		userWorkListListContent.attachments = attachments;
	}
	final UserWorkListListContentMusic? music = jsonConvert.convert<UserWorkListListContentMusic>(json['music']);
	if (music != null) {
		userWorkListListContent.music = music;
	}
	return userWorkListListContent;
}

Map<String, dynamic> $UserWorkListListContentToJson(UserWorkListListContent entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['text'] = entity.text;
	data['tag'] =  entity.tag?.map((v) => v?.toJson()).toList();
	data['at'] =  entity.at?.map((v) => v?.toJson()).toList();
	data['attachments'] =  entity.attachments?.map((v) => v?.toJson()).toList();
	data['music'] = entity.music?.toJson();
	return data;
}

UserWorkListListContentTag $UserWorkListListContentTagFromJson(Map<String, dynamic> json) {
	final UserWorkListListContentTag userWorkListListContentTag = UserWorkListListContentTag();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userWorkListListContentTag.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userWorkListListContentTag.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		userWorkListListContentTag.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		userWorkListListContentTag.end = end;
	}
	return userWorkListListContentTag;
}

Map<String, dynamic> $UserWorkListListContentTagToJson(UserWorkListListContentTag entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

UserWorkListListContentAt $UserWorkListListContentAtFromJson(Map<String, dynamic> json) {
	final UserWorkListListContentAt userWorkListListContentAt = UserWorkListListContentAt();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userWorkListListContentAt.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userWorkListListContentAt.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		userWorkListListContentAt.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		userWorkListListContentAt.end = end;
	}
	return userWorkListListContentAt;
}

Map<String, dynamic> $UserWorkListListContentAtToJson(UserWorkListListContentAt entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

UserWorkListListContentAttachmants $UserWorkListListContentAttachmantsFromJson(Map<String, dynamic> json) {
	final UserWorkListListContentAttachmants userWorkListListContentAttachmants = UserWorkListListContentAttachmants();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		userWorkListListContentAttachmants.type = type;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		userWorkListListContentAttachmants.url = url;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		userWorkListListContentAttachmants.cover = cover;
	}
	final String? gifCover = jsonConvert.convert<String>(json['gifCover']);
	if (gifCover != null) {
		userWorkListListContentAttachmants.gifCover = gifCover;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		userWorkListListContentAttachmants.duration = duration;
	}
	final int? width = jsonConvert.convert<int>(json['width']);
	if (width != null) {
		userWorkListListContentAttachmants.width = width;
	}
	final int? height = jsonConvert.convert<int>(json['height']);
	if (height != null) {
		userWorkListListContentAttachmants.height = height;
	}
	return userWorkListListContentAttachmants;
}

Map<String, dynamic> $UserWorkListListContentAttachmantsToJson(UserWorkListListContentAttachmants entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['type'] = entity.type;
	data['url'] = entity.url;
	data['cover'] = entity.cover;
	data['gifCover'] = entity.gifCover;
	data['duration'] = entity.duration;
	data['width'] = entity.width;
	data['height'] = entity.height;
	return data;
}

UserWorkListListContentMusic $UserWorkListListContentMusicFromJson(Map<String, dynamic> json) {
	final UserWorkListListContentMusic userWorkListListContentMusic = UserWorkListListContentMusic();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userWorkListListContentMusic.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userWorkListListContentMusic.name = name;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		userWorkListListContentMusic.url = url;
	}
	final String? img = jsonConvert.convert<String>(json['img']);
	if (img != null) {
		userWorkListListContentMusic.img = img;
	}
	return userWorkListListContentMusic;
}

Map<String, dynamic> $UserWorkListListContentMusicToJson(UserWorkListListContentMusic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['url'] = entity.url;
	data['img'] = entity.img;
	return data;
}

UserWorkListListLocation $UserWorkListListLocationFromJson(Map<String, dynamic> json) {
	final UserWorkListListLocation userWorkListListLocation = UserWorkListListLocation();
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		userWorkListListLocation.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		userWorkListListLocation.longitude = longitude;
	}
	final String? cityCode = jsonConvert.convert<String>(json['cityCode']);
	if (cityCode != null) {
		userWorkListListLocation.cityCode = cityCode;
	}
	final String? adCode = jsonConvert.convert<String>(json['adCode']);
	if (adCode != null) {
		userWorkListListLocation.adCode = adCode;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		userWorkListListLocation.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		userWorkListListLocation.name = name;
	}
	return userWorkListListLocation;
}

Map<String, dynamic> $UserWorkListListLocationToJson(UserWorkListListLocation entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['cityCode'] = entity.cityCode;
	data['adCode'] = entity.adCode;
	data['address'] = entity.address;
	data['name'] = entity.name;
	return data;
}

UserWorkListListUser $UserWorkListListUserFromJson(Map<String, dynamic> json) {
	final UserWorkListListUser userWorkListListUser = UserWorkListListUser();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		userWorkListListUser.id = id;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		userWorkListListUser.username = username;
	}
	final String? portrait = jsonConvert.convert<String>(json['portrait']);
	if (portrait != null) {
		userWorkListListUser.portrait = portrait;
	}
	final String? bio = jsonConvert.convert<String>(json['bio']);
	if (bio != null) {
		userWorkListListUser.bio = bio;
	}
	final String? birth = jsonConvert.convert<String>(json['birth']);
	if (birth != null) {
		userWorkListListUser.birth = birth;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		userWorkListListUser.gender = gender;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		userWorkListListUser.city = city;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		userWorkListListUser.profession = profession;
	}
	final int? createTime = jsonConvert.convert<int>(json['create_time']);
	if (createTime != null) {
		userWorkListListUser.createTime = createTime;
	}
	return userWorkListListUser;
}

Map<String, dynamic> $UserWorkListListUserToJson(UserWorkListListUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['username'] = entity.username;
	data['portrait'] = entity.portrait;
	data['bio'] = entity.bio;
	data['birth'] = entity.birth;
	data['gender'] = entity.gender;
	data['city'] = entity.city;
	data['profession'] = entity.profession;
	data['create_time'] = entity.createTime;
	return data;
}