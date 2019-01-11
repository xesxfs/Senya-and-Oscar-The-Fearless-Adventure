package starling.assets
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   import flash.net.URLRequest;
   import flash.system.System;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import starling.core.Starling;
   import starling.events.EventDispatcher;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.textures.TextureOptions;
   import starling.utils.MathUtil;
   import starling.utils.execute;
   
   public class AssetManager extends EventDispatcher
   {
      
      private static const NAME_REGEX:RegExp = /([^?\/\\]+?)(?:\.([\w\-]+))?(?:\?.*)?$/;
      
      private static const NO_NAME:String = "unnamed";
      
      private static var sNoNameCount:int = 0;
      
      private static var sNames:Vector.<String> = new Vector.<String>(0);
       
      
      private var _starling:Starling;
      
      private var _assets:Dictionary;
      
      private var _verbose:Boolean;
      
      private var _numConnections:int;
      
      private var _dataLoader:DataLoader;
      
      private var _textureOptions:TextureOptions;
      
      private var _queue:Vector.<AssetReference>;
      
      private var _registerBitmapFontsWithFontFace:Boolean;
      
      private var _assetFactories:Vector.<AssetFactory>;
      
      private var _numRestoredTextures:int;
      
      private var _numLostTextures:int;
      
      public function AssetManager(param1:Number = 1)
      {
         super();
         _assets = new Dictionary();
         _verbose = true;
         _textureOptions = new TextureOptions(param1);
         _queue = new Vector.<AssetReference>(0);
         _numConnections = 3;
         _dataLoader = new DataLoader();
         _assetFactories = new Vector.<AssetFactory>(0);
         registerFactory(new BitmapTextureFactory());
         registerFactory(new AtfTextureFactory());
         registerFactory(new SoundFactory());
         registerFactory(new JsonFactory());
         registerFactory(new XmlFactory());
         registerFactory(new ByteArrayFactory(),-100);
      }
      
      private static function comparePriorities(param1:Object, param2:Object) : int
      {
         if(param1.priority == param2.priority)
         {
            return 0;
         }
         return param1.priority > param2.priority?-1:1;
      }
      
      private static function getDictionaryKeys(param1:Dictionary, param2:String = "", param3:Vector.<String> = null) : Vector.<String>
      {
         if(param3 == null)
         {
            param3 = new Vector.<String>(0);
         }
         if(param1)
         {
            var _loc6_:int = 0;
            var _loc5_:* = param1;
            for(var _loc4_ in param1)
            {
               if(_loc4_.indexOf(param2) == 0)
               {
                  param3[param3.length] = _loc4_;
               }
            }
            param3.sort(1);
         }
         return param3;
      }
      
      private static function getUniqueName() : String
      {
         sNoNameCount = Number(sNoNameCount) + 1;
         return "unnamed-" + Number(sNoNameCount);
      }
      
      public function dispose() : void
      {
         purgeQueue();
         var _loc6_:int = 0;
         var _loc5_:* = _assets;
         for each(var _loc1_ in _assets)
         {
            var _loc4_:int = 0;
            var _loc3_:* = _loc1_;
            for each(var _loc2_ in _loc1_)
            {
               disposeAsset(_loc2_);
            }
         }
      }
      
      public function purge() : void
      {
         log("Purging all assets, emptying queue");
         purgeQueue();
         dispose();
         _assets = new Dictionary();
      }
      
      public function enqueue(... rest) : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc16_:int = 0;
         var _loc15_:* = rest;
         for each(var _loc3_ in rest)
         {
            if(_loc3_ is Array)
            {
               enqueue.apply(this,_loc3_);
            }
            else if(_loc3_ is Class)
            {
               _loc2_ = describeType(_loc3_);
               if(_verbose)
               {
                  log("Looking for static embedded assets in \'" + _loc2_.@name.split("::").pop() + "\'");
               }
               var _loc10_:int = 0;
               var _loc5_:* = _loc2_.constant;
               var _loc6_:int = 0;
               var _loc8_:* = new XMLList("");
               var _loc9_:* = _loc2_.constant.(@type == "Class");
               for each(_loc4_ in _loc2_.constant.(@type == "Class"))
               {
                  enqueueSingle(_loc3_[_loc4_.@name],_loc4_.@name);
               }
               var _loc14_:int = 0;
               var _loc11_:* = _loc2_.variable;
               var _loc12_:int = 0;
               _loc5_ = new XMLList("");
               var _loc13_:* = _loc2_.variable.(@type == "Class");
               for each(_loc4_ in _loc2_.variable.(@type == "Class"))
               {
                  enqueueSingle(_loc3_[_loc4_.@name],_loc4_.@name);
               }
            }
            else if(getQualifiedClassName(_loc3_) == "flash.filesystem::File")
            {
               if(!_loc3_["exists"])
               {
                  log("File or directory not found: \'" + _loc3_["url"] + "\'");
               }
               else if(!_loc3_["isHidden"])
               {
                  if(_loc3_["isDirectory"])
                  {
                     enqueue.apply(this,_loc3_["getDirectoryListing"]());
                  }
                  else
                  {
                     enqueueSingle(_loc3_);
                  }
               }
            }
            else if(_loc3_ is String || _loc3_ is URLRequest || _loc3_ is AssetManager)
            {
               enqueueSingle(_loc3_);
            }
            else
            {
               log("Ignoring unsupported asset type: " + getQualifiedClassName(_loc3_));
            }
         }
      }
      
      public function enqueueSingle(param1:Object, param2:String = null, param3:TextureOptions = null) : String
      {
         if(param1 is Class)
         {
            param1 = new param1();
         }
         var _loc4_:AssetReference = new AssetReference(param1);
         _loc4_.name = param2 || getNameFromUrl(_loc4_.url) || getUniqueName();
         _loc4_.extension = getExtensionFromUrl(_loc4_.url);
         _loc4_.textureOptions = param3 || _textureOptions;
         _queue.push(_loc4_);
         log("Enqueuing \'" + _loc4_.filename + "\'");
         return _loc4_.name;
      }
      
      public function purgeQueue() : void
      {
         _queue.length = 0;
         _dataLoader.close();
         dispatchEventWith("cancel");
      }
      
      public function loadQueue(param1:Function, param2:Function = null, param3:Function = null) : void
      {
         onComplete = param1;
         onError = param2;
         onProgress = param3;
         loadNextAsset = function():void
         {
            var _loc1_:int = 0;
            if(canceled)
            {
               return;
            }
            _loc1_ = 0;
            while(_loc1_ < numAssets)
            {
               if(assetProgress[_loc1_] < 0)
               {
                  loadFromQueue(queue,assetProgress,_loc1_,factoryHelper,onAssetLoaded,onAssetProgress,onAssetLoadError,onError);
                  break;
               }
               _loc1_++;
            }
         };
         onAssetLoaded = function(param1:String = null, param2:Object = null):void
         {
            if(canceled && param2)
            {
               disposeAsset(param2);
            }
            else
            {
               if(param1 && param2)
               {
                  addAsset(param1,param2);
               }
               numComplete = Number(numComplete) + 1;
               if(numComplete == numAssets)
               {
                  postProcessors.sort(comparePriorities);
                  setTimeout(runPostProcessors,1);
               }
               else
               {
                  setTimeout(loadNextAsset,1);
               }
            }
         };
         onAssetLoadError = function(param1:String):void
         {
            if(!canceled)
            {
               execute(onError,param1);
               onAssetLoaded();
            }
         };
         onAssetProgress = function(param1:Number):void
         {
            if(!canceled)
            {
               execute(onProgress,param1 * 0.95);
            }
         };
         addPostProcessor = function(param1:Function, param2:int):void
         {
            postProcessors.push(new AssetPostProcessor(param1,param2));
         };
         runPostProcessors = function():void
         {
            if(!canceled)
            {
               if(postProcessors.length)
               {
                  try
                  {
                     postProcessors.shift().execute(self);
                  }
                  catch(e:Error)
                  {
                     execute(onError,e.message);
                  }
                  setTimeout(runPostProcessors,1);
               }
               else
               {
                  finish();
               }
            }
         };
         onCanceled = function():void
         {
            canceled = true;
            removeEventListener("cancel",onCanceled);
         };
         finish = function():void
         {
            onCanceled();
            execute(onProgress,1);
            execute(onComplete,self);
         };
         if(_queue.length == 0)
         {
            finish();
            return;
         }
         addEventListener("cancel",onCanceled);
         var factoryHelper:AssetFactoryHelper = new AssetFactoryHelper();
         factoryHelper.getNameFromUrlFunc = getNameFromUrl;
         factoryHelper.getExtensionFromUrlFunc = getExtensionFromUrl;
         factoryHelper.addPostProcessorFunc = addPostProcessor;
         factoryHelper.addAssetFunc = addAsset;
         factoryHelper.onRestoreFunc = onAssetRestored;
         factoryHelper.dataLoader = _dataLoader;
         factoryHelper.logFunc = log;
         var self:AssetManager = this;
         var canceled:Boolean = false;
         var queue:Vector.<AssetReference> = _queue.concat();
         var numAssets:int = queue.length;
         var numComplete:int = 0;
         var numConnections:int = MathUtil.min(_numConnections,numAssets);
         var assetProgress:Vector.<Number> = new Vector.<Number>(numAssets,true);
         var postProcessors:Vector.<AssetPostProcessor> = new Vector.<AssetPostProcessor>(0);
         _starling = Starling.current;
         _queue.length = 0;
         var i:int = 0;
         while(i < numAssets)
         {
            assetProgress[i] = -1;
            i = i + 1;
         }
         i = 0;
         while(i < numConnections)
         {
            loadNextAsset();
            i = i + 1;
         }
      }
      
      private function loadFromQueue(param1:Vector.<AssetReference>, param2:Vector.<Number>, param3:int, param4:AssetFactoryHelper, param5:Function, param6:Function, param7:Function, param8:Function) : void
      {
         queue = param1;
         progressRatios = param2;
         index = param3;
         helper = param4;
         onComplete = param5;
         onProgress = param6;
         onError = param7;
         onIntermediateError = param8;
         onLoadComplete = function(param1:Object, param2:String = null, param3:String = null, param4:String = null):void
         {
            if(_starling)
            {
               _starling.makeCurrent();
            }
            onLoadProgress(1);
            if(param1)
            {
               asset.data = param1;
            }
            if(param3)
            {
               asset.name = param3;
            }
            if(param4)
            {
               asset.extension = param4;
            }
            if(param2)
            {
               asset.mimeType = param2;
            }
            var _loc5_:AssetFactory = getFactoryFor(asset);
            if(_loc5_ == null)
            {
               execute(onAnyError,"Warning: no suitable factory found for \'" + asset.name + "\'");
            }
            else
            {
               _loc5_.create(asset,helper,onComplete,onCreateError);
            }
         };
         onLoadProgress = function(param1:Number):void
         {
            var _loc5_:int = 0;
            var _loc2_:Number = NaN;
            progressRatios[index] = param1;
            var _loc3_:* = 0;
            var _loc4_:Number = 1 / assetCount;
            _loc5_ = 0;
            while(_loc5_ < assetCount)
            {
               _loc2_ = progressRatios[_loc5_];
               if(_loc2_ > 0)
               {
                  _loc3_ = Number(_loc3_ + _loc4_ * _loc2_);
               }
               _loc5_++;
            }
            execute(onProgress,MathUtil.min(_loc3_,1));
         };
         onLoadError = function(param1:String):void
         {
            onLoadProgress(1);
            execute(onAnyError,"Error loading " + asset.name + ": " + param1);
         };
         onCreateError = function(param1:String):void
         {
            execute(onAnyError,"Error creating " + asset.name + ": " + param1);
         };
         onAnyError = function(param1:String):void
         {
            log(param1);
            execute(onError,param1);
         };
         onManagerComplete = function():void
         {
            execute(onComplete,asset.name,asset.data);
         };
         var assetCount:int = queue.length;
         var asset:AssetReference = queue[index];
         progressRatios[index] = 0;
         if(asset.url)
         {
            _dataLoader.load(asset.url,onLoadComplete,onLoadError,onLoadProgress);
         }
         else if(asset.data is AssetManager)
         {
            (asset.data as AssetManager).loadQueue(onManagerComplete,onIntermediateError,onLoadProgress);
         }
         else
         {
            setTimeout(onLoadComplete,1,asset.data);
         }
      }
      
      private function getFactoryFor(param1:AssetReference) : AssetFactory
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = _assetFactories.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _assetFactories[_loc4_];
            if(_loc2_.canHandle(param1))
            {
               return _loc2_;
            }
            _loc4_++;
         }
         return null;
      }
      
      private function onAssetRestored(param1:Boolean) : void
      {
         if(param1)
         {
            _numRestoredTextures = Number(_numRestoredTextures) + 1;
            if(_starling)
            {
               _starling.stage.setRequiresRedraw();
            }
            if(_numRestoredTextures == _numLostTextures)
            {
               dispatchEventWith("texturesRestored");
            }
         }
         else
         {
            _numLostTextures = Number(_numLostTextures) + 1;
         }
      }
      
      public function addAsset(param1:String, param2:Object, param3:String = null) : void
      {
         if(!param3)
         {
            param3 = AssetType.fromAsset(param2);
         }
         var _loc4_:Dictionary = _assets[param3];
         if(_loc4_ == null)
         {
            _loc4_ = new Dictionary();
            _assets[param3] = _loc4_;
         }
         log("Adding " + param3 + " \'" + param1 + "\'");
         var _loc5_:Object = _loc4_[param1];
         if(_loc5_ && _loc5_ != param2)
         {
            log("Warning: name was already in use; disposing the previous " + param3);
            disposeAsset(_loc5_);
         }
         _loc4_[param1] = param2;
      }
      
      public function getAsset(param1:String, param2:String, param3:Boolean = true) : Object
      {
         var _loc5_:* = null;
         var _loc10_:* = null;
         var _loc4_:* = null;
         var _loc8_:* = null;
         if(param3)
         {
            _loc5_ = _assets["assetManager"];
            if(_loc5_)
            {
               var _loc12_:int = 0;
               var _loc11_:* = _loc5_;
               for each(var _loc6_ in _loc5_)
               {
                  _loc10_ = _loc6_.getAsset(param1,param2,true);
                  if(_loc10_)
                  {
                     return _loc10_;
                  }
               }
            }
            if(param1 == "texture")
            {
               _loc4_ = _assets["textureAtlas"];
               if(_loc4_)
               {
                  var _loc14_:int = 0;
                  var _loc13_:* = _loc4_;
                  for each(var _loc7_ in _loc4_)
                  {
                     _loc8_ = _loc7_.getTexture(param2);
                     if(_loc8_)
                     {
                        return _loc8_;
                     }
                  }
               }
            }
         }
         var _loc9_:Dictionary = _assets[param1];
         if(_loc9_)
         {
            return _loc9_[param2];
         }
         return null;
      }
      
      public function getAssetNames(param1:String, param2:String = "", param3:Boolean = true, param4:Vector.<String> = null) : Vector.<String>
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         if(!param4)
         {
            param4 = new Vector.<String>();
         }
         if(param3)
         {
            _loc6_ = _assets["assetManager"];
            if(_loc6_)
            {
               var _loc10_:int = 0;
               var _loc9_:* = _loc6_;
               for each(var _loc7_ in _loc6_)
               {
                  _loc7_.getAssetNames(param1,param2,true,param4);
               }
            }
            if(param1 == "texture")
            {
               _loc5_ = _assets["textureAtlas"];
               if(_loc5_)
               {
                  var _loc12_:int = 0;
                  var _loc11_:* = _loc5_;
                  for each(var _loc8_ in _loc5_)
                  {
                     _loc8_.getNames(param2,param4);
                  }
               }
            }
         }
         getDictionaryKeys(_assets[param1],param2,param4);
         param4.sort(1);
         return param4;
      }
      
      public function removeAsset(param1:String, param2:String, param3:Boolean = true) : void
      {
         var _loc5_:* = null;
         var _loc4_:Dictionary = _assets[param1];
         if(_loc4_)
         {
            _loc5_ = _loc4_[param2];
            if(_loc5_)
            {
               log("Removing " + param1 + " \'" + param2 + "\'");
               if(param3)
               {
                  disposeAsset(_loc5_);
               }
               delete _loc4_[param2];
            }
         }
      }
      
      public function getTexture(param1:String) : Texture
      {
         return getAsset("texture",param1) as Texture;
      }
      
      public function getTextures(param1:String = "", param2:Vector.<Texture> = null) : Vector.<Texture>
      {
         if(param2 == null)
         {
            param2 = new Vector.<Texture>(0);
         }
         var _loc5_:int = 0;
         var _loc4_:* = getTextureNames(param1,sNames);
         for each(var _loc3_ in getTextureNames(param1,sNames))
         {
            param2[param2.length] = getTexture(_loc3_);
         }
         sNames.length = 0;
         return param2;
      }
      
      public function getTextureNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("texture",param1,true,param2);
      }
      
      public function getTextureAtlas(param1:String) : TextureAtlas
      {
         return getAsset("textureAtlas",param1) as TextureAtlas;
      }
      
      public function getTextureAtlasNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("textureAtlas",param1,true,param2);
      }
      
      public function getSound(param1:String) : Sound
      {
         return getAsset("sound",param1) as Sound;
      }
      
      public function getSoundNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("sound",param1,true,param2);
      }
      
      public function playSound(param1:String, param2:Number = 0, param3:int = 0, param4:SoundTransform = null) : SoundChannel
      {
         var _loc5_:Sound = getSound(param1);
         if(_loc5_)
         {
            return _loc5_.play(param2,param3,param4);
         }
         return null;
      }
      
      public function getXml(param1:String) : XML
      {
         return getAsset("xml",param1) as XML;
      }
      
      public function getXmlNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("xml",param1,true,param2);
      }
      
      public function getObject(param1:String) : Object
      {
         return getAsset("object",param1);
      }
      
      public function getObjectNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("object",param1,true,param2);
      }
      
      public function getByteArray(param1:String) : ByteArray
      {
         return getAsset("byteArray",param1) as ByteArray;
      }
      
      public function getByteArrayNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("byteArray",param1,true,param2);
      }
      
      public function getBitmapFont(param1:String) : BitmapFont
      {
         return getAsset("bitmapFont",param1) as BitmapFont;
      }
      
      public function getBitmapFontNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("bitmapFont",param1,true,param2);
      }
      
      public function getAssetManager(param1:String) : AssetManager
      {
         return getAsset("assetManager",param1) as AssetManager;
      }
      
      public function getAssetManagerNames(param1:String = "", param2:Vector.<String> = null) : Vector.<String>
      {
         return getAssetNames("assetManager",param1,true,param2);
      }
      
      public function removeTexture(param1:String, param2:Boolean = true) : void
      {
         removeAsset("texture",param1,param2);
      }
      
      public function removeTextureAtlas(param1:String, param2:Boolean = true) : void
      {
         removeAsset("textureAtlas",param1,param2);
      }
      
      public function removeSound(param1:String) : void
      {
         removeAsset("sound",param1);
      }
      
      public function removeXml(param1:String, param2:Boolean = true) : void
      {
         removeAsset("xml",param1,param2);
      }
      
      public function removeObject(param1:String) : void
      {
         removeAsset("object",param1);
      }
      
      public function removeByteArray(param1:String, param2:Boolean = true) : void
      {
         removeAsset("byteArray",param1,param2);
      }
      
      public function removeBitmapFont(param1:String, param2:Boolean = true) : void
      {
         removeAsset("bitmapFont",param1,param2);
      }
      
      public function removeAssetManager(param1:String, param2:Boolean = true) : void
      {
         removeAsset("assetManager",param1,param2);
      }
      
      public function registerFactory(param1:AssetFactory, param2:int = 0) : void
      {
         param1.priority = param2;
         _assetFactories.push(param1);
         _assetFactories.sort(comparePriorities);
      }
      
      protected function getNameFromUrl(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = NAME_REGEX.exec(decodeURIComponent(param1));
            if(_loc2_ && _loc2_.length > 0)
            {
               return _loc2_[1];
            }
         }
         return null;
      }
      
      protected function getExtensionFromUrl(param1:String) : String
      {
         var _loc2_:* = null;
         if(param1)
         {
            _loc2_ = NAME_REGEX.exec(decodeURIComponent(param1));
            if(_loc2_ && _loc2_.length > 1)
            {
               return _loc2_[2];
            }
         }
         return "";
      }
      
      protected function disposeAsset(param1:Object) : void
      {
         if(param1 is ByteArray)
         {
            (param1 as ByteArray).clear();
         }
         if(param1 is XML)
         {
            System.disposeXML(param1 as XML);
         }
         if("dispose" in param1)
         {
            param1["dispose"]();
         }
      }
      
      protected function log(param1:String) : void
      {
         if(_verbose)
         {
            trace("[AssetManager]",param1);
         }
      }
      
      public function get verbose() : Boolean
      {
         return _verbose;
      }
      
      public function set verbose(param1:Boolean) : void
      {
         _verbose = param1;
      }
      
      public function get numQueuedAssets() : int
      {
         return _queue.length;
      }
      
      public function get numConnections() : int
      {
         return _numConnections;
      }
      
      public function set numConnections(param1:int) : void
      {
         _numConnections = MathUtil.min(1,param1);
      }
      
      public function get textureOptions() : TextureOptions
      {
         return _textureOptions;
      }
      
      public function set textureOptions(param1:TextureOptions) : void
      {
         _textureOptions.copyFrom(param1);
      }
      
      public function get dataLoader() : DataLoader
      {
         return _dataLoader;
      }
      
      public function set dataLoader(param1:DataLoader) : void
      {
         _dataLoader = param1;
      }
      
      public function get registerBitmapFontsWithFontFace() : Boolean
      {
         return _registerBitmapFontsWithFontFace;
      }
      
      public function set registerBitmapFontsWithFontFace(param1:Boolean) : void
      {
         _registerBitmapFontsWithFontFace = param1;
      }
   }
}

import starling.assets.AssetManager;

class AssetPostProcessor
{
    
   
   private var _priority:int;
   
   private var _callback:Function;
   
   function AssetPostProcessor(param1:Function, param2:int)
   {
      super();
      if(param1 == null || param1.length != 1)
      {
         throw new ArgumentError("callback must be a function accepting one \'AssetStore\' parameter");
      }
      _callback = param1;
      _priority = param2;
   }
   
   private function execute(param1:AssetManager) : void
   {
   }
   
   public function get priority() : int
   {
      return _priority;
   }
}
