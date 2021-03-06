
package com.virandi.minesweeper3d.state
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	
	public class StateHowToPlay extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateHowToPlay = null;
		
		static public function get Instance () : StateHowToPlay
		{
			return (StateHowToPlay.instance = ((StateHowToPlay.instance == null) ? new StateHowToPlay () : StateHowToPlay.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateHowToPlay ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_HOW_TO_PLAY];
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			switch (event.type)
			{
				case MouseEvent.CLICK :
				case TouchEvent.TOUCH_TAP :
				{
					switch (event.target.name)
					{
						case "MC_BUTTON_BACK" :
						{
							Main.Instance.ChangeState (StateMenu.Instance);
							
							break;
						}
						default :
						{
							break;
						}
					}
					
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
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
