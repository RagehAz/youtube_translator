import 'package:abotube/a_models/caption_model.dart';
import 'package:flutter/material.dart';

@immutable
class VideoModel {
  // -----------------------------------------------------------------------------
  const VideoModel({
    @required this.id,
    @required this.title,
    @required this.url,
    @required this.captions,
});
  // -----------------------------------------------------------------------------
  final String id;
  final String title;
  final String url;
  final List<CaptionModel> captions;
  // -----------------------------------------------------------------------------

  /// CYPHERS

  // --------------------
  /// TESTED : WORKS PERFECT
  Map<String, dynamic> toMap(){
    return  {
      'id': id,
      'title': title,
      'url': url,
      'captions': CaptionModel.cipherCaptions(captions),
    };
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static VideoModel decipher(Map<String, dynamic> map){

    if (map == null) {
      return null;
    }

    else {
      return VideoModel(
        id: map['id'],
        title: map['title'],
        url: map['url'],
        captions: CaptionModel.decipherCaptions(map['captions']),
      );
    }

  }
  // -----------------------------------------------------------------------------

  /// EQUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  static bool checkVideoModelsAreIdentical(VideoModel model1, VideoModel model2){
    bool _identical = false;

    if (model1 == null && model2 == null){
      _identical = true;
    }

    else if (model1 != null && model2 != null) {
      if (
      model1.id == model2.id &&
      model1.title == model2.title &&
      model1.url == model2.url &&
      CaptionModel.checkCaptionsListsAreIdentical(captions1: model1.captions, captions2: model2.captions)
    ) {
        _identical = true;
      }
    }

    return _identical;
  }
  // -----------------------------------------------------------------------------

  /// OVERRIDES

  // --------------------
  /*
   @override
   String toString() => 'MapModel(key: $key, value: ${value.toString()})';
   */
  // --------------------
  @override
  bool operator == (Object other){

    if (identical(this, other)) {
      return true;
    }

    bool _areIdentical = false;
    if (other is VideoModel){
      _areIdentical = checkVideoModelsAreIdentical(
        this,
        other,
      );
    }

    return _areIdentical;
  }
  // --------------------
  @override
  int get hashCode =>
      id.hashCode^
      url.hashCode^
      title.hashCode;
  // -----------------------------------------------------------------------------
}
