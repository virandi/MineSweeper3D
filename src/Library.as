
package
{
	import flash.media.Sound;
	import flash.utils.Dictionary;
	
	[Frame (factoryClass = "Main")]
	public class Library
	{
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_BACKGROUND")]
		static public const MC_BACKGROUND:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_CREDITS")]
		static public const MC_GUI_STATE_CREDITS:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_END_GAME")]
		static public const MC_GUI_STATE_END_GAME:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_HOW_TO_PLAY")]
		static public const MC_GUI_STATE_HOW_TO_PLAY:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_INTRO")]
		static public const MC_GUI_STATE_INTRO:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_MENU")]
		static public const MC_GUI_STATE_MENU:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_PAUSE_GAME")]
		static public const MC_GUI_STATE_PAUSE_GAME:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_PLAY_GAME")]
		static public const MC_GUI_STATE_PLAY_GAME:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_GUI_STATE_SELECT_MAP")]
		static public const MC_GUI_STATE_SELECT_MAP:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MC_TEXTURE_FACE3D")]
		static public const MC_TEXTURE_FACE3D:Class;
		
		[Embed (source = "library/LIBRARY_MINESWEEPER3D.swf", symbol = "MP3_MONKEY_ISLAND_BAND")]
		static public const MP3_MONKEY_ISLAND_BAND:Class;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		static public var instance:Library = null;
		
		static public function get Instance () : Library
		{
			return (Library.instance = ((Library.instance == null) ? new Library () : Library.instance));
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public var dictionary:Dictionary = null;
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
		
		public function Library ()
		{
			super ();
			
			this.dictionary = new Dictionary (false);
			
			this.dictionary [Library.MC_BACKGROUND] = new Library.MC_BACKGROUND ();
			this.dictionary [Library.MC_GUI_STATE_CREDITS] = new Library.MC_GUI_STATE_CREDITS ();
			this.dictionary [Library.MC_GUI_STATE_END_GAME] = new Library.MC_GUI_STATE_END_GAME ();
			this.dictionary [Library.MC_GUI_STATE_HOW_TO_PLAY] = new Library.MC_GUI_STATE_HOW_TO_PLAY ();
			this.dictionary [Library.MC_GUI_STATE_INTRO] = new Library.MC_GUI_STATE_INTRO ();
			this.dictionary [Library.MC_GUI_STATE_MENU] = new Library.MC_GUI_STATE_MENU ();
			this.dictionary [Library.MC_GUI_STATE_PAUSE_GAME] = new Library.MC_GUI_STATE_PAUSE_GAME ();
			this.dictionary [Library.MC_GUI_STATE_PLAY_GAME] = new Library.MC_GUI_STATE_PLAY_GAME ();
			this.dictionary [Library.MC_GUI_STATE_SELECT_MAP] = new Library.MC_GUI_STATE_SELECT_MAP ();
			this.dictionary [Library.MC_TEXTURE_FACE3D] = new Library.MC_TEXTURE_FACE3D ();
			this.dictionary [Library.MP3_MONKEY_ISLAND_BAND] = new Library.MP3_MONKEY_ISLAND_BAND ();
			
			this.dictionary [Library.MC_BACKGROUND].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_CREDITS].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_END_GAME].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_HOW_TO_PLAY].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_INTRO].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_MENU].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_PAUSE_GAME].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_PLAY_GAME].cacheAsBitmap = true;
			this.dictionary [Library.MC_GUI_STATE_SELECT_MAP].cacheAsBitmap = true;
			this.dictionary [Library.MC_TEXTURE_FACE3D].cacheAsBitmap = true;
		}
		
		////////////////////////////////////////////////////////////////////////////////////////////////////
	}
}
