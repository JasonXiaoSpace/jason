package ghostcat.display.loader
{
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * 此方法加载的图片将无视沙箱 
	 * @author flashyiyi
	 * 
	 */
	public class ImageLoader extends Loader
	{
		public static var enabledCache:Boolean = true;
		private static var caches:Dictionary = new Dictionary();
		
		private var loader:Loader;
		public function get imageLoadInfo():LoaderInfo
		{
			return loader ? loader.contentLoaderInfo : null;
		}
		
		public function ImageLoader()
		{
			super();	
		}
		
		public override function load(request:URLRequest, context:LoaderContext=null):void
		{
			if (caches[request.url])
			{
				loadBytes(caches[request.url]);
				this.contentLoaderInfo.addEventListener( Event.COMPLETE,loadBytesCompleteHandler);
				this.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler ) ;
				this.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler ) ;
				this.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler ) ;
			}
			else
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, loadCompleteHandler);
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler);
				loader.contentLoaderInfo.addEventListener( ProgressEvent.PROGRESS, progressHandler);
				loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler ) ;
				loader.load(request, context);
			}
		}
		
		private function removeHandler():void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadCompleteHandler);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,progressHandler);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler ) ;
			loader = null;
		}
		
		private function loadCompleteHandler(event:Event):void
		{
			removeHandler();
			
			var info:LoaderInfo = event.currentTarget as LoaderInfo;
			try
			{
				if (enabledCache)
					caches[info.url] = info.bytes;
				
				this.loadBytes(info.bytes);
				this.contentLoaderInfo.addEventListener(Event.COMPLETE,loadBytesCompleteHandler);
			}
			catch(error:Error) 
			{
				loadBytesCompleteHandler(new Event(Event.COMPLETE));
			}
		}
		
		private function loadBytesCompleteHandler(event:Event):void
		{
			this.contentLoaderInfo.removeEventListener(Event.COMPLETE,loadBytesCompleteHandler);
			this.dispatchEvent(event);
		}
		
		private function ioErrorHandler(event:IOErrorEvent):void
		{
			removeHandler();
			this.dispatchEvent(event);
		}
		
		private function progressHandler(event:ProgressEvent):void
		{
			this.dispatchEvent(event);
		}
		
		private function securityErrorHandler( $evt:SecurityErrorEvent ):void
		{
			this.dispatchEvent( $evt ) ;
		}
	}
}