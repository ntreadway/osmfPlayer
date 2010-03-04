package
{
  import flash.display.Graphics;
  import flash.display.Sprite;
  import flash.display.MovieClip;
  import flash.events.MouseEvent;
  import org.osmf.containers.MediaContainer;
  import org.osmf.events.PlayEvent;
  import org.osmf.layout.LayoutUtils;
  import org.osmf.media.*;
  import org.osmf.utils.URL;
  import org.osmf.metadata.Metadata;
  // Debugger http://demonsterdebugger.com/
  import  nl.demonsters.debugger.MonsterDebugger;
  [SWF(width="500", height="300", frameRate="30", backgroundColor="#CCCCCC")]
  public class player extends Sprite
  {
    public function player()
    {
      mediaFactory = new DefaultMediaFactory();
      mediaElement = mediaFactory.createMediaElement(new URLResource(VIDEO_URL));
      mediaPlayer = new MediaPlayer();
      mediaPlayer.autoPlay = false;
      mediaPlayer.media = mediaElement;
      mediaContainer = new MediaContainer();
      mediaContainer.addMediaElement(mediaElement);
      addChild(mediaContainer);
      LayoutUtils.setAbsoluteLayout(mediaElement.metadata, 500, 300);
      
      var playButton:Sprite = constructPlayButton();
      addChild(playButton);
      
      var videoScrubber:MovieClip =  VideoScrubber(mediaPlayer.media ,120);
      addChild(_track);
      addChild(_thumb);
      
      playButton.addEventListener
      ( MouseEvent.CLICK
      , function():void{ mediaPlayer.play(); }
      );
      mediaPlayer.addEventListener
      ( PlayEvent.PLAY_STATE_CHANGE
      , function():void{ playButton.visible = !mediaPlayer.playing; }
      );
      
    }
    
    // OSMF Vars and Const
    private static const VIDEO_URL:URL = new URL("http://yeti-media.com/flv/video-w50s.flv");
    
    private var mediaFactory:MediaFactory;
    private var mediaElement:MediaElement;
    private var mediaPlayer:MediaPlayer;
    private var mediaContainer:MediaContainer;
    
    // TO DO Migrate to its own class
    // UI 
    private static const SIZE:Number = 100;
    private static const X:Number = 320;
    private static const Y:Number = 180;
    private static const F:Number = 1.2;
  
    private var _thumb:Sprite;
    private var _track:Sprite;
    private var _stream:MediaPlayer;
    private var _duration:Number;
    private var _scrubbing:Boolean;
    
    // TO DO Migrate to its own class
    // UI Functions Vars and Const
    private function VideoScrubber(_stream:MediaPlayer, _duration:Number):Sprite 
    {
        _stream = stream;
        _duration = duration;
        _track = new Sprite();
        _track.graphics.lineStyle(  );
        _track.graphics.drawRect(0, -2.5, this.width, 5);
        _thumb = new Sprite(  );
        _thumb.graphics.lineStyle(  );
        _thumb.graphics.beginFill(0xFFFFFF);
        _thumb.graphics.drawRect(-5, -5, 10, 10);
        _thumb.graphics.endFill(  );
        //addEventListener(Event.ENTER_FRAME, onEnterFrame);
        //_thumb.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
        //_thumb.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
        return _track, _thumb;
    }
    
    private function constructPlayButton():Sprite
    {
      var result:Sprite = new Sprite();
      var g:Graphics = result.graphics;
      g.lineStyle(1, 0, 0.5);
      g.beginFill(0xA0A0A0, 0.5);
      g.moveTo(X - SIZE / F, Y - SIZE);
      g.lineTo(X + SIZE / F, Y);
      g.lineTo(X - SIZE / F, Y + SIZE);
      g.lineTo(X - SIZE / F, Y - SIZE);
      g.endFill();
      return result;
    }
    
    }
}