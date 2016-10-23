
package com.virandi.minesweeper3d.render.papervision3d
{
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.virandi.minesweeper3d.core.Cell;
	
	public class Cell3D extends DisplayObject3D
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const CACHE:Vector.<Cell3D> = new Vector.<Cell3D> ();
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public function get Instance () : Cell3D
		{
			((Cell3D.CACHE.length == 0) ? new Cell3D () : null);
			
			return Cell3D.CACHE.pop ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Cell3D ()
		{
			super (null, null);
			
			this.extra = {cell:null, face3D:new Vector.<Face3D>, size:0.0};
			
			Cell3D.CACHE.push (this);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Create (cell:Cell, size:Number) : Cell3D
		{
			var face3D:Face3D = null;
			
			var halfSize:Number = (size * 0.5);
			
			var i:int = 0;
			
			this.extra.cell = cell;
			this.extra.size = size;
			
			this.extra.face3D.length = 0;
			
			this.transform = Matrix3D.IDENTITY;
			
			for (i = 0; i != this.extra.cell.face.length; ++i)
			{
				if (this.extra.cell.face [i] == null)
				{
				}
				else
				{
					face3D = Face3D.Instance.Create (this.extra.cell.face [i], this.extra.size);
					
					switch (i)
					{
						case Cell.FACE_BACK :
						{
							face3D.moveBackward (halfSize);
							
							face3D.rotationY = 0.0;
							
							break;
						}
						case Cell.FACE_DOWN :
						{
							face3D.moveDown (halfSize);
							
							face3D.rotationX = -90.0;
							
							break;
						}
						case Cell.FACE_FRONT :
						{
							face3D.moveForward (halfSize);
							
							face3D.rotationY = 180.0;
							
							break;
						}
						case Cell.FACE_LEFT :
						{
							face3D.moveLeft (halfSize);
							
							face3D.rotationY = 90.0;
							
							break;
						}
						case Cell.FACE_RIGHT :
						{
							face3D.moveRight (halfSize);
							
							face3D.rotationY = -90.0;
							
							break;
						}
						case Cell.FACE_UP :
						{
							face3D.moveUp (halfSize);
							
							face3D.rotationX = 90.0;
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					this.extra.face3D.push (face3D);
					
					this.addChild (face3D, null);
				}
			}
			
			return this;
		}
		
		public function Destroy () : Cell3D
		{
			var face3D:Face3D = null;
			
			var i:int = 0;
			
			for each (face3D in this.extra.face3D)
			{
				this.removeChild (face3D.Destroy ());
			}
			
			if (this.parent == null)
			{
			}
			else
			{
				this.parent.removeChild (this);
			}
			
			this.transform = null;
			
			this.extra.face3D.length = 0;
			
			this.extra.size = 0.0;
			this.extra.cell = null;
			
			Cell3D.CACHE.push (this);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
