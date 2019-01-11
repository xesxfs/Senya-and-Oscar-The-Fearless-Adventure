package starling.assets
{
   import flash.events.ErrorEvent;
   import flash.events.HTTPStatusEvent;
   import flash.events.ProgressEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import starling.utils.execute;
   
   public class DataLoader
   {
      
      private static const HTTP_RESPONSE_STATUS:String = "httpResponseStatus";
       
      
      private var _urlLoaders:Dictionary;
      
      public function DataLoader()
      {
         super();
         _urlLoaders = new Dictionary(true);
      }
      
      private static function getHttpHeader(param1:Array, param2:String) : String
      {
         if(param1)
         {
            var _loc5_:int = 0;
            var _loc4_:* = param1;
            for each(var _loc3_ in param1)
            {
               if(_loc3_.name == param2)
               {
                  return _loc3_.value;
               }
            }
         }
         return null;
      }
      
      public function load(param1:String, param2:Function, param3:Function, param4:Function = null) : void
      {
         url = param1;
         onComplete = param2;
         onError = param3;
         onProgress = param4;
         onHttpResponseStatus = function(param1:HTTPStatusEvent):void
         {
            httpStatus = param1.status;
            mimeType = getHttpHeader(param1["responseHeaders"],"Content-Type");
         };
         onLoadError = function(param1:ErrorEvent):void
         {
            cleanup();
            message = param1.type + " - " + param1.text;
            execute(onError,message);
         };
         onLoadProgress = function(param1:ProgressEvent):void
         {
            if(onProgress != null && param1.bytesTotal > 0)
            {
               onProgress(param1.bytesLoaded / param1.bytesTotal);
            }
         };
         onLoadComplete = function(param1:Object):void
         {
            cleanup();
            if(httpStatus < 400)
            {
               execute(onComplete,loader.data,mimeType);
            }
            else
            {
               execute(onError,"Unexpected HTTP status \'" + httpStatus + "\'. URL: " + request.url,httpStatus);
            }
         };
         cleanup = function():void
         {
            loader.removeEventListener("ioError",onLoadError);
            loader.removeEventListener("securityError",onLoadError);
            loader.removeEventListener("httpResponseStatus",onHttpResponseStatus);
            loader.removeEventListener("progress",onLoadProgress);
            loader.removeEventListener("complete",onLoadComplete);
         };
         var mimeType:String = null;
         var httpStatus:int = 0;
         var request:URLRequest = new URLRequest(url);
         var loader:URLLoader = new URLLoader();
         loader.dataFormat = "binary";
         loader.addEventListener("ioError",onLoadError);
         loader.addEventListener("securityError",onLoadError);
         loader.addEventListener("httpResponseStatus",onHttpResponseStatus);
         loader.addEventListener("progress",onLoadProgress);
         loader.addEventListener("complete",onLoadComplete);
         loader.load(request);
         _urlLoaders[loader] = true;
      }
      
      public function close() : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = _urlLoaders;
         for(var _loc1_ in _urlLoaders)
         {
            try
            {
               _loc1_.close();
            }
            catch(e:Error)
            {
               continue;
            }
         }
         _urlLoaders = new Dictionary(true);
      }
   }
}
