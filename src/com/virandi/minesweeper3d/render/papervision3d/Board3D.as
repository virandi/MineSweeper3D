
package com.virandi.minesweeper3d.render.papervision3d
{
	import flash.display.MovieClip;
	
	import org.papervision3d.core.math.Matrix3D;
	import org.papervision3d.materials.MovieMaterial;
	import org.papervision3d.objects.DisplayObject3D;
	
	import com.virandi.minesweeper3d.core.Board;
	import com.virandi.minesweeper3d.core.Cell;
	import com.virandi.minesweeper3d.core.Face;
	import com.virandi.minesweeper3d.core.Map;
	
	public class Board3D extends DisplayObject3D
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Board3D ()
		{
			super (null);
			
			this.extra = {board:new Board (), cell3D:new Vector.<Cell3D> ()};
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Clean () : Board3D
		{
			if (this.extra.board == null)
			{
			}
			else
			{
				this.extra.board.Clean ();
				
				this.Refresh ();
			}
			
			return this;
		}
		
		public function Create (map:Map) : Board3D
		{
			var cell:Cell = null;
			
			var cell3D:Cell3D = null;
			
			var i:int = 0;
			
			var offsetX:Number = 0.0;
			
			var offsetY:Number = 0.0;
			
			var offsetZ:Number = 0.0;
			
			var size:Number = 100.0;
			
			this.Destroy ();
			
			this.extra.board = this.extra.board.Create (map);
			
			this.transform = Matrix3D.IDENTITY;
			
			offsetX = ((this.extra.board.x - 1) * (size * 0.5));
			
			offsetY = ((this.extra.board.y - 1) * (size * 0.5));
			
			offsetZ = ((this.extra.board.z - 1) * (size * 0.5));
			
			for each (cell in this.extra.board.cell)
			{
				if (this.extra.board.Empty (cell) == false)
				{
					cell3D = Cell3D.Instance.Create (cell, size);
					
					cell3D.x = ((cell.x * cell3D.extra.size) - offsetX);
					cell3D.y = -((cell.y * cell3D.extra.size) - offsetY);
					cell3D.z = ((cell.z * cell3D.extra.size) - offsetZ);
					
					this.extra.cell3D.push (cell3D);
					
					this.addChild (cell3D, null);
				}
			}
			
			return this;
		}
		
		public function Destroy () : Board3D
		{
			var cell3D:Cell3D = null;
			
			for each (cell3D in this.extra.cell3D)
			{
				this.removeChild (cell3D.Destroy ());
			}
			
			this.extra.board = this.extra.board.Destroy ();
			
			this.extra.cell3D.length = 0;
			
			return this;
		}
		
		public function PickAllMine () : Board3D
		{
			if (this.extra.board == null)
			{
			}
			else
			{
				this.extra.board.PickAllMine ();
				
				this.Refresh ();
			}
			
			return this;
		}
		
		public function Refresh () : Board3D
		{
			var cell3D:Cell3D = null;
			
			var displayObject3D:DisplayObject3D = null;
			
			var face3D:Face3D = null;
			
			var frame:int = 0;
			
			for each (displayObject3D in this.children)
			{
				if (displayObject3D is Cell3D)
				{
					cell3D = (displayObject3D as Cell3D);
					
					for each (displayObject3D in cell3D.children)
					{
						if (displayObject3D is Face3D)
						{
							face3D = (displayObject3D as Face3D);
							
							switch (face3D.extra.face.state)
							{
								case Face.STATE_FLAG :
								{
									frame = 2;
									
									break;
								}
								case Face.STATE_NONE :
								{
									frame = 1;
									
									break;
								}
								case Face.STATE_PICK :
								{
									if (face3D.extra.face.value == Face.VALUE_X)
									{
										frame = ((face3D.material as MovieMaterial).movie as MovieClip).totalFrames;
									}
									else
									{
										frame = (face3D.extra.face.value + 3);
									}
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							((face3D.material as MovieMaterial).movie as MovieClip).gotoAndStop (frame, null);
							(face3D.material as MovieMaterial).drawBitmap ();
						}
					}
				}
			}
			
			return this;
		}
		
		public function Shuffle (difficulty:int, minimum:int) : Board3D
		{
			if (this.extra.board == null)
			{
			}
			else
			{
				this.extra.board.Shuffle (difficulty, minimum);
				
				this.Refresh ();
			}
			
			return this;
		}
		
		public function Touch (face3D:Face3D, tool:int) : Board3D
		{
			if ((face3D == null) || (this.extra.board == null))
			{
			}
			else
			{
				this.extra.board.Touch (face3D.extra.face, tool);
				
				this.Refresh ();
			}
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
