
package com.virandi.minesweeper3d.state
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import com.virandi.base.CAudio;
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	
	public class StatePauseGame extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StatePauseGame = null;
		
		static public function get Instance () : StatePauseGame
		{
			return (StatePauseGame.instance = ((StatePauseGame.instance == null) ? new StatePauseGame () : StatePauseGame.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StatePauseGame ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_PAUSE_GAME];
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			if ((event is MouseEvent) || (event is TouchEvent))
			{
				switch (event.type)
				{
					case MouseEvent.CLICK :
					case TouchEvent.TOUCH_TAP :
					{
						switch (event.target.name)
						{
							case "MC_BUTTON_QUIT" :
							{
								Main.Instance.PopState ();
							}
							case "MC_BUTTON_RESUME" :
							{
								Main.Instance.PopState ();
								
								break;
							}
							case "MC_BUTTON_SPEAKER" :
							{
								CAudio.Instance.State (((CAudio.Instance.state == CAudio.STATE_OFF) ? CAudio.STATE_ON : CAudio.STATE_OFF));
								
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
			}
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Render () : IRender
		{
			super.Render ();
			
			Main.Instance.view3D.viewport.containerSprite.graphics.clear ();
			
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
			
			this.gui ["MC_BUTTON_SELECT_SPEAKER"]["MC_BUTTON_SPEAKER"].gotoAndStop (((CAudio.Instance.state == CAudio.STATE_OFF) ? 3 : 1));
			
			Main.Instance.view3D.viewport.graphics.clear ();
			
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
