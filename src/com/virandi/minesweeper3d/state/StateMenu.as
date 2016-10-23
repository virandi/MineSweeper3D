
package com.virandi.minesweeper3d.state
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	
	import com.milkmangames.nativeextensions.AdMob;
	
	import com.virandi.base.CAudio;
	import com.virandi.base.CGUI;
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	
	public class StateMenu extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateMenu = null;
		
		static public function get Instance () : StateMenu
		{
			return (StateMenu.instance = ((StateMenu.instance == null) ? new StateMenu () : StateMenu.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateMenu ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_MENU];
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
						case "MC_BUTTON_CREDITS" :
						{
							Main.Instance.ChangeState (StateCredits.Instance);
							
							break;
						}
						case "MC_BUTTON_EXIT" :
						{
							Main.Instance.DeInitialize ();
							
							break;
						}
						case "MC_BUTTON_HOW_TO_PLAY" :
						{
							Main.Instance.ChangeState (StateHowToPlay.Instance);
							
							break;
						}
						case "MC_BUTTON_SPEAKER" :
						{
							CAudio.Instance.State (((CAudio.Instance.state == CAudio.STATE_OFF) ? CAudio.STATE_ON : CAudio.STATE_OFF));
							
							break;
						}
						case "MC_BUTTON_START_GAME" :
						{
							Main.Instance.ChangeState (StateStartGame.Instance);
							
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
			
			this.gui ["MC_BUTTON_SELECT_SPEAKER"]["MC_BUTTON_SPEAKER"].gotoAndStop (((CAudio.Instance.state == CAudio.STATE_OFF) ? 3 : 1));
			
			if (AdMob.isSupported == false)
			{
			}
			else
			{
				AdMob.loadInterstitial ("ca-app-pub-5031578440768560/5115103935", true, null);
			}
			
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
