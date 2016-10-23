
package
{
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLStatement;
	import flash.filesystem.File;
	
	public class DB
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:DB = null;
		
		static public function get Instance () : DB
		{
			return (DB.instance = ((DB.instance == null) ? new DB () : DB.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public const CACHE_DIFFICULTY:Vector.<Object> = new Vector.<Object> ();
		
		public const CACHE_MAP:Vector.<Object> = new Vector.<Object> ();
		
		public const CACHE_RECORD:Vector.<Object> = new Vector.<Object> ();
		
		public const FILE:File = File.applicationStorageDirectory.resolvePath ("DB_MINESWEEPER3D.db");
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var sqlConnection:SQLConnection = null;
		
		public var sqlStatement:SQLStatement = null;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DB ()
		{
			super ();
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function DeInitialize () : DB
		{
			this.sqlConnection.close (null);
			
			this.sqlStatement.sqlConnection = null;
			
			this.sqlStatement = null;
			
			this.sqlConnection = null;
			
			return this;
		}
		
		public function Initialize () : DB
		{
			this.sqlConnection = ((this.sqlConnection == null) ? new SQLConnection () : this.sqlConnection);
			
			this.sqlStatement = ((this.sqlStatement == null) ? new SQLStatement () : this.sqlStatement);
			
			this.sqlStatement.sqlConnection = this.sqlConnection;
			
			for (; this.sqlConnection.connected == false; )
			{
				this.sqlConnection.open (this.FILE, SQLMode.CREATE, false, 1024, null);
			}
			
			this.Execute ("CREATE TABLE IF NOT EXISTS T_DIFFICULTY (LEVEL TEXT PRIMARY KEY NOT NULL);");
			this.Execute ("CREATE TABLE IF NOT EXISTS T_MAP (BIT TEXT PRIMARY KEY NOT NULL, X INTEGER NOT NULL, Y INTEGER NOT NULL, Z INTERGER NOT NULL);");
			this.Execute ("CREATE TABLE IF NOT EXISTS T_RECORD (DIFFICULTY_LEVEL TEXT NOT NULL, MAP_BIT TEXT NOT NULL, TICK INTEGER NOT NULL);");
			
			this.Execute ("INSERT INTO T_DIFFICULTY (LEVEL) VALUES ('HARD');");
			this.Execute ("INSERT INTO T_DIFFICULTY (LEVEL) VALUES ('NONE');");
			this.Execute ("INSERT INTO T_DIFFICULTY (LEVEL) VALUES ('NOOB');");
			this.Execute ("INSERT INTO T_DIFFICULTY (LEVEL) VALUES ('NORMAL');");
			
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('111111111111111111111111111', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('100100111100100111111111111', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('000111000010111010000111000', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('000000000111111111000000000', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('000010000010111010000010000', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('001010100001010100001010100', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('111101111101000101111101111', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('101010101010111010101010101', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('010111010111111111010111010', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('010111010010111010010111010', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('011010110011010110011010110', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('111100100001000100001001111', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('111100111001000001111100111', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('000000000000010000000000000', 3, 3, 3);");
			this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('101000101000000000101000101', 3, 3, 3);");
			//this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES ('101111101000101000101111101', 3, 3, 3);");
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Cache () : DB
		{
			var data:Object = null;
			
			this.Initialize ();
			
			this.Execute ("SELECT * FROM T_DIFFICULTY ORDER BY LEVEL ASC;");
			
			for each (data in this.sqlStatement.getResult ().data)
			{
				this.CACHE_DIFFICULTY.push (data);
			}
			
			this.Execute ("SELECT * FROM T_MAP;");
			
			for each (data in this.sqlStatement.getResult ().data)
			{
				this.CACHE_MAP.push (data);
			}
			
			this.Execute ("SELECT * FROM T_RECORD;");
			
			for each (data in this.sqlStatement.getResult ().data)
			{
				this.CACHE_RECORD.push (data);
			}
			
			trace (this.FILE.nativePath);
			
			return this;
		}
		
		public function Execute (string:String) : DB
		{
			try
			{
				this.sqlStatement.sqlConnection = this.sqlConnection;
				this.sqlStatement.text = string;
				
				this.sqlStatement.execute (-1, null);
			}
			catch (error:Error)
			{
				trace (error);
			}
			
			return this;
		}
		
		public function Flush () : DB
		{
			var data:Object = null;
			
			this.sqlStatement.clearParameters ();
			{
				this.Execute ("DELETE FROM T_MAP");
				
				for each (data in this.CACHE_MAP)
				{
					this.sqlStatement.parameters [":BIT"] = data.BIT;
					this.sqlStatement.parameters [":X"] = data.X;
					this.sqlStatement.parameters [":Y"] = data.Y;
					this.sqlStatement.parameters [":Z"] = data.Z;
					
					this.Execute ("INSERT INTO T_MAP (BIT, X, Y, Z) VALUES (:BIT, :X, :Y, :Z)");
				}
			}
			this.sqlStatement.clearParameters ();
			
			this.sqlStatement.clearParameters ();
			{
				this.Execute ("DELETE FROM T_RECORD");
				
				for each (data in this.CACHE_RECORD)
				{
					this.sqlStatement.parameters [":DIFFICULTY_LEVEL"] = data.DIFFICULTY_LEVEL;
					this.sqlStatement.parameters [":MAP_BIT"] = data.MAP_BIT;
					this.sqlStatement.parameters [":TICK"] = data.TICK;
					
					this.Execute ("INSERT INTO T_RECORD (DIFFICULTY_LEVEL, MAP_BIT, TICK) VALUES (:DIFFICULTY_LEVEL, :MAP_BIT, :TICK);");
				}
			}
			this.sqlStatement.clearParameters ();
			
			return this;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
