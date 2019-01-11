package starling.utils
{
   import flash.utils.ByteArray;
   import starling.errors.AbstractClassError;
   
   public class ByteArrayUtil
   {
       
      
      public function ByteArrayUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function startsWithString(param1:ByteArray, param2:String) : Boolean
      {
         var _loc6_:* = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = param1.length;
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.writeUTFBytes(param2);
         if(_loc5_ >= 4 && (param1[0] == 0 && param1[1] == 0 && param1[2] == 254 && param1[3] == 255) || param1[0] == 255 && param1[1] == 254 && param1[2] == 0 && param1[3] == 0)
         {
            _loc4_ = 4;
         }
         else if(_loc5_ >= 3 && param1[0] == 239 && param1[1] == 187 && param1[2] == 191)
         {
            _loc4_ = 3;
         }
         else if(_loc5_ >= 2 && (param1[0] == 254 && param1[1] == 255) || param1[0] == 255 && param1[1] == 254)
         {
            _loc4_ = 2;
         }
         _loc6_ = _loc4_;
         while(_loc6_ < _loc5_)
         {
            _loc3_ = param1[_loc6_];
            if(_loc3_ != 0 && _loc3_ != 10 && _loc3_ != 13 && _loc3_ != 32)
            {
               return compareByteArrays(param1,_loc6_,_loc7_,0,_loc7_.length);
            }
            _loc6_++;
         }
         return false;
      }
      
      public static function compareByteArrays(param1:ByteArray, param2:int, param3:ByteArray, param4:int, param5:int = -1) : Boolean
      {
         var _loc6_:int = 0;
         if(param5 < 0)
         {
            param5 = MathUtil.min(param1.length - param2,param3.length - param4);
         }
         else if(param2 + param5 > param1.length || param4 + param5 > param3.length)
         {
            throw new RangeError();
         }
         _loc6_ = 0;
         while(_loc6_ < param5)
         {
            if(param1[param2 + _loc6_] != param3[param4 + _loc6_])
            {
               return false;
            }
            _loc6_++;
         }
         return true;
      }
   }
}
