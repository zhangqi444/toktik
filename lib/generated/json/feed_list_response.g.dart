import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/response/feed_list_response.dart';

FeedListResponse $FeedListResponseFromJson(Map<String, dynamic> json) {
	final FeedListResponse feedListResponse = FeedListResponse();
	final List<FeedListList?>? xList = jsonConvert.convertList<FeedListList>(json['list']);
	if (xList != null) {
		feedListResponse.xList = xList;
	}
	final String? nextToken = jsonConvert.convert<String>(json['nextToken']);
	if (nextToken != null) {
		feedListResponse.nextToken = nextToken;
	}
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		feedListResponse.count = count;
	}
	final bool? hasMore = jsonConvert.convert<bool>(json['hasMore']);
	if (hasMore != null) {
		feedListResponse.hasMore = hasMore;
	}
	return feedListResponse;
}

Map<String, dynamic> $FeedListResponseToJson(FeedListResponse entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['list'] =  entity.xList?.map((v) => v?.toJson()).toList();
	data['nextToken'] = entity.nextToken;
	data['count'] = entity.count;
	data['hasMore'] = entity.hasMore;
	return data;
}

FeedListList $FeedListListFromJson(Map<String, dynamic> json) {
	final FeedListList feedListList = FeedListList();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		feedListList.id = id;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		feedListList.type = type;
	}
	final FeedListListContent? content = jsonConvert.convert<FeedListListContent>(json['content']);
	if (content != null) {
		feedListList.content = content;
	}
	final FeedListListLocation? location = jsonConvert.convert<FeedListListLocation>(json['location']);
	if (location != null) {
		feedListList.location = location;
	}
	final String? device = jsonConvert.convert<String>(json['device']);
	if (device != null) {
		feedListList.device = device;
	}
	final int? aclType = jsonConvert.convert<int>(json['aclType']);
	if (aclType != null) {
		feedListList.aclType = aclType;
	}
	final int? commentType = jsonConvert.convert<int>(json['commentType']);
	if (commentType != null) {
		feedListList.commentType = commentType;
	}
	final int? createTime = jsonConvert.convert<int>(json['createTime']);
	if (createTime != null) {
		feedListList.createTime = createTime;
	}
	final FeedListListUser? user = jsonConvert.convert<FeedListListUser>(json['user']);
	if (user != null) {
		feedListList.user = user;
	}
	final int? likeCount = jsonConvert.convert<int>(json['likeCount']);
	if (likeCount != null) {
		feedListList.likeCount = likeCount;
	}
	final int? commentCount = jsonConvert.convert<int>(json['commentCount']);
	if (commentCount != null) {
		feedListList.commentCount = commentCount;
	}
	final int? shareCount = jsonConvert.convert<int>(json['shareCount']);
	if (shareCount != null) {
		feedListList.shareCount = shareCount;
	}
	final int? viewCount = jsonConvert.convert<int>(json['viewCount']);
	if (viewCount != null) {
		feedListList.viewCount = viewCount;
	}
	final bool? isFollow = jsonConvert.convert<bool>(json['isFollow']);
	if (isFollow != null) {
		feedListList.isFollow = isFollow;
	}
	final bool? isLiked = jsonConvert.convert<bool>(json['isLiked']);
	if (isLiked != null) {
		feedListList.isLiked = isLiked;
	}
	return feedListList;
}

Map<String, dynamic> $FeedListListToJson(FeedListList entity) {
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

FeedListListContent $FeedListListContentFromJson(Map<String, dynamic> json) {
	final FeedListListContent feedListListContent = FeedListListContent();
	final String? text = jsonConvert.convert<String>(json['text']);
	if (text != null) {
		feedListListContent.text = text;
	}
	final List<FeedListListContentTag?>? tag = jsonConvert.convertList<FeedListListContentTag>(json['tag']);
	if (tag != null) {
		feedListListContent.tag = tag;
	}
	final List<FeedListListContentAt?>? at = jsonConvert.convertList<FeedListListContentAt>(json['at']);
	if (at != null) {
		feedListListContent.at = at;
	}
	final List<FeedListListContentAttachmants?>? attachments = jsonConvert.convertList<FeedListListContentAttachmants>(json['attachments']);
	if (attachments != null) {
		feedListListContent.attachments = attachments;
	}
	final FeedListListContentMusic? music = jsonConvert.convert<FeedListListContentMusic>(json['music']);
	if (music != null) {
		feedListListContent.music = music;
	}
	return feedListListContent;
}

Map<String, dynamic> $FeedListListContentToJson(FeedListListContent entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['text'] = entity.text;
	data['tag'] =  entity.tag?.map((v) => v?.toJson()).toList();
	data['at'] =  entity.at?.map((v) => v?.toJson()).toList();
	data['attachments'] =  entity.attachments?.map((v) => v?.toJson()).toList();
	data['music'] = entity.music?.toJson();
	return data;
}

FeedListListContentTag $FeedListListContentTagFromJson(Map<String, dynamic> json) {
	final FeedListListContentTag feedListListContentTag = FeedListListContentTag();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		feedListListContentTag.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		feedListListContentTag.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		feedListListContentTag.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		feedListListContentTag.end = end;
	}
	return feedListListContentTag;
}

Map<String, dynamic> $FeedListListContentTagToJson(FeedListListContentTag entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

FeedListListContentAt $FeedListListContentAtFromJson(Map<String, dynamic> json) {
	final FeedListListContentAt feedListListContentAt = FeedListListContentAt();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		feedListListContentAt.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		feedListListContentAt.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		feedListListContentAt.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		feedListListContentAt.end = end;
	}
	return feedListListContentAt;
}

Map<String, dynamic> $FeedListListContentAtToJson(FeedListListContentAt entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

FeedListListContentAttachmants $FeedListListContentAttachmantsFromJson(Map<String, dynamic> json) {
	final FeedListListContentAttachmants feedListListContentAttachmants = FeedListListContentAttachmants();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		feedListListContentAttachmants.type = type;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		feedListListContentAttachmants.url = url;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		feedListListContentAttachmants.cover = cover;
	}
	final String? gifCover = jsonConvert.convert<String>(json['gifCover']);
	if (gifCover != null) {
		feedListListContentAttachmants.gifCover = gifCover;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		feedListListContentAttachmants.duration = duration;
	}
	final int? width = jsonConvert.convert<int>(json['width']);
	if (width != null) {
		feedListListContentAttachmants.width = width;
	}
	final int? height = jsonConvert.convert<int>(json['height']);
	if (height != null) {
		feedListListContentAttachmants.height = height;
	}
	return feedListListContentAttachmants;
}

Map<String, dynamic> $FeedListListContentAttachmantsToJson(FeedListListContentAttachmants entity) {
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

FeedListListContentMusic $FeedListListContentMusicFromJson(Map<String, dynamic> json) {
	final FeedListListContentMusic feedListListContentMusic = FeedListListContentMusic();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		feedListListContentMusic.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		feedListListContentMusic.name = name;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		feedListListContentMusic.url = url;
	}
	final String? img = jsonConvert.convert<String>(json['img']);
	if (img != null) {
		feedListListContentMusic.img = img;
	}
	return feedListListContentMusic;
}

Map<String, dynamic> $FeedListListContentMusicToJson(FeedListListContentMusic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['url'] = entity.url;
	data['img'] = entity.img;
	return data;
}

FeedListListLocation $FeedListListLocationFromJson(Map<String, dynamic> json) {
	final FeedListListLocation feedListListLocation = FeedListListLocation();
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		feedListListLocation.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		feedListListLocation.longitude = longitude;
	}
	final String? cityCode = jsonConvert.convert<String>(json['cityCode']);
	if (cityCode != null) {
		feedListListLocation.cityCode = cityCode;
	}
	final String? adCode = jsonConvert.convert<String>(json['adCode']);
	if (adCode != null) {
		feedListListLocation.adCode = adCode;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		feedListListLocation.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		feedListListLocation.name = name;
	}
	return feedListListLocation;
}

Map<String, dynamic> $FeedListListLocationToJson(FeedListListLocation entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['cityCode'] = entity.cityCode;
	data['adCode'] = entity.adCode;
	data['address'] = entity.address;
	data['name'] = entity.name;
	return data;
}

FeedListListUser $FeedListListUserFromJson(Map<String, dynamic> json) {
	final FeedListListUser feedListListUser = FeedListListUser();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		feedListListUser.id = id;
	}
	final String? username = jsonConvert.convert<String>(json['username']);
	if (username != null) {
		feedListListUser.username = username;
	}
	final String? portrait = jsonConvert.convert<String>(json['portrait']);
	if (portrait != null) {
		feedListListUser.portrait = portrait;
	}
	final String? bio = jsonConvert.convert<String>(json['bio']);
	if (bio != null) {
		feedListListUser.bio = bio;
	}
	final String? birth = jsonConvert.convert<String>(json['birth']);
	if (birth != null) {
		feedListListUser.birth = birth;
	}
	final int? gender = jsonConvert.convert<int>(json['gender']);
	if (gender != null) {
		feedListListUser.gender = gender;
	}
	final String? city = jsonConvert.convert<String>(json['city']);
	if (city != null) {
		feedListListUser.city = city;
	}
	final String? profession = jsonConvert.convert<String>(json['profession']);
	if (profession != null) {
		feedListListUser.profession = profession;
	}
	final int? createTime = jsonConvert.convert<int>(json['create_time']);
	if (createTime != null) {
		feedListListUser.createTime = createTime;
	}
	return feedListListUser;
}

Map<String, dynamic> $FeedListListUserToJson(FeedListListUser entity) {
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