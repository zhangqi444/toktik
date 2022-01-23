import 'package:toktik/generated/json/base/json_convert_content.dart';
import 'package:toktik/model/request/publish_feed_request.dart';

PublishFeedRequest $PublishFeedRequestFromJson(Map<String, dynamic> json) {
	final PublishFeedRequest publishFeedRequest = PublishFeedRequest();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		publishFeedRequest.type = type;
	}
	final PublishFeedContent? content = jsonConvert.convert<PublishFeedContent>(json['content']);
	if (content != null) {
		publishFeedRequest.content = content;
	}
	final PublishFeedLocation? location = jsonConvert.convert<PublishFeedLocation>(json['location']);
	if (location != null) {
		publishFeedRequest.location = location;
	}
	final String? device = jsonConvert.convert<String>(json['device']);
	if (device != null) {
		publishFeedRequest.device = device;
	}
	final int? aclType = jsonConvert.convert<int>(json['aclType']);
	if (aclType != null) {
		publishFeedRequest.aclType = aclType;
	}
	final int? commentType = jsonConvert.convert<int>(json['commentType']);
	if (commentType != null) {
		publishFeedRequest.commentType = commentType;
	}
	return publishFeedRequest;
}

Map<String, dynamic> $PublishFeedRequestToJson(PublishFeedRequest entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['type'] = entity.type;
	data['content'] = entity.content?.toJson();
	data['location'] = entity.location?.toJson();
	data['device'] = entity.device;
	data['aclType'] = entity.aclType;
	data['commentType'] = entity.commentType;
	return data;
}

PublishFeedContent $PublishFeedContentFromJson(Map<String, dynamic> json) {
	final PublishFeedContent publishFeedContent = PublishFeedContent();
	final String? text = jsonConvert.convert<String>(json['text']);
	if (text != null) {
		publishFeedContent.text = text;
	}
	final List<PublishFeedContentTag?>? tag = jsonConvert.convertList<PublishFeedContentTag>(json['tag']);
	if (tag != null) {
		publishFeedContent.tag = tag;
	}
	final List<PublishFeedContentAt?>? at = jsonConvert.convertList<PublishFeedContentAt>(json['at']);
	if (at != null) {
		publishFeedContent.at = at;
	}
	final List<PublishFeedContentAttachmants?>? attachments = jsonConvert.convertList<PublishFeedContentAttachmants>(json['attachments']);
	if (attachments != null) {
		publishFeedContent.attachments = attachments;
	}
	final PublishFeedContentMusic? music = jsonConvert.convert<PublishFeedContentMusic>(json['music']);
	if (music != null) {
		publishFeedContent.music = music;
	}
	return publishFeedContent;
}

Map<String, dynamic> $PublishFeedContentToJson(PublishFeedContent entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['text'] = entity.text;
	data['tag'] =  entity.tag?.map((v) => v?.toJson()).toList();
	data['at'] =  entity.at?.map((v) => v?.toJson()).toList();
	data['attachments'] =  entity.attachments?.map((v) => v?.toJson()).toList();
	data['music'] = entity.music?.toJson();
	return data;
}

PublishFeedContentTag $PublishFeedContentTagFromJson(Map<String, dynamic> json) {
	final PublishFeedContentTag publishFeedContentTag = PublishFeedContentTag();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		publishFeedContentTag.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		publishFeedContentTag.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		publishFeedContentTag.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		publishFeedContentTag.end = end;
	}
	return publishFeedContentTag;
}

Map<String, dynamic> $PublishFeedContentTagToJson(PublishFeedContentTag entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

PublishFeedContentAt $PublishFeedContentAtFromJson(Map<String, dynamic> json) {
	final PublishFeedContentAt publishFeedContentAt = PublishFeedContentAt();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		publishFeedContentAt.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		publishFeedContentAt.name = name;
	}
	final int? start = jsonConvert.convert<int>(json['start']);
	if (start != null) {
		publishFeedContentAt.start = start;
	}
	final int? end = jsonConvert.convert<int>(json['end']);
	if (end != null) {
		publishFeedContentAt.end = end;
	}
	return publishFeedContentAt;
}

Map<String, dynamic> $PublishFeedContentAtToJson(PublishFeedContentAt entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['start'] = entity.start;
	data['end'] = entity.end;
	return data;
}

PublishFeedContentAttachmants $PublishFeedContentAttachmantsFromJson(Map<String, dynamic> json) {
	final PublishFeedContentAttachmants publishFeedContentAttachmants = PublishFeedContentAttachmants();
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		publishFeedContentAttachmants.type = type;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		publishFeedContentAttachmants.url = url;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		publishFeedContentAttachmants.cover = cover;
	}
	final String? gifCover = jsonConvert.convert<String>(json['gifCover']);
	if (gifCover != null) {
		publishFeedContentAttachmants.gifCover = gifCover;
	}
	final int? duration = jsonConvert.convert<int>(json['duration']);
	if (duration != null) {
		publishFeedContentAttachmants.duration = duration;
	}
	final int? width = jsonConvert.convert<int>(json['width']);
	if (width != null) {
		publishFeedContentAttachmants.width = width;
	}
	final int? height = jsonConvert.convert<int>(json['height']);
	if (height != null) {
		publishFeedContentAttachmants.height = height;
	}
	return publishFeedContentAttachmants;
}

Map<String, dynamic> $PublishFeedContentAttachmantsToJson(PublishFeedContentAttachmants entity) {
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

PublishFeedContentMusic $PublishFeedContentMusicFromJson(Map<String, dynamic> json) {
	final PublishFeedContentMusic publishFeedContentMusic = PublishFeedContentMusic();
	final String? id = jsonConvert.convert<String>(json['id']);
	if (id != null) {
		publishFeedContentMusic.id = id;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		publishFeedContentMusic.name = name;
	}
	final String? url = jsonConvert.convert<String>(json['url']);
	if (url != null) {
		publishFeedContentMusic.url = url;
	}
	final String? img = jsonConvert.convert<String>(json['img']);
	if (img != null) {
		publishFeedContentMusic.img = img;
	}
	return publishFeedContentMusic;
}

Map<String, dynamic> $PublishFeedContentMusicToJson(PublishFeedContentMusic entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['id'] = entity.id;
	data['name'] = entity.name;
	data['url'] = entity.url;
	data['img'] = entity.img;
	return data;
}

PublishFeedLocation $PublishFeedLocationFromJson(Map<String, dynamic> json) {
	final PublishFeedLocation publishFeedLocation = PublishFeedLocation();
	final String? latitude = jsonConvert.convert<String>(json['latitude']);
	if (latitude != null) {
		publishFeedLocation.latitude = latitude;
	}
	final String? longitude = jsonConvert.convert<String>(json['longitude']);
	if (longitude != null) {
		publishFeedLocation.longitude = longitude;
	}
	final String? cityCode = jsonConvert.convert<String>(json['cityCode']);
	if (cityCode != null) {
		publishFeedLocation.cityCode = cityCode;
	}
	final String? adCode = jsonConvert.convert<String>(json['adCode']);
	if (adCode != null) {
		publishFeedLocation.adCode = adCode;
	}
	final String? address = jsonConvert.convert<String>(json['address']);
	if (address != null) {
		publishFeedLocation.address = address;
	}
	final String? name = jsonConvert.convert<String>(json['name']);
	if (name != null) {
		publishFeedLocation.name = name;
	}
	return publishFeedLocation;
}

Map<String, dynamic> $PublishFeedLocationToJson(PublishFeedLocation entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['latitude'] = entity.latitude;
	data['longitude'] = entity.longitude;
	data['cityCode'] = entity.cityCode;
	data['adCode'] = entity.adCode;
	data['address'] = entity.address;
	data['name'] = entity.name;
	return data;
}