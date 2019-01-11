package com.mygame.effects
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import com.general.IGameObject;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Damage_info extends Sprite implements IGameObject
   {
       
      
      public var _sprite:TextField;
      
      private var _isFree = false;
      
      private var _isEnd = false;
      
      public var _speedX:Number = 0;
      
      private var _speedY:Number = 0;
      
      private var _gravX:Number = 1.0;
      
      private var _gravY:Number = 8.0;
      
      private var _jumpY:Number = -30.0;
      
      public var _isRight:Boolean;
      
      private var _time:int;
      
      private var _deltaY:int;
      
      public function Damage_info()
      {
         super();
         this._sprite = new TextField(100,50,"000",new TextFormat("FontSilverExport",30,16777215,Align.LEFT));
         addChild(this._sprite);
         this._deltaY = 35;
         this.touchable = false;
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         this._isFree = false;
         this._isEnd = false;
         x = param1;
         y = param2;
         this._sprite.text = "-" + param3;
         this._isRight = true;
         this._speedX = Amath.random(40,180) / 10;
         this._speedY = -50;
         this._time = GV.real_time + 2000;
         this._gravY = 1.6 * 5;
         this._jumpY = -10 * 3;
         GV.game.objs.add(this);
         GV.game.lay_1.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            Tweener.removeTweens(this);
            GV.game.cacheDamage.set(this);
            GV.game.objs.remove(this);
            this.removeFromParent(false);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(!this._isEnd)
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
            }
            this._speedY = this._speedY + this._gravY * param1;
            if(y > GV.groundY - this._deltaY)
            {
               y = GV.groundY - this._deltaY;
               this._speedY = this._jumpY;
               this._jumpY = this._jumpY * 0.7;
               this._gravY = 10;
               if(this._speedY >= -1)
               {
                  this._isEnd = true;
               }
            }
         }
         if(this._time < GV.real_time)
         {
            y = y + 1;
            if(y > GV.groundY + 20)
            {
               this.free();
            }
         }
      }
   }
}
