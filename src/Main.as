
/*
 * WHAT		: MINESWEEPER3D
 * WHO		: YUSUF RIZKY VIRANDI @ .VIRANDI. STUDIO
 *
 * LICENSE	: KNOWLEDGE BELONGS TO THE WORLD..
 */

package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.media.SoundMixer;
	
	import com.milkmangames.nativeextensions.AdMob;
	import com.milkmangames.nativeextensions.events.AdMobEvent;
	import com.milkmangames.nativeextensions.events.AdMobErrorEvent;
	
	import com.purplebrain.adbuddiz.sdk.nativeExtensions.AdBuddiz;
	import com.purplebrain.adbuddiz.sdk.nativeExtensions.AdBuddizEvent;
	
	import org.papervision3d.cameras.CameraType;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.view.BasicView;
	
	import com.virandi.base.CAudio;
	import com.virandi.base.CMain;
	import com.virandi.base.CVibration;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IState;
	import com.virandi.minesweeper3d.render.papervision3d.View3D;
	import com.virandi.minesweeper3d.state.StateIntro;
	import com.virandi.minesweeper3d.state.StateMenu;
	
	public class Main extends CMain
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:Main = null;
		
		static public function get Instance () : Main
		{
			return (Main.instance = ((Main.instance == null) ? new Main () : Main.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function get Height () : Number
		{
			return 480.0;
		}
		
		override public function get Width () : Number
		{
			return 320.0;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var player:Object = null;
		
		public var view3D:View3D = null;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Main ()
		{
			super ();
			
			Main.instance = this;
			
			Main.Instance.opaqueBackground = 0x000000;
			
			CAudio.Instance.Initialize ().Play (Library.Instance.dictionary [Library.MP3_MONKEY_ISLAND_BAND], CAudio.PLAY_FOREVER);
			
			DB.Instance.Initialize ().Cache ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			switch (event.type)
			{
				case Event.ACTIVATE :
				{
					if (CAudio.Instance.state == CAudio.STATE_MUTE)
					{
						CAudio.Instance.State (CAudio.STATE_ON);
					}
					
					break;
				}
				case Event.DEACTIVATE :
				{
					if (CAudio.Instance.state == CAudio.STATE_ON)
					{
						CAudio.Instance.State (CAudio.STATE_MUTE);
					}
					
					DB.Instance.Flush ();
					
					break;
				}
				default :
				{
					break;
				}
			}
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function DeInitialize () : IState
		{
			DB.Instance.Flush ();
			
			super.DeInitialize ();
			
			return this;
		}
		
		override public function Initialize () : IState
		{
			super.Initialize ();
			
			this.player = new Object ();
			
			this.view3D = new View3D (this.Width, this.Height, false, false, CameraType.FREE);
			
			this.addChild (this.view3D);
			this.addChildAt (Library.Instance.dictionary [Library.MC_BACKGROUND], 0);
			
			AdBuddiz.setAndroidPublisherKey ("fe48c79d-1683-4238-b0ab-120e9f459c18");
			AdBuddiz.cacheAds ();
			
			AdBuddiz.addEventListener (AdBuddizEvent.didCacheAd, this.OnAdBuddizEvent);
			AdBuddiz.addEventListener (AdBuddizEvent.didFailToShowAd, this.OnAdBuddizEvent);
			AdBuddiz.addEventListener (AdBuddizEvent.didShowAd, this.OnAdBuddizEvent);
			
			if (AdMob.isSupported == false)
			{
			}
			else
			{
				AdMob.init ("pub-5031578440768560", null);
				
				AdMob.addEventListener (AdMobErrorEvent.FAILED_TO_RECEIVE_AD, this.OnAdMobEvent, false, 0, false);
				AdMob.addEventListener (AdMobEvent.RECEIVED_AD, this.OnAdMobEvent, false, 0, false);
			}
			
			Main.Instance.PushState (StateIntro.Instance);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function OnAdBuddizEvent (adBuddizEvent:AdBuddizEvent) : void
		{
			var i:int = 0;
			
			switch (adBuddizEvent.type)
			{
				case AdBuddizEvent.didCacheAd :
				{
					break;
				}
				case AdBuddizEvent.didFailToShowAd :
				{
					for (i = 0; i != 100; ++i)
					{
						if (AdBuddiz.isReadyToShowAd () == false)
						{
							AdBuddiz.cacheAds ();
						}
						else
						{
							AdBuddiz.showAd ();
							
							break;
						}
					}
					
					break;
				}
				case AdBuddizEvent.didShowAd :
				{
					break;
				}
				default :
				{
					break;
				}
			}
			
			return;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function OnAdMobEvent (event:Event) : void
		{
			switch (event.type)
			{
				case AdMobErrorEvent.FAILED_TO_RECEIVE_AD :
				{
					break;
				}
				case AdMobEvent.RECEIVED_AD :
				{
					break;
				}
				default :
				{
					break;
				}
			}
			
			return;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
