package starling.assets
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.IOErrorEvent;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import starling.textures.Texture;
   import starling.utils.execute;
   
   public class BitmapTextureFactory extends AssetFactory
   {
       
      
      public function BitmapTextureFactory()
      {
         super();
         addMimeTypes("image/png","image/jpg","image/jpeg","image/gif");
         addExtensions("png","jpg","jpeg","gif");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return param1.data is Bitmap || param1.data is BitmapData || super.canHandle(param1);
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
         reference = param1;
         helper = param2;
         onComplete = param3;
         onError = param4;
         onBitmapDataCreated = function(param1:BitmapData):void
         {
            helper.executeWhenContextReady(createFromBitmapData,param1);
         };
         createFromBitmapData = function(param1:BitmapData):void
         {
            bitmapData = param1;
            reference.textureOptions.onReady = function():void
            {
            };
            texture = Texture.fromData(bitmapData,reference.textureOptions);
            if(url)
            {
               texture.root.onRestore = function():void
               {
                  helper.onBeginRestore();
               };
            }
         };
         reload = function(param1:String, param2:Function):void
         {
            url = param1;
            onComplete = param2;
            helper.loadDataFromUrl(url,function(param1:ByteArray):void
            {
               createBitmapDataFromByteArray(param1,onComplete,onReloadError);
            },onReloadError);
         };
         onReloadError = function(param1:String):void
         {
            helper.log("Texture restoration failed for " + url + ". " + param1);
            helper.onEndRestore();
         };
         var url:String = reference.url;
         var data:Object = reference.data;
         if(data is Bitmap)
         {
            onBitmapDataCreated((data as Bitmap).bitmapData);
         }
         else if(data is BitmapData)
         {
            onBitmapDataCreated(data as BitmapData);
         }
         else if(data is ByteArray)
         {
            createBitmapDataFromByteArray(data as ByteArray,onBitmapDataCreated,onError);
         }
      }
      
      protected function createBitmapDataFromByteArray(param1:ByteArray, param2:Function, param3:Function) : void
      {
         data = param1;
         onComplete = param2;
         onError = param3;
         onIoError = function(param1:IOErrorEvent):void
         {
            cleanup();
            execute(onError,param1.text);
         };
         onLoaderComplete = function(param1:Object):void
         {
         };
         complete = function(param1:BitmapData):void
         {
            cleanup();
            execute(onComplete,param1);
         };
         cleanup = function():void
         {
            loaderInfo.removeEventListener("ioError",onIoError);
            loaderInfo.removeEventListener("complete",onLoaderComplete);
         };
         var loader:Loader = new Loader();
         var loaderInfo:LoaderInfo = loader.contentLoaderInfo;
         loaderInfo.addEventListener("ioError",onIoError);
         loaderInfo.addEventListener("complete",onLoaderComplete);
         var loaderContext:LoaderContext = new LoaderContext();
         loaderContext.imageDecodingPolicy = "onLoad";
         loader.loadBytes(data,loaderContext);
      }
   }
}
