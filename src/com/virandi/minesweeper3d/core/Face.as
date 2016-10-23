
package com.virandi.minesweeper3d.core
{
	public class Face
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const CACHE:Vector.<Face> = new Vector.<Face> ();
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const STATE_FLAG:int = 0;
		
		static public const STATE_NONE:int = 1;
		
		static public const STATE_PICK:int = 2;
		
		static public const VALUE_0:int = 0;
		
		static public const VALUE_X:int = int.MAX_VALUE;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public function get Instance () : Face
		{
			((Face.CACHE.length == 0) ? new Face () : null);
			
			return Face.CACHE.pop ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var cell:Cell = null;
		
		public var connect:Vector.<Face> = null;
		
		public var state:int = 0;
		
		public var value:int = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Face ()
		{
			super ();
			
			this.cell = null;
			
			this.connect = new Vector.<Face> ();
			
			this.state = Face.STATE_NONE;
			
			this.value = Face.VALUE_0;
			
			Face.CACHE.push (this);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Create (cell:Cell) : Face
		{
			this.cell = cell;
			
			this.connect = this.connect;
			
			this.state = Face.STATE_NONE;
			
			this.value = Face.VALUE_0;
			
			this.connect.length = 0;
			
			return this;
		}
		
		public function Destroy () : Face
		{
			this.connect.length = 0;
			
			this.value = Face.VALUE_0;
			
			this.state = Face.STATE_NONE;
			
			this.connect = this.connect;
			
			this.cell = null;
			
			Face.CACHE.push (this);
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function toString () : String
		{
			return this.value.toString ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
