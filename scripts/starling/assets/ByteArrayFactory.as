package starling.assets
{
   import flash.utils.ByteArray;
   
   public class ByteArrayFactory extends AssetFactory
   {
       
      
      public function ByteArrayFactory()
      {
         super();
         addExtensions("bin");
         addMimeTypes("application/octet-stream");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return param1.data is ByteArray;
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
      }
   }
}
