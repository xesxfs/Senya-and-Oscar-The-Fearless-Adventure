package starling.assets
{
   import starling.textures.TextureOptions;
   
   public class AssetReference
   {
       
      
      private var _name:String;
      
      private var _url:String;
      
      private var _data:Object;
      
      private var _mimeType:String;
      
      private var _extension:String;
      
      private var _textureOptions:TextureOptions;
      
      public function AssetReference(param1:Object)
      {
         super();
         _data = param1;
         _textureOptions = new TextureOptions();
         if(param1 is String)
         {
            _url = param1 as String;
         }
         else if("url" in param1)
         {
            _url = param1["url"] as String;
         }
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      public function set url(param1:String) : void
      {
         _url = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function set data(param1:Object) : void
      {
         _data = param1;
      }
      
      public function get mimeType() : String
      {
         return _mimeType;
      }
      
      public function set mimeType(param1:String) : void
      {
         _mimeType = param1;
      }
      
      public function get extension() : String
      {
         return _extension;
      }
      
      public function set extension(param1:String) : void
      {
         _extension = param1;
      }
      
      public function get textureOptions() : TextureOptions
      {
         return _textureOptions;
      }
      
      public function set textureOptions(param1:TextureOptions) : void
      {
         _textureOptions.copyFrom(param1);
      }
      
      function get filename() : String
      {
         if(name && extension && extension != "")
         {
            return name + "." + extension;
         }
         if(name)
         {
            return name;
         }
         return null;
      }
   }
}
