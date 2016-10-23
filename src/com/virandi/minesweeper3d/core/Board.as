
package com.virandi.minesweeper3d.core
{
	import flash.utils.getTimer;
	
	import com.virandi.base.CMath;
	
	public class Board
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const DIFFICULTY_HARD:int = 0;
		
		static public const DIFFICULTY_NONE:int = 1;
		
		static public const DIFFICULTY_NOOB:int = 2;
		
		static public const DIFFICULTY_NORMAL:int = 3;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public const TOOL_FLAG:int = 0;
		
		static public const TOOL_NONE:int = 1;
		
		static public const TOOL_PICK:int = 2;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var bit:Vector.<int> = null;
		
		public var boom:Boolean = false;
		
		public var cell:Vector.<Cell> = null;
		
		public var face:Vector.<Face> = null;
		
		public var map:Map = null;
		
		public var mine:int = 0;
		
		public var mined:int = 0;
		
		public var pick:int = 0;
		
		public var virgin:Boolean = false;
		
		public var x:int = 0;
		
		public var y:int = 0;
		
		public var z:int = 0;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Board ()
		{
			super ();
			
			this.bit = new Vector.<int> ();
			
			this.boom = false;
			
			this.cell = new Vector.<Cell> ();
			
			this.face = new Vector.<Face> ();
			
			this.map = null;
			
			this.mine = 0;
			
			this.mined = 0;
			
			this.pick = 0;
			
			this.virgin = true;
			
			this.x = 0;
			
			this.y = 0;
			
			this.z = 0;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Clean () : Board
		{
			this.UnPickAll ().UnPlantAll ();
			
			return this;
		}
		
		public function Create (map:Map) : Board
		{
			var cell:Cell = null;
			
			var i:int = 0;
			
			var j:int = 0;
			
			var k:int = 0;
			
			var x:int = 0;
			
			var y:int = 0;
			
			var z:int = 0;
			
			this.Destroy ();
			
			this.boom = false;
			
			this.map = ((map == null) ? Map.Instance.Create ({BIT:null, X:3, Y:3, Z:3}) : map);
			
			this.mined = 0;
			
			this.mine = 0;
			
			this.pick = 0;
			
			this.virgin = true;
			
			this.x = (this.map.x + 2);
			
			this.y = (this.map.y + 2);
			
			this.z = (this.map.z + 2);
			
			for (i = 0, j = 0, k = 0, z = 0; z != this.z; ++z)
			{
				for (y = 0; y != this.y; ++y)
				{
					for (x = 0; x != this.x; ++i, ++x)
					{
						cell = Cell.Instance.Create (x, y, z);
						
						j = 0;
						
						if (((x > 0) && (x < (this.x - 1))) && ((y > 0) && (y < (this.y - 1))) && ((z > 0) && (z < (this.z - 1))))
						{
							if (this.map.bit is String)
							{
								j = int (this.map.bit.charAt (k));
								
								k = (k + 1);
							}
							else
							{
								j = int (Math.random () < 0.5);
							}
						}
						
						this.bit [i] = j;
						
						this.cell [i] = cell;
					}
				}
			}
			
			this.Refresh ();
			
			return this;
		}
		
		public function Destroy () : Board
		{
			var cell:Cell = null;
			
			for each (cell in this.cell)
			{
				cell.Destroy ();
			}
			
			this.face.length = 0;
			
			this.cell.length = 0;
			
			this.bit.length = 0;
			
			this.z = 0;
			
			this.y = 0;
			
			this.x = 0;
			
			this.virgin = false;
			
			this.pick = 0;
			
			this.mine = 0;
			
			this.mined = 0;
			
			this.map = null;
			
			this.boom = false;
			
			return this;
		}
		
		public function Empty (cell:Cell) : Object
		{
			var i:int = this.cell.indexOf (cell, 0);
			
			return ((cell == null) ? null : ((this.bit [i] == 0) ? true : false));
		}
		
		public function Flag (face:Face) : Board
		{
			if (face == null)
			{
			}
			else
			{
				if (face.state == Face.STATE_NONE)
				{
					face.state = Face.STATE_FLAG;
					
					this.virgin = false;
				}
			}
			
			return this;
		}
		
		public function Pick (face:Face) : Board
		{
			var flag:Boolean = false;
			
			var i:int = 0;
			
			if (face == null)
			{
			}
			else
			{
				if (face.state == Face.STATE_NONE)
				{
					face.state = Face.STATE_PICK;
					
					switch (face.value)
					{
						case Face.VALUE_0 :
						{
							for (i = 0; i != face.connect.length; ++i)
							{
								if (face.connect [i].value == Face.VALUE_X)
								{
								}
								else
								{
									this.Pick (face.connect [i]);
								}
							}
							
							break;
						}
						case Face.VALUE_X :
						{
							for (i = 0; i != this.face.length; ++i)
							{
								if ((this.face [i] == null) || (this.face [i] == face))
								{
								}
								else
								{
									if (this.face [i].state == Face.STATE_PICK)
									{
										flag = true;
										
										break;
									}
								}
							}
							
							if (flag == false)
							{
								for (i = 0; i != this.face.length; ++i)
								{
									if ((this.face [i] == null) || (this.face [i] == face))
									{
									}
									else
									{
										if (this.face [i].state == Face.STATE_PICK)
										{
										}
										else
										{
											if (this.face [i].value == Face.VALUE_X)
											{
											}
											else
											{
												this.Plant (this.face [i]);
												
												break;
											}
										}
									}
								}
								
								this.UnPlant (face).UnPick (face).Pick (face);
							}
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					switch (face.value)
					{
						case Face.VALUE_X :
						{
							this.boom = true;
							
							this.mined = (this.mined + 1);
							
							break;
						}
						default :
						{
							this.boom = false;
							
							this.pick = (this.pick + 1);
							
							break;
						}
					}
					
					this.virgin = false;
				}
			}
			
			return this;
		}
		
		public function PickAllMine () : Board
		{
			var face:Face = null;
			
			for each (face in this.face)
			{
				if (face.state == Face.STATE_PICK)
				{
				}
				else
				{
					if (face.value == Face.VALUE_X)
					{
						this.UnFlag (face).Pick (face);
					}
				}
			}
			
			return this;
		}
		
		public function Plant (face:Face) : Board
		{
			var i:int = 0;
			
			if ((face == null) || (face.value == Face.VALUE_X))
			{
			}
			else
			{
				face.value = Face.VALUE_X;
				
				for (i = 0; i != face.connect.length; ++i)
				{
					if (face.connect [i].value == Face.VALUE_X)
					{
					}
					else
					{
						face.connect [i].value = (face.connect [i].value + 1);
					}
				}
				
				this.mine = (this.mine + 1);
			}
			
			return this;
		}
		
		public function PlantAt (face:int, x:int, y:int, z:int) : Board
		{
			var i:int = ((z * (this.y * this.x)) + (y * this.x) + x);
			
			return this.Plant (this.cell [i].face [face]);
		}
		
		public function Refresh () : Board
		{
			var cell:Cell = null;
			
			var face:Face = null;
			
			var flag:Boolean = false;
			
			var i:int = 0;
			
			var j:int = 0;
			
			var k:int = 0;
			
			var l:int = 0;
			
			var m:int = 0;
			
			var n:int = 0;
			
			var path:Vector.<Cell> = new Vector.<Cell> ();
			
			var timer:int = 0;
			
			var x:int = 0;
			
			var y:int = 0;
			
			var z:int = 0;
			
			timer = getTimer ();
			
			this.face.length = 0;
			
			for each (cell in this.cell)
			{
				for (i = 0; i != cell.face.length; ++i)
				{
					face = cell.face [i];
					
					if (face == null)
					{
					}
					else
					{
						face.Destroy ();
					}
					
					cell.face [i] = null;
				}
				
				for (i = 0; i != cell.neighbourhood.length; ++i)
				{
					cell.neighbourhood [i] = null;
				}
			}
			
			i = 0;
			
			for each (cell in this.cell)
			{
				x = cell.x;
				y = cell.y;
				z = cell.z;
				
				if (x > 0)
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT] = this.cell [(i - 1)];
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT] = cell;
					}
				}
				
				if (y > 0)
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP] = this.cell [(i - this.x)];
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN] = cell;
					}
				}
				
				if (z > 0)
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK] = this.cell [(i - (this.y * this.x))];
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK].neighbourhood [Cell.NEIGHBOURHOOD_FRONT] = cell;
					}
				}
				
				++i;
			}
			
			for each (cell in this.cell)
			{
				if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK]) == null)
				{
				}
				else
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP];
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
						cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					}
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
						cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_BACK_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					}
				}
				
				if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT]) == null)
				{
				}
				else
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP];
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
						cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					}
					
					if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP]) == null)
					{
					}
					else
					{
						cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
						cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_FRONT_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
					}
				}
				
				if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN]) == null)
				{
				}
				else
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_DOWN].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
				}
				
				if (this.Empty (cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP]) == null)
				{
				}
				else
				{
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP_LEFT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_LEFT];
					cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP_RIGHT] = cell.neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_UP].neighbourhood [Cell.NEIGHBOURHOOD_MIDDLE_RIGHT];
				}
			}
			
			path.push (this.cell [0]);
			
			for (i = 0; i != path.length; ++i)
			{
				cell = path [i];
				
				for each (j in Cell.NEIGHBOURHOOD_SIX)
				{
					switch (this.Empty (cell.neighbourhood [j]))
					{
						case false :
						{
							switch (j)
							{
								case Cell.NEIGHBOURHOOD_BACK :
								{
									k = Cell.FACE_FRONT;
									
									break;
								}
								case Cell.NEIGHBOURHOOD_FRONT :
								{
									k = Cell.FACE_BACK;
									
									break;
								}
								case Cell.NEIGHBOURHOOD_MIDDLE_DOWN :
								{
									k = Cell.FACE_UP;
									
									break;
								}
								case Cell.NEIGHBOURHOOD_MIDDLE_LEFT :
								{
									k = Cell.FACE_RIGHT;
									
									break;
								}
								case Cell.NEIGHBOURHOOD_MIDDLE_RIGHT :
								{
									k = Cell.FACE_LEFT;
									
									break;
								}
								case Cell.NEIGHBOURHOOD_MIDDLE_UP :
								{
									k = Cell.FACE_DOWN;
									
									break;
								}
								default :
								{
									break;
								}
							}
							
							cell.neighbourhood [j].face [k] = Face.Instance.Create (cell.neighbourhood [j]);
							
							this.face.push (cell.neighbourhood [j].face [k]);
							
							break;
						}
						case null :
						{
							break;
						}
						case true :
						{
							if (path.indexOf (cell.neighbourhood [j], 0) == -1)
							{
								path.push (cell.neighbourhood [j]);
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
			
			for each (cell in this.cell)
			{
				if (this.Empty (cell) == false)
				{
					for each (i in Cell.NEIGHBOURHOOD_SIX)
					{
						if (this.Empty (cell.neighbourhood [i]) == true)
						{
							for each (j in Cell.NEIGHBOURHOOD_ALL)
							{
								if (this.Empty (cell.neighbourhood [i].neighbourhood [j]) == false)
								{
									if (cell == cell.neighbourhood [i].neighbourhood [j])
									{
									}
									else
									{
										if (cell.neighbourhood.indexOf (cell.neighbourhood [i].neighbourhood [j], 0) == -1)
										{
											continue;
										}
									}
									
									for each (k in Cell.NEIGHBOURHOOD_SIX)
									{
										if (this.Empty (cell.neighbourhood [i].neighbourhood [j].neighbourhood [k]) == true)
										{
											flag = false;
											
											if (cell.neighbourhood [i] == cell.neighbourhood [i].neighbourhood [j].neighbourhood [k])
											{
												flag = true;
											}
											else
											{
												path.length = 0;
												
												path.push (cell.neighbourhood [i]);
												
												for (l = 0; l != path.length; ++l)
												{
													for each (m in Cell.NEIGHBOURHOOD_SIX)
													{
														if (this.Empty (path [l].neighbourhood [m]) == true)
														{
															if ((cell.neighbourhood.indexOf (path [l].neighbourhood [m], 0) == -1) ||
																(cell.neighbourhood [i].neighbourhood.indexOf (path [l].neighbourhood [m], 0) == -1) ||
																(cell.neighbourhood [i].neighbourhood [j].neighbourhood.indexOf (path [l].neighbourhood [m], 0) == -1))
															{
															}
															else
															{
																if (path [l].neighbourhood [m] == cell.neighbourhood [i].neighbourhood [j].neighbourhood [k])
																{
																	flag = true;
																	
																	l = (path.length - 1);
																	
																	break;
																}
																else
																{
																	if (path.indexOf (path [l].neighbourhood [m], 0) == -1)
																	{
																		path.push (path [l].neighbourhood [m]);
																	}
																}
															}
														}
													}
												}
											}
											
											if (flag == false)
											{
											}
											else
											{
												switch (i)
												{
													case Cell.NEIGHBOURHOOD_BACK :
													{
														m = Cell.FACE_BACK;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_FRONT :
													{
														m = Cell.FACE_FRONT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_DOWN :
													{
														m = Cell.FACE_DOWN;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_LEFT :
													{
														m = Cell.FACE_LEFT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_RIGHT :
													{
														m = Cell.FACE_RIGHT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_UP :
													{
														m = Cell.FACE_UP;
														
														break;
													}
													default :
													{
														break;
													}
												}
												
												switch (k)
												{
													case Cell.NEIGHBOURHOOD_BACK :
													{
														n = Cell.FACE_BACK;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_FRONT :
													{
														n = Cell.FACE_FRONT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_DOWN :
													{
														n = Cell.FACE_DOWN;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_LEFT :
													{
														n = Cell.FACE_LEFT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_RIGHT :
													{
														n = Cell.FACE_RIGHT;
														
														break;
													}
													case Cell.NEIGHBOURHOOD_MIDDLE_UP :
													{
														n = Cell.FACE_UP;
														
														break;
													}
													default :
													{
														break;
													}
												}
												
												if (cell.face [m] == cell.neighbourhood [i].neighbourhood [j].face [n])
												{
												}
												else
												{
													cell.face [m].connect.push (cell.neighbourhood [i].neighbourhood [j].face [n]);
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			
			trace ("refresh time.. ", ((getTimer () - timer) / 1000.0), "second..");
			
			return this;
		}
		
		public function Shuffle (difficulty:int, minimum:int) : Board
		{
			var face:Face = null;
			
			var i:int = 0;
			
			var j:int = 0;
			
			var open:Array = null;
			
			this.Clean ();
			
			switch (difficulty)
			{
				case Board.DIFFICULTY_NONE :
				{
					break;
				}
				default :
				{
					open = new Array ();
					
					for each (face in this.face)
					{
						if (face == null)
						{
						}
						else
						{
							open.push (face);
						}
					}
					
					switch (difficulty)
					{
						case Board.DIFFICULTY_HARD :
						{
							i = 3;
							
							j = 12;
							
							break;
						}
						case Board.DIFFICULTY_NOOB :
						{
							i = 1;
							
							j = 6;
							
							break;
						}
						case Board.DIFFICULTY_NONE :
						{
							i = 0;
							
							j = 1;
							
							break;
						}
						case Board.DIFFICULTY_NORMAL :
						{
							i = 2;
							
							j = 9;
							
							break;
						}
						default :
						{
							break;
						}
					}
					
					i = Math.max (minimum, (i * (open.length / j)));
					
					trace (open.length, "field..", i, "mined field..");
					
					trace ("random on non-mined field which have less mined-field around it..");
					
					for (; i != 0; --i)
					{
						for (j = open.sortOn ("value", Array.NUMERIC).length; j != 0; )
						{
							if (open [--j].value == open [0].value)
							{
								break;
							}
						}
						
						face = open [CMath.Random (0, j)];
						
						this.Plant (face);
					}
					
					break;
				}
			}
			
			return this;
		}
		
		public function Touch (face:Face, tool:int) : Board
		{
			if (face == null)
			{
			}
			else
			{
				switch (face.state)
				{
					case Face.STATE_FLAG :
					{
						switch (tool)
						{
							case Board.TOOL_FLAG :
							{
								this.UnFlag (face);
								
								break;
							}
							default :
							{
								break;
							}
						}
						
						break;
					}
					case Face.STATE_NONE :
					{
						switch (tool)
						{
							case Board.TOOL_FLAG :
							{
								this.Flag (face);
								
								break;
							}
							case Board.TOOL_PICK :
							{
								this.Pick (face);
								
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
			
			return this;
		}
		
		public function UnFlag (face:Face) : Board
		{
			if (face == null)
			{
			}
			else
			{
				if (face.state == Face.STATE_FLAG)
				{
					face.state = Face.STATE_NONE;
				}
			}
			
			return this;
		}
		
		public function UnPick (face:Face) : Board
		{
			if (face == null)
			{
			}
			else
			{
				if (face.state == Face.STATE_PICK)
				{
					face.state = Face.STATE_NONE;
					
					switch (face.value)
					{
						case Face.VALUE_X :
						{
							break;
						}
						default :
						{
							this.pick = (this.pick - 1);
							
							break;
						}
					}
				}
			}
			
			return this;
		}
		
		public function UnPickAll () : Board
		{
			var face:Face = null;
			
			for each (face in this.face)
			{
				this.UnPick (face);
			}
			
			return this;
		}
		
		public function UnPlant (face:Face) : Board
		{
			var i:int = 0;
			
			if (face == null)
			{
			}
			else
			{
				if (face.value == Face.VALUE_X)
				{
					face.value = Face.VALUE_0;
					
					for (i = 0; i != face.connect.length; ++i)
					{
						if (face.connect [i].value == Face.VALUE_X)
						{
							face.value = (face.value + 1);
						}
						else
						{
							face.connect [i].value = (face.connect [i].value - 1);
						}
					}
					
					this.mine = (this.mine - 1);
				}
			}
			
			return this;
		}
		
		public function UnPlantAll () : Board
		{
			var face:Face = null;
			
			for each (face in this.face)
			{
				this.UnPlant (face);
			}
			
			return this;
		}
		
		public function UnPlantAt (face:int, x:int, y:int, z:int) : Board
		{
			var i:int = ((z * (this.y * this.x)) + (y * this.x) + x);
			
			return this.UnPlant (this.cell [i].face [face]);
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
