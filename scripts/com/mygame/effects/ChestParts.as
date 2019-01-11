package com.mygame.effects
{
   import com.general.Amath;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class ChestParts extends Sprite implements IGameObject
   {
       
      
      public var _sprite:Image;
      
      public var _isFree:Boolean = false;
      
      private var _speedX:Number = 0;
      
      private var _speedY:Number = 0;
      
      private var _gravX:Number = 1.0;
      
      private var _gravY:Number = 8.0;
      
      private var _jumpY:Number = -30.0;
      
      private var _isRight:Boolean;
      
      private var num:int = 1;
      
      private var _rotation:Number;
      
      private var _time:int;
      
      private var _deltaY:int;
      
      public function ChestParts()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:String, param4:Number = 1) : void
      {
         this._sprite = new Image(GV.assets.getTexture(param3));
         this._sprite.pivotX = this._sprite.width / 2;
         this._sprite.pivotY = this._deltaY = this._sprite.height / 2;
         this._deltaY = 0;
         addChild(this._sprite);
         this._sprite.scale = param4;
         x = param1;
         y = param2;
         if(Math.random() > 0.5)
         {
            this._speedX = Amath.random(10,120) / 8;
            this._isRight = true;
         }
         else
         {
            this._speedX = -Amath.random(10,120) / 8;
            this._isRight = false;
         }
         this._speedY = -Amath.random(60,150) / 4;
         this._time = GV.real_time + 5000;
         GV.game.effects.add(this);
         GV.game.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.effects.remove(this);
            this._sprite.removeFromParent(true);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         x = x + this._speedX * param1;
         y = y + this._speedY * param1;
         if(this._speedX != 0)
         {
            if(this._isRight)
            {
               this._speedX = this._speedX - this._gravX * param1;
               if(this._speedX < 0)
               {
                  this._speedX = 0;
               }
            }
            else
            {
               this._speedX = this._speedX + this._gravX * param1;
               if(this._speedX > 0)
               {
                  this._speedX = 0;
               }
            }
            this._sprite.rotation = this._sprite.rotation + this._speedX / 5;
         }
         this._speedY = this._speedY + this._gravY * param1;
         if(y > GV.scr_Y + 50)
         {
            this.free();
         }
      }
   }
}
