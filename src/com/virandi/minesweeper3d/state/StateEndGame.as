
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
	import com.virandi.minesweeper3d.core.Board;
	
	public class StateEndGame extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateEndGame = null;
		
		static public function get Instance () : StateEndGame
		{
			return (StateEndGame.instance = ((StateEndGame.instance == null) ? new StateEndGame () : StateEndGame.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateEndGame ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_END_GAME];
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
							case "MC_BUTTON_BACK" :
							{
								Main.Instance.PopState ().ChangeState (StateStartGame.Instance);
								
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
			
			Main.Instance.view3D.HandleEvent (event);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Render () : IRender
		{
			super.Render ();
			
			var mined:int = Main.Instance.player.board3D.extra.board.mined;
			
			var pinalty:int = (mined * 5);
			
			var pinaltyMinute:int = (pinalty / 60);
			
			var pinaltySecond:int = (pinalty % 60);
			
			var result:int = Main.Instance.player.result;
			
			var resultMinute:int = (result / 60);
			
			var resultSecond:int = (result % 60);
			
			var tick:int = Main.Instance.player.timer.currentCount;
			
			var tickMinute:int = (tick / 60);
			
			var tickSecond:int = (tick % 60);
			
			switch (Main.Instance.player.state)
			{
				case 0 :
				{
					break;
				}
				default :
				{
					switch (Main.Instance.player.state)
					{
						case -1 :
						{
							this.gui ["MC_PLAYER_STATE"].gotoAndStop (1, null);
							
							break;
						}
						case 1 :
						{
							this.gui ["MC_PLAYER_STATE"].gotoAndStop (2, null);
							
							switch (Main.Instance.player.difficulty)
							{
								case Board.DIFFICULTY_HARD :
								{
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"].gotoAndStop (3, null);
									
									break;
								}
								case Board.DIFFICULTY_NOOB :
								{
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"].gotoAndStop (1, null);
									
									break;
								}
								case Board.DIFFICULTY_NORMAL :
								{
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"].gotoAndStop (2, null);
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							switch (Main.Instance.player.crown)
							{
								case false :
								{
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"].gotoAndStop (1, null);
									
									break;
								}
								case true :
								{
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"].gotoAndStop (2, null);
									
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"]["MC_DIGIT_000X"].gotoAndStop (int (((resultSecond / 1) % 10) + 1), null);
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"]["MC_DIGIT_00X0"].gotoAndStop (int (((resultSecond / 10) % 10) + 1), null);
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"]["MC_DIGIT_0X00"].gotoAndStop (int (((resultMinute / 1) % 10) + 1), null);
									this.gui ["MC_PLAYER_STATE"]["MC_CROWN_DIFFICULTY"]["MC_CROWN_DIFFICULTY"]["MC_DIGIT_X000"].gotoAndStop (int (((resultMinute / 10) % 10) + 1), null);
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							this.gui ["MC_PLAYER_STATE"]["MC_MINED_DIGIT_X"].gotoAndStop ((mined + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_PINALTY_DIGIT_X"].gotoAndStop ((5 + 1), null);
							
							this.gui ["MC_PLAYER_STATE"]["MC_PINALTY_DIGIT_000X"].gotoAndStop (int (((pinaltySecond / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_PINALTY_DIGIT_00X0"].gotoAndStop (int (((pinaltySecond / 10) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_PINALTY_DIGIT_0X00"].gotoAndStop (int (((pinaltyMinute / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_PINALTY_DIGIT_X000"].gotoAndStop (int (((pinaltyMinute / 10) % 10) + 1), null);
							
							this.gui ["MC_PLAYER_STATE"]["MC_RESULT_DIGIT_000X"].gotoAndStop (int (((resultSecond / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_RESULT_DIGIT_00X0"].gotoAndStop (int (((resultSecond / 10) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_RESULT_DIGIT_0X00"].gotoAndStop (int (((resultMinute / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_RESULT_DIGIT_X000"].gotoAndStop (int (((resultMinute / 10) % 10) + 1), null);
							
							this.gui ["MC_PLAYER_STATE"]["MC_TICK_DIGIT_000X"].gotoAndStop (int (((tickSecond / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_TICK_DIGIT_00X0"].gotoAndStop (int (((tickSecond / 10) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_TICK_DIGIT_0X00"].gotoAndStop (int (((tickMinute / 1) % 10) + 1), null);
							this.gui ["MC_PLAYER_STATE"]["MC_TICK_DIGIT_X000"].gotoAndStop (int (((tickMinute / 10) % 10) + 1), null);
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					break;
				}
			}
			
			Main.Instance.view3D.Render ();
			
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
			
			var data:Object = null;
			
			Main.Instance.player.crown = false;
			Main.Instance.player.result = (Main.Instance.player.timer.currentCount + (Main.Instance.player.board3D.extra.board.mined * 5));
			
			Main.Instance.view3D.camera.extra.zoomAble = true;
			
			switch (Main.Instance.player.state)
			{
				case -1 :
				{
					Main.Instance.player.board3D.PickAllMine ();
					
					break;
				}
				case 0 :
				{
					break;
				}
				case 1 :
				{
					for each (data in DB.Instance.CACHE_RECORD)
					{
						if ((data.DIFFICULTY_LEVEL == DB.Instance.CACHE_DIFFICULTY [Main.Instance.player.difficulty].LEVEL) && (data.MAP_BIT == Main.Instance.player.board3D.extra.board.map.bit))
						{
							break;
						}
						
						data = null;
					}
					
					if (data == null)
					{
						data = {DIFFICULTY_LEVEL:new String (DB.Instance.CACHE_DIFFICULTY [Main.Instance.player.difficulty].LEVEL), MAP_BIT:new String (Main.Instance.player.board3D.extra.board.map.bit), TICK:Main.Instance.player.result};
						
						DB.Instance.CACHE_RECORD.push (data);
					}
					
					if (data.TICK < Main.Instance.player.result)
					{
					}
					else
					{
						data.TICK = Main.Instance.player.result;
						
						Main.Instance.player.crown = true;
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
			
			Main.Instance.view3D.Update ();
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
