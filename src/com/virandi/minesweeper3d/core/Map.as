
package com.virandi.minesweeper3d.core
{
	public class Map
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:Map = null;
		
		static public function get Instance () : Map
		{
			return (Map.instance = ((Map.instance == null) ? new Map () : Map.instance)).Destroy ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var bit:String = null;
		
		public var x:int = 0;
		
		public var y:int = 0;
		
		public var z:int = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Map ()
		{
			super ();
			
			this.bit = null;
			
			this.x = 0;
			this.y = 0;
			this.z = 0;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Create (object:Object) : Map
		{
			this.bit = object.BIT;
			
			this.x = object.X;
			this.y = object.Y;
			this.z = object.Z;
			
			return this;
		}
		
		public function Destroy () : Map
		{
			this.z = 0;
			this.y = 0;
			this.x = 0;
			
			this.bit = null;
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
