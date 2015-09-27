library pocket_client.retreive_options;

import 'dart:convert';
import 'package:pocket_client/src/pocket_state.dart';
import 'package:pocket_client/src/pocket_content_type.dart';
import 'package:pocket_client/src/pocket_sort_type.dart';
import 'package:pocket_client/src/pocket_detail_type.dart';

class PocketRetrieveOptions {

  PocketState state;
  bool isFavorite;
  String tag;
  PocketContentType contentType;
  PocketSortType sortType;
  PocketDetailType detailType;
  String search;
  String domain;
  DateTime since;
  int count;
  int offset;

  PocketRetrieveOptions({this.state, this.isFavorite, this.tag, this.contentType, this.sortType, this.detailType,
  this.search, this.domain, this.since, this.count, this.offset});

  Map<String,String> toMap(){

    Map<String,String> result = {};

    if (state != null)
      result['state'] = _getStateValueString(state);

    if (isFavorite != null)
      result['favorite'] = isFavorite ? '1' : '0';

    if (tag != null && tag.isNotEmpty)
      result['tag'] = tag;

    if (contentType != null)
      result['contentType'] = _getContentTypeString(contentType);

    if (sortType != null)
      result['sort'] = _getSortTypeString(sortType);

    if (detailType != null)
      result['detailType'] = _getDetailTypeString(detailType);

    if (search !=null && search.isNotEmpty)
      result['search'] = search;

    if (domain !=null && domain.isNotEmpty)
      result['domain'] = domain;

    if (count !=null && count > 0)
      result['count'] = count.toString();

    if (offset !=null && result.containsKey('count'))
      result['offset'] = offset.toString();

    if (since != null)
      result['since'] = since.millisecondsSinceEpoch.toString();

    return result;
  }

  String _getStateValueString(PocketState state){
    switch (state){
      case PocketState.Unread:
        return 'unread';
      case PocketState.All:
        return 'all';
      case PocketState.Archive:
        return 'archive';
    }
  }

  String _getContentTypeString(PocketContentType contentType){
    switch (contentType){
      case PocketContentType.Article:
        return 'article';
      case PocketContentType.Video:
        return 'video';
      case PocketContentType.Image:
        return 'image';
    }
  }

  String _getSortTypeString(PocketSortType sortType){
    switch (sortType){
      case PocketSortType.Newest:
        return 'newest';
      case PocketSortType.Oldest:
        return 'oldest';
      case PocketSortType.Site:
        return 'site';
      case PocketSortType.Title:
        return 'title';
    }
  }

  String _getDetailTypeString(PocketDetailType detailtype){
    switch (detailtype){
      case PocketDetailType.Complete:
        return 'complete';
      case PocketDetailType.Simple:
        return 'simple';
    }
  }
}