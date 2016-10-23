
package com.virandi.minesweeper3d.core
{
	public class Cell
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const CACHE:Vector.<Cell> = new Vector.<Cell> ();
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const FACE_BACK:int = 0;
		
		static public const FACE_DOWN:int = 1;
		
		static public const FACE_FRONT:int = 2;
		
		static public const FACE_LEFT:int = 3;
		
		static public const FACE_RIGHT:int = 4;
		
		static public const FACE_UP:int = 5;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const NEIGHBOURHOOD_BACK:int = 0;
		
		static public const NEIGHBOURHOOD_BACK_DOWN:int = 1;
		
		static public const NEIGHBOURHOOD_BACK_DOWN_LEFT:int = 2;
		
		static public const NEIGHBOURHOOD_BACK_DOWN_RIGHT:int = 3;
		
		static public const NEIGHBOURHOOD_BACK_LEFT:int = 4;
		
		static public const NEIGHBOURHOOD_BACK_RIGHT:int = 5;
		
		static public const NEIGHBOURHOOD_BACK_UP:int = 6;
		
		static public const NEIGHBOURHOOD_BACK_UP_LEFT:int = 7;
		
		static public const NEIGHBOURHOOD_BACK_UP_RIGHT:int = 8;
		
		static public const NEIGHBOURHOOD_FRONT:int = 9;
		
		static public const NEIGHBOURHOOD_FRONT_DOWN:int = 10;
		
		static public const NEIGHBOURHOOD_FRONT_DOWN_LEFT:int = 11;
		
		static public const NEIGHBOURHOOD_FRONT_DOWN_RIGHT:int = 12;
		
		static public const NEIGHBOURHOOD_FRONT_LEFT:int = 13;
		
		static public const NEIGHBOURHOOD_FRONT_RIGHT:int = 14;
		
		static public const NEIGHBOURHOOD_FRONT_UP:int = 15;
		
		static public const NEIGHBOURHOOD_FRONT_UP_LEFT:int = 16;
		
		static public const NEIGHBOURHOOD_FRONT_UP_RIGHT:int = 17;
		
		static public const NEIGHBOURHOOD_MIDDLE_DOWN:int = 18;
		
		static public const NEIGHBOURHOOD_MIDDLE_DOWN_LEFT:int = 19;
		
		static public const NEIGHBOURHOOD_MIDDLE_DOWN_RIGHT:int = 20;
		
		static public const NEIGHBOURHOOD_MIDDLE_LEFT:int = 21;
		
		static public const NEIGHBOURHOOD_MIDDLE_RIGHT:int = 22;
		
		static public const NEIGHBOURHOOD_MIDDLE_UP:int = 23;
		
		static public const NEIGHBOURHOOD_MIDDLE_UP_LEFT:int = 24;
		
		static public const NEIGHBOURHOOD_MIDDLE_UP_RIGHT:int = 25;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const NEIGHBOURHOOD_ALL:Vector.<int> = new <int> [Cell.NEIGHBOURHOOD_BACK,
																		Cell.NEIGHBOURHOOD_BACK_DOWN,
																		Cell.NEIGHBOURHOOD_BACK_DOWN_LEFT,
																		Cell.NEIGHBOURHOOD_BACK_DOWN_RIGHT,
																		Cell.NEIGHBOURHOOD_BACK_LEFT,
																		Cell.NEIGHBOURHOOD_BACK_RIGHT,
																		Cell.NEIGHBOURHOOD_BACK_UP,
																		Cell.NEIGHBOURHOOD_BACK_UP_LEFT,
																		Cell.NEIGHBOURHOOD_BACK_UP_RIGHT,
																		Cell.NEIGHBOURHOOD_FRONT,
																		Cell.NEIGHBOURHOOD_FRONT_DOWN,
																		Cell.NEIGHBOURHOOD_FRONT_DOWN_LEFT,
																		Cell.NEIGHBOURHOOD_FRONT_DOWN_RIGHT,
																		Cell.NEIGHBOURHOOD_FRONT_LEFT,
																		Cell.NEIGHBOURHOOD_FRONT_RIGHT,
																		Cell.NEIGHBOURHOOD_FRONT_UP,
																		Cell.NEIGHBOURHOOD_FRONT_UP_LEFT,
																		Cell.NEIGHBOURHOOD_FRONT_UP_RIGHT,
																		Cell.NEIGHBOURHOOD_MIDDLE_DOWN,
																		Cell.NEIGHBOURHOOD_MIDDLE_DOWN_LEFT,
																		Cell.NEIGHBOURHOOD_MIDDLE_DOWN_RIGHT,
																		Cell.NEIGHBOURHOOD_MIDDLE_LEFT,
																		Cell.NEIGHBOURHOOD_MIDDLE_RIGHT,
																		Cell.NEIGHBOURHOOD_MIDDLE_UP,
																		Cell.NEIGHBOURHOOD_MIDDLE_UP_LEFT,
																		Cell.NEIGHBOURHOOD_MIDDLE_UP_RIGHT];
		
		static public const NEIGHBOURHOOD_SIX:Vector.<int> = new <int> [Cell.NEIGHBOURHOOD_BACK, Cell.NEIGHBOURHOOD_FRONT, Cell.NEIGHBOURHOOD_MIDDLE_DOWN, Cell.NEIGHBOURHOOD_MIDDLE_LEFT, Cell.NEIGHBOURHOOD_MIDDLE_RIGHT, Cell.NEIGHBOURHOOD_MIDDLE_UP];
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public function get Instance () : Cell
		{
			((Cell.CACHE.length == 0) ? new Cell () : null);
			
			return Cell.CACHE.pop ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var face:Vector.<Face> = null;
		
		public var neighbourhood:Vector.<Cell> = null;
		
		public var x:int = 0;
		
		public var y:int = 0;
		
		public var z:int = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Cell ()
		{
			super ();
			
			this.face = new Vector.<Face> ();
			
			this.neighbourhood = new Vector.<Cell> ();
			
			this.x = 0;
			
			this.y = 0;
			
			this.z = 0;
			
			Cell.CACHE.push (this);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Create (x:int, y:int, z:int) : Cell
		{
			this.face.length = 6;
			
			this.neighbourhood.length = 26;
			
			this.x = x;
			
			this.y = y;
			
			this.z = z;
			
			return this;
		}
		
		public function Destroy () : Cell
		{
			var face:Face = null;
			
			for each (face in this.face)
			{
				if (face == null)
				{
				}
				else
				{
					face.Destroy ();
				}
			}
			
			this.neighbourhood.length = 0;
			
			this.face.length = 0;
			
			this.z = 0;
			
			this.y = 0;
			
			this.x = 0;
			
			Cell.CACHE.push (this);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function toString () : String
		{
			return (this.x + " : " + this.y + " : " + this.z);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
