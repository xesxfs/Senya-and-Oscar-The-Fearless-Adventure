package starling.assets
{
   import flash.utils.ByteArray;
   import starling.utils.ByteArrayUtil;
   
   public class JsonFactory extends AssetFactory
   {
       
      
      public function JsonFactory()
      {
         super();
         addExtensions("json");
         addMimeTypes("application/json","text/json");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return super.canHandle(param1) || param1.data is ByteArray && ByteArrayUtil.startsWithString(param1.data as ByteArray,"{");
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
         var _loc5_:* = null;
         var _loc6_:* = null;
         try
         {
            _loc5_ = param1.data as ByteArray;
            _loc6_ = JSON.parse(_loc5_.readUTFBytes(_loc5_.length));
            param3(param1.name,_loc6_);
            return;
         }
         catch(e:Error)
         {
            param4("Could not parse JSON: " + e.message);
            return;
         }
      }
   }
}
