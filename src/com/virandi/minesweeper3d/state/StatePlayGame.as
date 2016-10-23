
package com.virandi.minesweeper3d.state
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	
	import com.milkmangames.nativeextensions.AdMob;
	import com.milkmangames.nativeextensions.AdMobAdType;
	import com.milkmangames.nativeextensions.AdMobAlignment;
	
	import org.papervision3d.core.render.data.RenderHitData;
	
	import com.virandi.base.CState;
	import com.virandi.base.CVibration;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	import com.virandi.minesweeper3d.core.Board;
	import com.virandi.minesweeper3d.core.Map;
	
	public class StatePlayGame extends CState
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StatePlayGame = null;
		
		static public function get Instance () : StatePlayGame
		{
			return (StatePlayGame.instance = ((StatePlayGame.instance == null) ? new StatePlayGame () : StatePlayGame.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StatePlayGame ()
		{
			super ();
			
			this.gui.displayObjectContainer = Library.Instance.dictionary [Library.MC_GUI_STATE_PLAY_GAME];
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function HandleEvent (event:Event) : IHandleEvent
		{
			super.HandleEvent (event);
			
			var point:Point = null;
			
			var renderHitData:RenderHitData = null;
			
			if ((event is MouseEvent) || (event is TouchEvent))
			{
				switch (event.type)
				{
					case MouseEvent.CLICK :
					case TouchEvent.TOUCH_TAP :
					{
						switch (event.target.name)
						{
							case "MC_BUTTON_PLAYER_TOOL_FLAG" :
							{
								switch (Main.Instance.player.tool)
								{
									case Board.TOOL_FLAG :
									{
										Main.Instance.player.tool = Board.TOOL_PICK;
										
										break;
									}
									case Board.TOOL_PICK :
									{
										Main.Instance.player.tool = Board.TOOL_FLAG;
										
										break;
									}
									default :
									{
										break;
									}
								}
								
								break;
							}
							case "MC_BUTTON_PAUSE" :
							{
								Main.Instance.PushState (StatePauseGame.Instance);
								
								break;
							}
							default :
							{
								if (Main.Instance.view3D.touch [0].click == false)
								{
								}
								else
								{
									Main.Instance.view3D.viewport.interactive = true;
									{
										point = Main.Instance.view3D.viewport.containerSprite.globalToLocal (Main.Instance.view3D.touch [0].point);
										
										renderHitData = Main.Instance.view3D.viewport.hitTestPoint2D (point);
										
										if ((renderHitData == null) || (renderHitData.displayObject3D == null))
										{
										}
										else
										{
											if (Main.Instance.player.board3D.extra.board.virgin == false)
											{
											}
											else
											{
												Main.Instance.player.timer.reset ();
												Main.Instance.player.timer.start ();
											}
											
											Main.Instance.player.board3D.Touch (renderHitData.displayObject3D.parent, Main.Instance.player.tool);
										}
									}
									Main.Instance.view3D.viewport.interactive = false;
									
									if (Main.Instance.player.board3D.extra.board.boom == false)
									{
										if (Main.Instance.player.board3D.extra.board.pick == (Main.Instance.player.board3D.extra.board.face.length - Main.Instance.player.board3D.extra.board.mine))
										{
											Main.Instance.player.state = 1;
										}
									}
									else
									{
										if (Main.Instance.player.board3D.extra.board.mined == 3)
										{
											CVibration.Instance.Vibrate (3000.0);
											
											Main.Instance.player.state = -1;
										}
										else
										{
											CVibration.Instance.Vibrate (1000.0);
										}
									}
									
									if (Main.Instance.player.state == 0)
									{
									}
									else
									{
										Main.Instance.ChangeState (StateEndGame.Instance);
									}
								}
								
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
			
			var mined:int = (0x7 >> Main.Instance.player.board3D.extra.board.mined);
			
			var tick:int = Main.Instance.player.timer.currentCount;
			
			var tickMinute:int = (tick / 60);
			
			var tickSecond:int = (tick % 60);
			
			var unpick:int = ((Main.Instance.player.board3D.extra.board.face.length - Main.Instance.player.board3D.extra.board.mine) - Main.Instance.player.board3D.extra.board.pick);
			
			this.gui ["MC_PLAYER_MINED"]["MC_X_00X"].gotoAndStop (((mined >> 0x2) + 1), null);
			this.gui ["MC_PLAYER_MINED"]["MC_X_0X0"].gotoAndStop (((mined >> 0x1) + 1), null);
			this.gui ["MC_PLAYER_MINED"]["MC_X_X00"].gotoAndStop (((mined >> 0x0) + 1), null);
			
			this.gui ["MC_PLAYER_TICK"]["MC_DIGIT_000X"].gotoAndStop (((int (tickSecond / 1) % 10) + 1), null);
			this.gui ["MC_PLAYER_TICK"]["MC_DIGIT_00X0"].gotoAndStop (((int (tickSecond / 10) % 10) + 1), null);
			this.gui ["MC_PLAYER_TICK"]["MC_DIGIT_0X00"].gotoAndStop (((int (tickMinute / 1) % 10) + 1), null);
			this.gui ["MC_PLAYER_TICK"]["MC_DIGIT_X000"].gotoAndStop (((int (tickMinute / 10) % 10) + 1), null);
			
			this.gui ["MC_PLAYER_UNPICK"]["MC_DIGIT_00X"].gotoAndStop (((int (unpick / 1) % 10) + 1), null);
			this.gui ["MC_PLAYER_UNPICK"]["MC_DIGIT_0X0"].gotoAndStop (((int (unpick / 10) % 10) + 1), null);
			this.gui ["MC_PLAYER_UNPICK"]["MC_DIGIT_X00"].gotoAndStop (((int (unpick / 100) % 10) + 1), null);
			
			Main.Instance.view3D.Render ();
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function DeInitialize () : IState
		{
			Main.Instance.player.timer.stop ();
			
			super.DeInitialize ();
			
			return this;
		}
		
		override public function Initialize () : IState
		{
			super.Initialize ();
			
			if (AdMob.isSupported == false)
			{
			}
			else
			{
				AdMob.setBannerAdUnitID ("ca-app-pub-5031578440768560/1899868336", null);
				AdMob.showAd (AdMobAdType.SMART_BANNER, AdMobAlignment.CENTER, AdMobAlignment.TOP, 0, 0);
			}
			
			Main.Instance.player.board3D = Main.Instance.player.board3D.Clean ().Shuffle (Main.Instance.player.difficulty, 3);
			
			Main.Instance.view3D.camera.extra.zoomAble = true;
			
			Main.Instance.player.timer.reset ();
			Main.Instance.player.timer.stop ();
			
			Main.Instance.view3D.camera.transform.copy3x3 (Main.Instance.view3D.camera.extra.matrixIdentity);
			
			return this;
		}
		
		override public function Pause () : IState
		{
			super.Pause ();
			
			this.visible = false;
			
			Main.Instance.player.timer.stop ();
			
			return this;
		}
		
		override public function Resume () : IState
		{
			super.Resume ();
			
			this.visible = true;
			
			if (Main.Instance.player.board3D.extra.board.virgin == false)
			{
				Main.Instance.player.timer.start ();
			}
			
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
