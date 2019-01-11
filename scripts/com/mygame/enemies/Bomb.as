package com.mygame.enemies
{
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import flash.geom.Point;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Bomb extends Sprite implements IGameObject
   {
       
      
      public var _mc:Image;
      
      private var _isFree = false;
      
      private var _isMove = true;
      
      private var _isEnd = false;
      
      private var speed:Number;
      
      private var p:Array;
      
      private var a:Number;
      
      private var b:Number;
      
      private var c:Number;
      
      private var dx:Number;
      
      private var cX:int;
      
      private var cY:int;
      
      private var _power:int = 0;
      
      private var _timer:int = 0;
      
      private var _en:Sprite;
      
      public function Bomb()
      {
         this.p = [];
         super();
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._mc.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int, param2:int, param3:int, param4:int = 0, param5:int = 0) : void
      {
         param4 = GV.hero.x;
         param5 = GV.hero.y;
         this._mc = new Image(GV.assets.getTexture("Nut0000"));
         this._mc.x = -22;
         this._mc.y = -22;
         addChild(this._mc);
         this.touchable = false;
         this._power = param3;
         x = param1;
         y = param2;
         var _loc6_:int = param4 - (param4 - x) / 2;
         this.cY = GV.groundY - 300;
         this.speed = (param4 - x) / 20;
         this.p = [new Point(x,y),new Point(_loc6_,this.cY),new Point(param4,param5)];
         this.a = (this.p[2].y - (this.p[2].x * (this.p[1].y - this.p[0].y) + this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x)) / (this.p[2].x * (this.p[2].x - this.p[0].x - this.p[1].x) + this.p[0].x * this.p[1].x);
         this.b = (this.p[1].y - this.p[0].y) / (this.p[1].x - this.p[0].x) - this.a * (this.p[0].x + this.p[1].x);
         this.c = (this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x) + this.a * this.p[0].x * this.p[1].x;
         this.dx = x;
         GV.game.objs.add(this);
         GV.game.lay_2.addChild(this);
         this.update(1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Effect = null;
         if(this._isMove)
         {
            this.rotation = this.rotation - 0.1;
            x = this.dx;
            y = this.a * this.dx * this.dx + this.b * this.dx + this.c;
            if(this.dx + this.speed >= this.p[2].x)
            {
               this.dx = this.dx + this.speed * param1;
            }
            else
            {
               y = GV.groundY - 40;
               this._isMove = false;
            }
         }
         else
         {
            _loc2_ = new Effect();
            _loc2_.init(x,GV.groundY + 10,"Sp_1_Explosion",24);
            _loc2_.scale = 1.5;
            GV.hero.Dmage(this._power);
            GV.sound.playSFX("explosion");
            GV.game.shake(7);
            this.free();
         }
      }
   }
}
