
package com.virandi.minesweeper3d.state
{
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	
	import org.papervision3d.core.math.Matrix3D;
	
	import com.virandi.base.CState;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	import com.virandi.minesweeper3d.core.Board;
	import com.virandi.minesweeper3d.core.Map;
	
	public class StateSelectMap extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateSelectMap = null;
		
		static public function get Instance () : StateSelectMap
		{
			return (StateSelectMap.instance = ((StateSelectMap.instance == null) ? new StateSelectMap () : StateSelectMap.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateSelectMap ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_SELECT_MAP];
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			var i:int = 0;
			
			switch (event.type)
			{
				case MouseEvent.CLICK :
				case TouchEvent.TOUCH_TAP :
				{
					switch (event.target.name)
					{
						case "MC_BUTTON_ARROW_LEFT" :
						case "MC_BUTTON_ARROW_RIGHT" :
						{
							switch (event.target.name)
							{
								case "MC_BUTTON_ARROW_LEFT" :
								{
									Main.Instance.player.map = (Main.Instance.player.map - 1);
									
									break;
								}
								case "MC_BUTTON_ARROW_RIGHT" :
								{
									Main.Instance.player.map = (Main.Instance.player.map + 1);
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							if (Main.Instance.player.map == -1)
							{
								Main.Instance.player.map = (DB.Instance.CACHE_MAP.length - 1);
							}
							else if (Main.Instance.player.map == DB.Instance.CACHE_MAP.length)
							{
								Main.Instance.player.map = 0;
							}
							
							Main.Instance.RestartState ();
							
							break;
						}
						case "MC_BUTTON_BACK" :
						{
							Main.Instance.PopState ();
							
							break;
						}
						case "MC_BUTTON_DIFFICULTY_HARD" :
						case "MC_BUTTON_DIFFICULTY_NOOB" :
						case "MC_BUTTON_DIFFICULTY_NORMAL" :
						{
							i = Board.DIFFICULTY_NONE;
							
							switch (event.target.name)
							{
								case "MC_BUTTON_DIFFICULTY_HARD" :
								{
									if (Main.Instance.player.difficulty == Board.DIFFICULTY_HARD)
									{
									}
									else
									{
										i = Board.DIFFICULTY_HARD;
									}
									
									break;
								}
								case "MC_BUTTON_DIFFICULTY_NOOB" :
								{
									if (Main.Instance.player.difficulty == Board.DIFFICULTY_NOOB)
									{
									}
									else
									{
										i = Board.DIFFICULTY_NOOB;
									}
									
									break;
								}
								case "MC_BUTTON_DIFFICULTY_NORMAL" :
								{
									if (Main.Instance.player.difficulty == Board.DIFFICULTY_NORMAL)
									{
									}
									else
									{
										i = Board.DIFFICULTY_NORMAL;
									}
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							Main.Instance.player.difficulty = i;
							
							break;
						}
						case "MC_BUTTON_PLAY" :
						{
							if (Main.Instance.player.difficulty == Board.DIFFICULTY_NONE)
							{
							}
							else
							{
								Main.Instance.ChangeState (StatePlayGame.Instance);
							}
							
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
			
			Main.Instance.view3D.HandleEvent (event);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Render () : IRender
		{
			super.Render ();
			
			var crown:MovieClip = null;
			
			var data:Object = null;
			
			for each (data in DB.Instance.CACHE_RECORD)
			{
				if (data.MAP_BIT == Main.Instance.player.board3D.extra.board.map.bit)
				{
					crown = null;
					
					switch (data.DIFFICULTY_LEVEL)
					{
						case DB.Instance.CACHE_DIFFICULTY [Board.DIFFICULTY_HARD].LEVEL :
						{
							crown = this.gui ["MC_CROWN_DIFFICULTY_HARD"];
							
							break;
						}
						case DB.Instance.CACHE_DIFFICULTY [Board.DIFFICULTY_NOOB].LEVEL :
						{
							crown = this.gui ["MC_CROWN_DIFFICULTY_NOOB"];
							
							break;
						}
						case DB.Instance.CACHE_DIFFICULTY [Board.DIFFICULTY_NORMAL].LEVEL :
						{
							crown = this.gui ["MC_CROWN_DIFFICULTY_NORMAL"];
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					if (crown == null)
					{
					}
					else
					{
						crown.gotoAndStop (2, null);
						
						crown ["MC_DIGIT_000X"].gotoAndStop (int ((((data.TICK % 60) / 1) % 10) + 1), null);
						crown ["MC_DIGIT_00X0"].gotoAndStop (int ((((data.TICK % 60) / 10) % 10) + 1), null);
						crown ["MC_DIGIT_0X00"].gotoAndStop (int ((((data.TICK / 60) / 1) % 10) + 1), null);
						crown ["MC_DIGIT_X000"].gotoAndStop (int ((((data.TICK / 60) / 10) % 10) + 1), null);
					}
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
			
			Main.Instance.player.board3D = Main.Instance.player.board3D.Create (((DB.Instance.CACHE_MAP.length == 0) ? Map.Instance.Create ({BIT:null, X:3, Y:3, Z:3}) : Map.Instance.Create (DB.Instance.CACHE_MAP [Main.Instance.player.map])));
			Main.Instance.player.difficulty = Board.DIFFICULTY_NONE;
			
			Main.Instance.view3D.camera.transform.copy3x3 (Main.Instance.view3D.camera.extra.matrixIdentity);
			
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
