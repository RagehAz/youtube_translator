

import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:mapper/mapper.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class ExploderProtocols {
  // --------------------
  /// private constructor to create instances of this class only in itself
  ExploderProtocols.singleton();
  // --------------------
  /// Singleton instance
  static final ExploderProtocols _singleton = ExploderProtocols.singleton();
  // --------------------
  /// Singleton accessor
  static ExploderProtocols get instance => _singleton;
  // -----------------------------------------------------------------------------

  /// YoutubeExplode SINGLETON

  // --------------------
  /// YoutubeExplode SINGLETON
  YoutubeExplode _youtubeExplode;
  YoutubeExplode get youtubeExplode => _youtubeExplode ??= YoutubeExplode();
  static YoutubeExplode getYoutubeExplodeInstance() => ExploderProtocols.instance.youtubeExplode;
  // -----------------------------------------------------------------------------

  /// CLOSED CAPTION TRACK INFO

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<List<ClosedCaptionTrackInfo>> readClosedCaptionTrackInfos({
    @required String landCode,
    @required String videoID,
    bool autoGenerated = true,
    ClosedCaptionFormat format,
  }) async {
    List<ClosedCaptionTrackInfo> infos = [];

    if (videoID != null) {
      final YoutubeExplode yt = getYoutubeExplodeInstance();

      await tryAndCatch(
        invoker: 'readClosedCaptionTrackInfos',
        functions: () async {
          final ClosedCaptionManifest trackManifest =
              await yt.videos.closedCaptions.getManifest(videoID);

          final List<ClosedCaptionTrackInfo> _trackInfos = trackManifest?.getByLanguage(
            landCode,
            autoGenerated: true,
            format: format,
          ); // Get english

          if (Mapper.checkCanLoopList(_trackInfos) == true) {
            infos = _trackInfos;
          }
        },
      );

      // caption.
    }

    return infos;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<ClosedCaptionTrack> readClosedCaptionTrack({
    @required ClosedCaptionTrackInfo info,
  }) async {
    ClosedCaptionTrack _track;

    if (info != null){

      _track = await ExploderProtocols
          .getYoutubeExplodeInstance()
          .videos
          .closedCaptions
          .get(info);

    }

    return _track;
  }
  // -----------------------------------------------------------------------------

  /// BLOGGING
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogClosedCaptionTrackInfo({
    @required ClosedCaptionTrackInfo info,
  }){

    if (info == null){
      blog('blogClosedCaptionTrackInfo : info is null');
    }
    else {
      blog('info.language : ${info.language}');
      blog('info.url : ${info.url}');
      blog('info.format : ${info.format}');
      blog('info.isAutoGenerated : ${info.isAutoGenerated}');
      blog('info.toString() : $info');
      blog('info.toJson() : ${info.toJson()}');
      blog('info.autoTranslate(ar) : ${info.autoTranslate('ar')}');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogClosedCaptionTrack({
    @required ClosedCaptionTrack track,
  }){

    if (track == null){
      blog('blogClosedCaptionTrack : track is null');
    }
    else {
      blog('track.toJson() : ${track.toJson()}');
      blog('track.captions has : ${track.captions.length} captions');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogClosedCaption({
    @required ClosedCaption closedCaption,
  }){

    if (closedCaption == null){
      blog('blogClosedCaption : closedCaption is null');
    }
    else {
      blog('caption.end : ${closedCaption.end}');
      blog('caption.text : ${closedCaption.text}');
      blog('caption.duration : ${closedCaption.duration}');
      blog('caption.offset : ${closedCaption.offset}');
      blog('caption has : ${closedCaption.parts.length} parts');
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static void blogClosedCaptionPart({
    @required ClosedCaptionPart part,
  }){

    if (part == null){
      blog('blogClosedCaptionPart : part is null');
    }
    else {
      blog('part.offset : ${part.offset} : part.text : ${part.text}');
    }

  }
  // --------------------------------------------------------------------------
}
