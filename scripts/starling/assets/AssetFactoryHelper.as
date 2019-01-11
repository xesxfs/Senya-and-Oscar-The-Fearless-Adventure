package starling.assets
{
   import starling.utils.SystemUtil;
   
   public class AssetFactoryHelper
   {
       
      
      private var _dataLoader:DataLoader;
      
      private var _getNameFromUrlFunc:Function;
      
      private var _getExtensionFromUrlFunc:Function;
      
      private var _addPostProcessorFunc:Function;
      
      private var _addAssetFunc:Function;
      
      private var _onRestoreFunc:Function;
      
      private var _logFunc:Function;
      
      public function AssetFactoryHelper()
      {
         super();
      }
      
      public function getNameFromUrl(param1:String) : String
      {
         if(_getNameFromUrlFunc != null)
         {
            return _getNameFromUrlFunc(param1);
         }
         return "";
      }
      
      public function getExtensionFromUrl(param1:String) : String
      {
         if(_getExtensionFromUrlFunc != null)
         {
            return _getExtensionFromUrlFunc(param1);
         }
         return "";
      }
      
      public function loadDataFromUrl(param1:String, param2:Function, param3:Function) : void
      {
         if(_dataLoader)
         {
            _dataLoader.load(param1,param2,param3);
         }
      }
      
      public function addPostProcessor(param1:Function, param2:int = 0) : void
      {
         if(_addPostProcessorFunc != null)
         {
            _addPostProcessorFunc(param1,param2);
         }
      }
      
      public function onBeginRestore() : void
      {
         if(_onRestoreFunc != null)
         {
            _onRestoreFunc(false);
         }
      }
      
      public function onEndRestore() : void
      {
         if(_onRestoreFunc != null)
         {
            _onRestoreFunc(true);
         }
      }
      
      public function log(param1:String) : void
      {
         if(_logFunc != null)
         {
            _logFunc(param1);
         }
      }
      
      public function addComplementaryAsset(param1:String, param2:Object, param3:String = null) : void
      {
         if(_addAssetFunc != null)
         {
            _addAssetFunc(param1,param2,param3);
         }
      }
      
      public function executeWhenContextReady(param1:Function, ... rest) : void
      {
         if(SystemUtil.isDesktop)
         {
            param1.apply(this,rest);
         }
         else
         {
            rest.unshift(param1);
            SystemUtil.executeWhenApplicationIsActive.apply(this,rest);
         }
      }
      
      function set getNameFromUrlFunc(param1:Function) : void
      {
         _getNameFromUrlFunc = param1;
      }
      
      function set getExtensionFromUrlFunc(param1:Function) : void
      {
         _getExtensionFromUrlFunc = param1;
      }
      
      function set dataLoader(param1:DataLoader) : void
      {
         _dataLoader = param1;
      }
      
      function set logFunc(param1:Function) : void
      {
         _logFunc = param1;
      }
      
      function set addAssetFunc(param1:Function) : void
      {
         _addAssetFunc = param1;
      }
      
      function set onRestoreFunc(param1:Function) : void
      {
         _onRestoreFunc = param1;
      }
      
      function set addPostProcessorFunc(param1:Function) : void
      {
         _addPostProcessorFunc = param1;
      }
   }
}
