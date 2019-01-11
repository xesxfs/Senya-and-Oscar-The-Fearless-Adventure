package com.mygame.spells
{
   import com.general.Amath;
   import com.general.IGameObject;
   import com.mygame.effects.Effect;
   import com.mygame.effects.GravityObj;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.MovieClip;
   import starling.display.Quad;
   import starling.display.Sprite;
   
   public class FireBallArrow extends Sprite implements IGameObject
   {
       
      
      public var _mc:MovieClip;
      
      private var _isFree = false;
      
      private var _isMove = false;
      
      private var _isEnd = false;
      
      private var _isCrit = false;
      
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
      
      private var _debugA:Quad;
      
      private var attackbox:Rectangle;
      
      private var en:Sprite;
      
      public function FireBallArrow()
      {
         this.p = [];
         super();
      }
      
      public function MyArrow() : *
      {
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._mc.stop();
            GV.juggler.remove(this._mc);
            this._mc.removeFromParent(true);
            this._mc = null;
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function init(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = GV.game.enemies.objects[0].x;
         _loc3_ = GV.groundY;
         this._mc = new MovieClip(GV.assets.getTextures("Sp_FireBall"),12);
         GV.juggler.add(this._mc);
         this._mc.play();
         this._mc.scale = 0.2;
         addChild(this._mc);
         this._power = param1;
         x = GV.cat.x + 30;
         y = GV.groundY - 50;
         var _loc4_:int = _loc2_ - (_loc2_ - x) / 2;
         this.cY = GV.groundY - 300;
         this.speed = (_loc2_ - x) / 20;
         this.p = [new Point(x,y),new Point(_loc4_,this.cY),new Point(_loc2_,_loc3_)];
         this.a = (this.p[2].y - (this.p[2].x * (this.p[1].y - this.p[0].y) + this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x)) / (this.p[2].x * (this.p[2].x - this.p[0].x - this.p[1].x) + this.p[0].x * this.p[1].x);
         this.b = (this.p[1].y - this.p[0].y) / (this.p[1].x - this.p[0].x) - this.a * (this.p[0].x + this.p[1].x);
         this.c = (this.p[1].x * this.p[0].y - this.p[0].x * this.p[1].y) / (this.p[1].x - this.p[0].x) + this.a * this.p[0].x * this.p[1].x;
         this.dx = x;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChild(this);
         this.update(1);
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:Effect = null;
         var _loc3_:int = 0;
         var _loc4_:GravityObj = null;
         if(!this._isMove)
         {
            x = GV.cat.x + 30;
            y = GV.groundY - 50;
            if(this._mc.scale < 1)
            {
               this._mc.scale = this._mc.scale + 0.2 * param1;
            }
            else
            {
               this._isMove = true;
            }
         }
         else
         {
            this.rotation = Math.atan(2 * this.a * this.dx + this.b) + 1.5;
            x = this.dx;
            y = this.a * this.dx * this.dx + this.b * this.dx + this.c;
            this.dx = this.dx + this.speed * param1;
            if(y > GV.groundY)
            {
               _loc2_ = new Effect();
               _loc2_.init(x,GV.groundY + 10,"Sp_1_Explosion",24);
               _loc2_.scale = 1.5;
               GV.game.damage(this._power);
               _loc3_ = 0;
               while(_loc3_ < 10)
               {
                  _loc4_ = new GravityObj();
                  _loc4_.init(x + Amath.random(-20,20),GV.groundY,"Oskolok000" + (GV.location - 1),Amath.random(5,15) / 10);
                  _loc3_++;
               }
               GV.sound.playSFX("explosion");
               GV.game.BM.addAplha(0,0.2,0);
               GV.game.shake(7);
               this.free();
            }
         }
      }
      
      public function debagAHitbox() : void
      {
         this._debugA = new Quad(this.attackbox.width,this.attackbox.height,2097407);
         GV.game.lay_0.addChild(this._debugA);
      }
   }
}
