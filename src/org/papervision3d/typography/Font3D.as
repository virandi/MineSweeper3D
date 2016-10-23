package org.papervision3d.typography {

	/**
	 * @author Mark Barcinski
	 */
	public class Font3D {
		public function get motifs():Object
		{
			//Override me
			return new Object();
		}
		
		public function get widths():Object
		{
			//Override me
			return new Object();
		}
		
		public function get height():Number
		{ 
			//Override me
			return -1;
		}
		
	}
}