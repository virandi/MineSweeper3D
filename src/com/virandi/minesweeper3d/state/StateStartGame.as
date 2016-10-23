
package com.virandi.minesweeper3d.state
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import com.purplebrain.adbuddiz.sdk.nativeExtensions.AdBuddiz;
	
	import org.papervision3d.cameras.Camera3D;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	import org.papervision3d.core.render.data.RenderHitData;
	
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	import com.virandi.minesweeper3d.core.Board;
	import com.virandi.minesweeper3d.core.Map;
	import com.virandi.minesweeper3d.render.papervision3d.Board3D;
	
	public class StateStartGame extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateStartGame = null;
		
		static public function get Instance () : StateStartGame
		{
			return (StateStartGame.instance = ((StateStartGame.instance == null) ? new StateStartGame () : StateStartGame.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateStartGame ()
		{
			super ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Render () : IRender
		{
			super.Render ();
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function DeInitialize () : IState
		{
			Main.Instance.view3D.viewport.containerSprite.graphics.clear ();
			
			Main.Instance.view3D.scene.removeChild (Main.Instance.player.board3D.Destroy ());
			
			Main.Instance.player.timer.stop ();
			
			Main.Instance.player.tool = Board.TOOL_NONE;
			Main.Instance.player.timer = null;
			Main.Instance.player.state = 0;
			Main.Instance.player.result = 0;
			Main.Instance.player.map = 0;
			Main.Instance.player.difficulty = Board.DIFFICULTY_NONE;
			Main.Instance.player.crown = false;
			Main.Instance.player.board3D = null;
			
			super.DeInitialize ();
			
			return this;
		}
		
		override public function Initialize () : IState
		{
			super.Initialize ();
			
			AdBuddiz.showAd ();
			
			Main.Instance.player.board3D = new Board3D ();
			Main.Instance.player.crown = false;
			Main.Instance.player.difficulty = Board.DIFFICULTY_NONE;
			Main.Instance.player.map = 0;
			Main.Instance.player.result = 0;
			Main.Instance.player.state = 0;
			Main.Instance.player.timer = new Timer (1000.0, 0);
			Main.Instance.player.tool = Board.TOOL_PICK;
			
			Main.Instance.view3D.camera.zoom = Main.Instance.view3D.camera.extra.defaultZoom;
			Main.Instance.view3D.camera.extra.zoomAble = false;
			
			Main.Instance.view3D.scene.addChild (Main.Instance.player.board3D, null);
			
			Main.Instance.view3D.camera.transform.copy (Main.Instance.view3D.camera.extra.matrixIdentity);
			
			Main.Instance.PushState (StateSelectMap.Instance);
			
			return this;
		}
		
		override public function Pause () : IState
		{
			super.Pause ();
			
			return this;
		}
		
		override public function Resume () : IState
		{
			super.Resume ();
			
			Main.Instance.ChangeState (StateMenu.Instance);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Update () : IUpdate
		{
			super.Update ();
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
