package com.jason.utils
{
	public class ExchangeSort_BubbleSort
	{
		public function ExchangeSort_BubbleSort()
		{
		}
		
		public static function excute( arr:Array ):void
		{
			test( arr ) ;
		}
		
		private static function standard( arr:Array ):void
		{
			var len:int = arr.length;
			for (var i:int = 0; i < len; i++)
			{
				for (var j:int = i + 1; j < len; j++)
				{
					if ( arr[j] < arr[i] )
					{
						var t:* = arr[i];
						arr[i] = arr[j];
						arr[j] = t;
					}
				}
			}
		}
		
		private static function test( $arr:Array ):void
		{
			for (var i:int = 0, len:uint = $arr.length ; i < len ; i++ ) 
			{
				for (var j:int = i + 1; j < len; j++) 
				{
					if( $arr[ j ] < $arr[ i ] )
					{
						var tmp:* = $arr[ i ] ;
						$arr[ i ] = $arr[ j ] ;
						$arr[ j ] = tmp ;
					}
				}
			}
		}
	}
}