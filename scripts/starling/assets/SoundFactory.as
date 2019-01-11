package starling.assets
{
   import flash.media.Sound;
   import flash.utils.ByteArray;
   
   public class SoundFactory extends AssetFactory
   {
       
      
      public function SoundFactory()
      {
         super();
         addMimeTypes("audio/mp3","audio/mpeg3","audio/mpeg");
         addExtensions("mp3");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return param1.data is Sound || super.canHandle(param1);
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
         var _loc6_:Sound = param1.data as Sound;
         var _loc5_:ByteArray = param1.data as ByteArray;
         if(_loc5_)
         {
            try
            {
               _loc6_ = new Sound();
               _loc6_.loadCompressedDataFromByteArray(_loc5_,_loc5_.length);
            }
            catch(e:Error)
            {
               param4("Could not load sound data: " + e.message);
               return;
            }
         }
      }
   }
}
