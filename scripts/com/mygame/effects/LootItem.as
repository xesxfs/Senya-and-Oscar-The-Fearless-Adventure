package com.mygame.effects
{
   import com.general.Amath;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class LootItem extends Sprite implements IGameObject
   {
       
      
      public var _sprite:Image;
      
      public var _isFree:Boolean = false;
      
      private var _speedX:Number = 0;
      
      private var _speedY:Number = 0;
      
      private var _gravX:Number = 2.0;
      
      private var _gravY:Number = 8.0;
      
      private var _jumpY:Number = -30;
      
      private var _isRight:Boolean;
      
      private var num:int = 1;
      
      private var _rotation:Number;
      
      private var _time:int;
      
      private var _deltaY:int;
      
      private var _state:int = 0;
      
      public function LootItem()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:String) : void
      {
         this._sprite = new Image(GV.assets.getTexture(param3));
         this._sprite.pivotY = this._deltaY = this._sprite.height / 2;
         this._deltaY = this._deltaY - 5;
         addChild(this._sprite);
         x = param1;
         y = param2;
         if(Math.random() > 0.5)
         {
            this._speedX = Amath.random(60,120) / 5;
            this._isRight = true;
         }
         else
         {
            this._speedX = -Amath.random(60,120) / 5;
            this._isRight = false;
         }
         this._speedY = -Amath.random(60,120) / 2;
         this._time = GV.real_time + 5000;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.objs.remove(this);
            this._sprite.removeFromParent(true);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         switch(this._state)
         {
            case 0:
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
               }
               this._speedY = this._speedY + this._gravY * param1;
               if(y > GV.groundY - this._deltaY)
               {
                  y = GV.groundY - this._deltaY;
                  if(this._jumpY < -15)
                  {
                     this._speedY = this._jumpY;
                     this._jumpY = this._jumpY * 0.5;
                     this._gravY = 15;
                     break;
                  }
                  this._state = 1;
                  break;
               }
               break;
            case 1:
               if(x < GV.hero.x)
               {
                  this._state = 2;
                  this.removeFromParent();
                  GV.game.gui.addChildAt(this,0);
                  this.x = this.x + GV.game._stage.x;
                  GV.sound.coin();
                  break;
               }
               break;
            case 2:
               x = Amath.Lerp(x,20,0.08);
               y = Amath.Lerp(y,20,0.08);
               if(Amath.distance(x,y,20,20) < 20)
               {
                  this.free();
                  break;
               }
         }
      }
   }
}
