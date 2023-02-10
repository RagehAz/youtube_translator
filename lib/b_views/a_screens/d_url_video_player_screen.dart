import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:bubbles/bubbles.dart';
import 'package:flutter/material.dart';
import 'package:numeric/numeric.dart';
import 'package:scale/scale.dart';
import 'package:super_text/super_text.dart';
import 'package:video_player/video_player.dart';
import 'package:video_translator/b_views/x_components/buttons/player_button.dart';
import 'package:video_translator/b_views/x_components/layout/floating_list.dart';
import 'package:video_translator/b_views/x_components/layout/layout.dart';
import 'package:video_translator/b_views/x_components/players/url_video_player.dart';
import 'package:video_translator/services/helpers/helper_methods.dart';

class URLVideoPlayerScreen extends StatefulWidget {
  /// --------------------------------------------------------------------------
  const URLVideoPlayerScreen({
    this.url,
    Key key
  }) : super(key: key);

  final String url;
  /// --------------------------------------------------------------------------
  @override
  _URLVideoPlayerScreenState createState() => _URLVideoPlayerScreenState();
  /// --------------------------------------------------------------------------
}

class _URLVideoPlayerScreenState extends State<URLVideoPlayerScreen> {
  // --------------------------------------------------------------------------
  VideoPlayerController _videoPlayerController;
  VideoPlayerValue _videoValue;
  // --------------------
  String _link;
  // --------------------
  static const double _maxVolume = 1;
  double _volume = 1;
  // --------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();

    _link = widget.url ?? 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';

    _videoPlayerController = VideoPlayerController.network(
        _link,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true))
      ..initialize()
      ..setVolume(_volume)
      ..play()
      ..addListener(() => setState(() => _videoValue = _videoPlayerController.value));

  }
  // --------------------
  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// CONTROLS

  // --------------------
  /// TESTED : WORKS PERFECT
  void _play() {

    setState(() {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _pause() {

    setState(() {
      _videoPlayerController.pause();
      _videoPlayerController.setLooping(false);
    });
    // _value.isPlaying.log();

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _setVolume({
    @required double volume
  }) {

    if (_volume != volume){
      setState(() {
        _videoPlayerController.setVolume(volume);
        _volume = volume;
      });
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _increaseVolume(){

    final bool _canIncrease = _volume < _maxVolume;

    blog('canIncrease : $_canIncrease : _volume : $_volume : _maxVolume : $_maxVolume');

    if (_canIncrease){
      _setVolume(
        volume: _fixVolume(
          num: _volume + 0.1,
          isIncreasing: true,
        ),
      );
    }

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  void _decreaseVolume(){

    if (_volume > 0){
      _setVolume(
        volume: _fixVolume(
          num: _volume - 0.1,
          isIncreasing: false,
        ),
      );
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  double _fixVolume({
    @required double num,
    @required bool isIncreasing,
  }){

    /// INCREASING
    if (isIncreasing){
      final double _n = (num * 10).ceilToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

    /// DECREASING
    else {
      final double _n = (num * 10).floorToDouble();
      return Numeric.removeFractions(number: _n) / 10;
    }

  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    // --------------------
    return Layout(
      viewWidget: FloatingList(
        columnChildren: <Widget>[

          /// VIDEO PLAYER
          URLVideoPlayer(
            onTap: _play,
            onDoubleTap: _pause,
            width: Scale.screenWidth(context),
            videoPlayerController: _videoPlayerController,
            videoValue: _videoValue,
          ),

          const DotSeparator(),

          /// VIDEO CONTROLS PANEL
          Container(
            width: Scale.screenWidth(context),
            height: 60,
            color: Colorz.white10,
            alignment: Alignment.center,
            child: FloatingList(
              scrollDirection: Axis.horizontal,
              columnChildren: <Widget>[

                /// PLAY
                PlayerButton(
                  icon: Iconz.play,
                  onTap: _play,
                ),

                /// PAUSE
                PlayerButton(
                  icon: Iconz.pause,
                  onTap: _pause,
                ),

                /// INCREASE VOLUME
                PlayerButton(
                  icon: Iconz.arrowUp,
                  onTap: _increaseVolume,
                ),

                /// DECREASE VOLUME
                PlayerButton(
                  icon: Iconz.arrowDown,
                  onTap: _decreaseVolume,
                ),

              ],
            ),
          ),

          /// VOLUME
          SuperText(
            text: 'Volume : $_volume',
            textHeight: 30,
          ),

          const DotSeparator(),

        ],
      ),
    );
    // --------------------

  }
  // --------------------------------------------------------------------------
}