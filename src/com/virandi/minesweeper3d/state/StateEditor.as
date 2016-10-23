
package com.virandi.minesweeper3d.state
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	
	import org.papervision3d.core.render.data.RenderHitData;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.materials.utils.MaterialsList;
	import org.papervision3d.objects.primitives.Cube;
	
	import com.virandi.base.CStateGUI;
	import com.virandi.base.IHandleEvent;
	import com.virandi.base.IRender;
	import com.virandi.base.IState;
	import com.virandi.base.IUpdate;
	import com.virandi.minesweeper3d.render.papervision3d.Cell3D;
	import com.virandi.minesweeper3d.render.papervision3d.Face3D;
	
	public class StateEditor extends CStateGUI
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:StateEditor = null;
		
		static public function get Instance () : StateEditor
		{
			return (StateEditor.instance = ((StateEditor.instance == null) ? new StateEditor () : StateEditor.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function StateEditor ()
		{
			super ();
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
			
			var cube:Cube = new Cube (new MaterialsList ({all:new MovieMaterial (Library.Instance.dictionary [Library.MC_TEXTURE_FACE3D], false, false, false, null)}), 100.0, 100.0, 100.0, 1, 1, 1, Cube.NONE, Cube.NONE);
			
			(cube.materials.materialsByName ["all"] as MovieMaterial).interactive = true;
			
			((cube.materials.materialsByName ["all"] as MovieMaterial).movie as MovieClip).gotoAndStop (1, null);
			(cube.materials.materialsByName ["all"] as MovieMaterial).updateBitmap ();
			
			Main.Instance.view3D.camera.zoom = Main.Instance.view3D.camera.extra.defaultZoom;
			Main.Instance.view3D.camera.extra.zoomAble = true;
			
			Main.Instance.view3D.scene.addChild (cube, null);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		override public function Pause (object:Object) : IState
		{
			super.Pause (object);
			
			return this;
		}
		
		override public function Resume () : IState
		{
			super.Resume ();
			
			return this;
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
						Main.Instance.view3D.viewport.interactive = true;
						{
							point = Main.Instance.view3D.viewport.containerSprite.globalToLocal (Main.Instance.view3D.touch [0].point);
							
							renderHitData = Main.Instance.view3D.viewport.hitTestPoint2D (point);
							
							if ((renderHitData == null) || (renderHitData.displayObject3D == null))
							{
							}
							else
							{
							}
						}
						Main.Instance.view3D.viewport.interactive = false;
						
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
			
			Main.Instance.view3D.Render ();
			
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
