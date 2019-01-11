package starling.assets
{
   import flash.utils.ByteArray;
   import starling.textures.AtfData;
   import starling.textures.Texture;
   
   public class AtfTextureFactory extends AssetFactory
   {
       
      
      public function AtfTextureFactory()
      {
         super();
         addExtensions("atf");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return param1.data is ByteArray && AtfData.isAtfData(param1.data as ByteArray);
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
         reference = param1;
         helper = param2;
         onComplete = param3;
         onError = param4;
         createTexture = function():void
         {
            reference.textureOptions.onReady = function():void
            {
            };
            var texture:Texture = Texture.fromData(reference.data,reference.textureOptions);
            var url:String = reference.url;
            if(url)
            {
               texture.root.onRestore = function():void
               {
                  helper.onBeginRestore();
                  helper.loadDataFromUrl(url,function(param1:ByteArray):void
                  {
                     data = param1;
                     helper.executeWhenContextReady(function():void
                     {
                        texture.root.uploadAtfData(data);
                        helper.onEndRestore();
                     });
                  },onReloadError);
               };
            }
         };
         onReloadError = function(param1:String):void
         {
            helper.log("Texture restoration failed for " + reference.url + ". " + param1);
            helper.onEndRestore();
         };
         helper.executeWhenContextReady(createTexture);
      }
   }
}
