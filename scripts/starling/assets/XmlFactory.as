package starling.assets
{
   import flash.utils.ByteArray;
   import starling.text.BitmapFont;
   import starling.text.TextField;
   import starling.textures.Texture;
   import starling.textures.TextureAtlas;
   import starling.utils.ByteArrayUtil;
   
   public class XmlFactory extends AssetFactory
   {
       
      
      public function XmlFactory()
      {
         super();
         addMimeTypes("application/xml","text/xml");
         addExtensions("xml","fnt");
      }
      
      override public function canHandle(param1:AssetReference) : Boolean
      {
         return super.canHandle(param1) || param1.data is ByteArray && ByteArrayUtil.startsWithString(param1.data as ByteArray,"<");
      }
      
      override public function create(param1:AssetReference, param2:AssetFactoryHelper, param3:Function, param4:Function) : void
      {
         reference = param1;
         helper = param2;
         onComplete = param3;
         onError = param4;
         textureAtlasPostProcessor = function(param1:AssetManager):void
         {
            var _loc3_:String = helper.getNameFromUrl(xml.@imagePath.toString());
            var _loc2_:Texture = param1.getTexture(_loc3_);
            if(_loc2_)
            {
               param1.addAsset(_loc3_,new TextureAtlas(_loc2_,xml));
            }
            else
            {
               helper.log("Cannot create atlas: texture \'" + _loc3_ + "\' is missing.");
            }
         };
         bitmapFontPostProcessor = function(param1:AssetManager):void
         {
            var _loc5_:* = null;
            var _loc4_:String = helper.getNameFromUrl(xml.pages.page.@file.toString());
            var _loc3_:Texture = param1.getTexture(_loc4_);
            var _loc2_:String = !!param1.registerBitmapFontsWithFontFace?xml.info.@face.toString():_loc4_;
            if(_loc3_)
            {
               _loc5_ = new BitmapFont(_loc3_,xml);
               param1.addAsset(_loc2_,_loc5_);
               TextField.registerCompositor(_loc5_,_loc2_);
            }
            else
            {
               helper.log("Cannot create bitmap font: texture \'" + _loc4_ + "\' is missing.");
            }
         };
         var xml:XML = reference.data as XML;
         var bytes:ByteArray = reference.data as ByteArray;
         if(bytes)
         {
            try
            {
               xml = new XML(bytes);
            }
            catch(e:Error)
            {
               onError("Could not parse XML: " + e.message);
               return;
            }
         }
         var rootNode:String = xml.localName();
         if(rootNode == "TextureAtlas")
         {
            helper.addPostProcessor(textureAtlasPostProcessor,100);
         }
         else if(rootNode == "font")
         {
            helper.addPostProcessor(bitmapFontPostProcessor);
         }
      }
   }
}
