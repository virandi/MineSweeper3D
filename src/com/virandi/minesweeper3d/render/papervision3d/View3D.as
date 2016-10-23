
package com.virandi.minesweeper3d.render.papervision3d
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	
	import org.papervision3d.view.BasicView;
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.core.math.Number3D;
	
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IUpdate;
	
	public class View3D extends BasicView implements IHandleEvent, IRender, IUpdate
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public const FILTER_GLOW_BLACK:GlowFilter = new GlowFilter (0x000000, 0.75, 8.0, 8.0, 64.0, BitmapFilterQuality.LOW, false, false);
		
		public const FILTER_GLOW_WHITE:GlowFilter = new GlowFilter (0xFFFFFF, 1.0, 8.0, 8.0, 64.0, BitmapFilterQuality.LOW, false, false);
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var touch:Vector.<Object> = null;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function View3D (viewportWidth:Number, viewportHeight:Number, scaleToStage:Boolean, interactive:Boolean, cameraType:String)
		{
			super (viewportWidth, viewportHeight, scaleToStage, interactive, cameraType);
			
			var i:int = 0;
			
			this.camera.extra = {currentZoom:0.0, defaultZoom:40.0, matrixIdentity:Matrix3D.IDENTITY, matrixPosition:Matrix3D.translationMatrix (0.0, 0.0, -1000.0), zoom:false, zoomAble:false};
			
			this.touch = new Vector.<Object> ();
			
			for (i = 0; i != 2; ++i)
			{
				this.touch [i] = new Object ();
				
				this.touch [i].click = false;
				this.touch [i].deltaX = 0.0;
				this.touch [i].deltaY = 0.0;
				this.touch [i].down = false;
				this.touch [i].drag = Number3D.ZERO;
				this.touch [i].move = new Point (0.0, 0.0);
				this.touch [i].origin = new Point (0.0, 0.0);
				this.touch [i].point = new Point (0.0, 0.0);
			}
			
			this.HandleEvent (new Event (Event.RESIZE, false, false));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function HandleEvent (event:Event) : IHandleEvent
		{
			var i:int = 0;
			
			if (event is Event)
			{
				switch (event.type)
				{
					case Event.RESIZE :
					{
						this.FILTER_GLOW_BLACK.blurX = (this.scaleX * 8.0);
						this.FILTER_GLOW_BLACK.blurY = (this.scaleY * 8.0);
						this.FILTER_GLOW_BLACK.strength = (Math.min (this.scaleX, this.scaleY) * 64.0);
						
						this.FILTER_GLOW_WHITE.blurX = (this.scaleX * 8.0);
						this.FILTER_GLOW_WHITE.blurY = (this.scaleY * 8.0);
						this.FILTER_GLOW_WHITE.strength = (Math.min (this.scaleX, this.scaleY) * 64.0);
						
						this.viewport.containerSprite.filters = [this.FILTER_GLOW_WHITE, this.FILTER_GLOW_BLACK];
						
						break;
					}
					default :
					{
						break;
					}
				}
			}
			
			if ((event is MouseEvent) || (event is TouchEvent))
			{
				i = ((event is MouseEvent) ? 0 : (event as TouchEvent).touchPointID);
				
				if ((i == 0) || (i == 1))
				{
					switch (event.type)
					{
						case MouseEvent.MOUSE_DOWN :
						case TouchEvent.TOUCH_BEGIN :
						{
							this.touch [i].click = false;
							this.touch [i].deltaX = 0.0;
							this.touch [i].deltaY = 0.0;
							this.touch [i].down = true;
							this.touch [i].drag = Number3D.ZERO;
							this.touch [i].move.x = 0.0;
							this.touch [i].move.y = 0.0;
							this.touch [i].origin.x = (event as Object).stageX;
							this.touch [i].origin.y = (event as Object).stageY;
							this.touch [i].point.x = (event as Object).stageX;
							this.touch [i].point.y = (event as Object).stageY;
							
							if (this.touch [1].down == false)
							{
							}
							else
							{
								this.touch [0].origin.x = this.touch [0].point.x;
								this.touch [0].origin.y = this.touch [0].point.y;
								
								this.touch [1].origin.x = this.touch [1].point.x;
								this.touch [1].origin.y = this.touch [1].point.y;
								
								this.camera.extra.currentZoom = this.camera.zoom;
								this.camera.extra.zoom = true;
							}
							
							break;
						}
						case MouseEvent.MOUSE_MOVE :
						case TouchEvent.TOUCH_MOVE :
						{
							if (this.touch [i].down == false)
							{
							}
							else
							{
								if (this.camera.extra.zoom == false)
								{
									this.touch [i].deltaX = ((event as Object).stageX - this.touch [i].point.x);
									this.touch [i].deltaY = ((event as Object).stageY - this.touch [i].point.y);
									this.touch [i].drag.x = (this.touch [i].drag.x + (this.touch [i].deltaY * 0.22091986));
									this.touch [i].drag.y = (this.touch [i].drag.y + (this.touch [i].deltaX * 0.22091986));
									this.touch [i].move.x = (this.touch [i].move.x + this.touch [i].deltaX);
									this.touch [i].move.y = (this.touch [i].move.y + this.touch [i].deltaY);
								}
								else
								{
									this.touch [i].move.x = this.touch [i].move.y = Number.MAX_VALUE;
								}
								
								this.touch [i].point.x = (event as Object).stageX;
								this.touch [i].point.y = (event as Object).stageY;
							}
							
							if ((this.camera.extra.zoom == false) || (this.camera.extra.zoomAble == false))
							{
							}
							else
							{
								this.camera.zoom = Math.max (20.0, Math.min (80.0, (this.camera.extra.currentZoom * (Point.distance (this.touch [0].point, Main.Instance.view3D.touch [1].point) / Point.distance (Main.Instance.view3D.touch [0].origin, this.touch [1].origin)))));
							}
							
							break;
						}
						case MouseEvent.MOUSE_UP :
						case TouchEvent.TOUCH_END :
						{
							this.touch [i].click = ((Math.abs (this.touch [i].move.length) <= 1.0) && (this.touch [1].down == false) && (this.camera.extra.zoom == false));
							this.touch [i].down = false;
							
							this.camera.extra.zoom = false;
							
							break;
						}
						case MouseEvent.MOUSE_WHEEL :
						{
							if (this.camera.extra.zoomAble == false)
							{
							}
							else
							{
								this.camera.zoom = Math.max (20.0, Math.min (80.0, (this.camera.zoom + ((event as MouseEvent).delta / Math.abs ((event as MouseEvent).delta)))));
							}
							
							break;
						}
						default :
						{
							break;
						}
					}
				}
			}
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Render () : IRender
		{
			this.renderer.renderScene (this.scene, this.camera, this.viewport);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Update () : IUpdate
		{
			var touch:Object = this.touch [0];
			
			if (touch.down == false)
			{
				touch = this.touch [1];
			}
			
			this.camera.copyPosition (this.camera.extra.matrixIdentity);
			this.camera.transform.calculateMultiply (Matrix3D.multiply (this.camera.transform, Matrix3D.euler2matrix (touch.drag)), this.camera.extra.matrixPosition);
			
			touch.drag.multiplyEq ((1.0 - 0.68919022));
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
