package com.mygame.spells
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class BoostBtn extends Sprite
   {
       
      
      public var _img:Image;
      
      public var _isFree:Boolean = false;
      
      public var _isEmpty:Boolean = false;
      
      public var _type:int = 0;
      
      public var _id:int = 0;
      
      public var _n:int;
      
      public function BoostBtn()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         this._n = param3;
         x = param1;
         y = param2;
         this._img = new Image(GV.assets.getTexture("BoostEmpty0000"));
         addChild(this._img);
         this._img.useHandCursor = true;
         this.addEventListener(TouchEvent.TOUCH,this.onTouch);
      }
      
      public function init_level() : void
      {
         if(GV.bag[this._n] == null)
         {
            this._isEmpty = true;
            this._img.texture = GV.assets.getTexture("BoostEmpty0000");
         }
         else
         {
            this._type = GV.bag[this._n][0];
            this._id = GV.bag[this._n][1];
            this._isEmpty = false;
            this._img.texture = GV.assets.getTexture("Boost_" + this._type + "_" + this._id + "_0000");
         }
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(!this._isEmpty && _loc2_.phase == TouchPhase.BEGAN)
            {
               this._isEmpty = true;
               GV.bag[this._n] = null;
               this._img.texture = GV.assets.getTexture("BoostEmpty0000");
               if(this._type == 6)
               {
                  switch(this._id)
                  {
                     case 1:
                        GV.hero.Healing(0.25);
                        break;
                     case 2:
                        GV.hero.Healing(0.5);
                        break;
                     case 3:
                        GV.hero.Healing(0.75);
                  }
               }
               if(this._type == 7)
               {
                  switch(this._id)
                  {
                     case 1:
                        GV.hero.Angry();
                        break;
                     case 2:
                        GV.hero.Angry();
                        break;
                     case 3:
                        GV.hero.Angry();
                  }
               }
            }
         }
      }
   }
}
