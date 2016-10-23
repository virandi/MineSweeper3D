
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
			
			Main.Instance.PushState (StateIntro.Instance);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
