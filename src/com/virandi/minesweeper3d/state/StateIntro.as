
package com.virandi.minesweeper3d.state
{
	import flash.events.Event;
	
	import com.virandi.base.CGUI;
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	
	public class StateIntro extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateIntro = null;
		
		static public function get Instance () : StateIntro
		{
			return (StateIntro.instance = ((StateIntro.instance == null) ? new StateIntro () : StateIntro.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateIntro ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_INTRO];
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
			super.DeInitialize ();
			
			return this;
		}
		
		override public function Initialize () : IState
		{
			super.Initialize ();
			
			this.gui ["MC_ANIMATION_INTRO"].gotoAndPlay (1, null);
			
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
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Update () : IUpdate
		{
			super.Update ();
			
			if (this.gui ["MC_ANIMATION_INTRO"].currentFrame == this.gui ["MC_ANIMATION_INTRO"].totalFrames)
			{
				Main.Instance.ChangeState (StateMenu.Instance);
			}
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
