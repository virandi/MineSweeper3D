
package com.virandi.minesweeper3d.render.papervision3d
{
	import flash.display.MovieClip;
	
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	import org.papervision3d.objects.primitives.Plane;
	
	import com.virandi.minesweeper3d.core.Face;
	
	public class Face3D extends DisplayObject3D
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const CACHE:Vector.<Face3D> = new Vector.<Face3D> ();
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public function get Instance () : Face3D
		{
			((Face3D.CACHE.length == 0) ? new Face3D () : null);
			
			return Face3D.CACHE.pop ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Face3D ()
		{
			super (null, null);
			
			this.extra = {face:null};
			
			this.material = new MovieMaterial (Library.Instance.dictionary [Library.MC_TEXTURE_FACE3D], false, false, false, null);
			
			this.addChild (new Plane (this.material, 1.0, 1.0, 1.0, 1.0), null);
			
			Face3D.CACHE.push (this);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Create (face:Face, size:Number) : Face3D
		{
			this.extra.face = face;
			
			this.material.interactive = true;
			
			this.rotationX = this.rotationY = this.rotationZ = 0.0;
			
			this.scale = size;
			
			this.x = this.y = this.z = 0.0;
			
			((this.material as MovieMaterial).movie as MovieClip).gotoAndStop (1, null);
			(this.material as MovieMaterial).drawBitmap ();
			
			return this;
		}
		
		public function Destroy () : Face3D
		{
			if (this.parent == null)
			{
			}
			else
			{
				this.parent.removeChild (this);
			}
			
			this.scale = 1.0;
			
			this.material.interactive = false;
			
			this.extra.face = null;
			
			Face3D.CACHE.push (this);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
