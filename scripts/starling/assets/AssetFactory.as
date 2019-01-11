package starling.assets
{
   import flash.system.Capabilities;
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   import starling.errors.AbstractClassError;
   
   public class AssetFactory
   {
       
      
      private var _priority:int;
      
      private var _mimeTypes:Vector.<String>;
      
      private var _extensions:Vector.<String>;
      
      public function AssetFactory()
      {
         super();
         if(Capabilities.isDebugger && getQualifiedClassName(this) == "starling.assets::AssetFactory")
         {
            throw new AbstractClassError();
         }
         _mimeTypes = new Vector.<String>(0);
         _extensions = new Vector.<String>(0);
      }
      
      public function canHandle(param1:AssetReference) : Boolean
      {
         var _loc3_:String = param1.mimeType;
         var _loc2_:String = param1.extension;
         return param1.data is ByteArray && (_loc3_ && _mimeTypes.indexOf(param1.mimeType.toLowerCase()) != -1 || _loc2_ && _extensions.indexOf(param1.extension.toLowerCase()) != -1);
      }
      
      public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
      }
      
      public function addMimeTypes(... rest) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_ = _loc2_.toLowerCase();
            if(_mimeTypes.indexOf(_loc2_) == -1)
            {
               _mimeTypes[_mimeTypes.length] = _loc2_;
            }
         }
      }
      
      public function addExtensions(... rest) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = rest;
         for each(var _loc2_ in rest)
         {
            _loc2_ = _loc2_.toLowerCase();
            if(_extensions.indexOf(_loc2_) == -1)
            {
               _extensions[_extensions.length] = _loc2_;
            }
         }
      }
      
      public function getMimeTypes(param1:Vector.<String> = null) : Vector.<String>
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            param1 = new Vector.<String>();
         }
         _loc2_ = 0;
         while(_loc2_ < _mimeTypes.length)
         {
            param1[_loc2_] = _mimeTypes[_loc2_];
            _loc2_++;
         }
         return param1;
      }
      
      public function getExtensions(param1:Vector.<String> = null) : Vector.<String>
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            param1 = new Vector.<String>();
         }
         _loc2_ = 0;
         while(_loc2_ < _extensions.length)
         {
            param1[_loc2_] = _extensions[_loc2_];
            _loc2_++;
         }
         return param1;
      }
      
      function get priority() : int
      {
         return _priority;
      }
      
      function set priority(param1:int) : void
      {
         _priority = param1;
      }
   }
}
