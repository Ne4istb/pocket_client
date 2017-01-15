library pocket_client.retreive_options;

import 'package:pocket_client/src/enums.dart';

class RetrieveOptions {

  State state;
  bool isFavorite;
  String tag;
  ContentType contentType;
  SortType sortType;
  DetailType detailType;
  String search;
  String domain;
  DateTime since;
  int count;
  int offset;

  RetrieveOptions({this.state, this.isFavorite, this.tag, this.contentType, this.sortType, this.detailType,
  this.search, this.domain, this.since, this.count, this.offset});

  Map<String,String> toMap(){

    Map<String,String> result = new Map<String, String>();

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

  String _getStateValueString(State state){
    switch (state){
      case State.unread:
        return 'unread';
      case State.all:
        return 'all';
      case State.archive:
        return 'archive';
      default:
        throw new ArgumentError('Unknown state type');
    }
  }

  String _getContentTypeString(ContentType contentType){
    switch (contentType){
      case ContentType.article:
        return 'article';
      case ContentType.video:
        return 'video';
      case ContentType.image:
        return 'image';
      default:
        throw new ArgumentError('Unknown content type');
    }
  }

  String _getSortTypeString(SortType sortType){
    switch (sortType){
      case SortType.newest:
        return 'newest';
      case SortType.oldest:
        return 'oldest';
      case SortType.site:
        return 'site';
      case SortType.title:
        return 'title';
      default:
        throw new ArgumentError('Unknown sort type');
    }
  }

  String _getDetailTypeString(DetailType detailType){
    switch (detailType){
      case DetailType.complete:
        return 'complete';
      case DetailType.simple:
        return 'simple';
      default:
        throw new ArgumentError('Unknown detail type');
    }
  }
}