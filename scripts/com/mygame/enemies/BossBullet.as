package com.mygame.enemies
{
   import com.general.IGameObject;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class BossBullet extends Sprite implements IGameObject
   {
       
      
      public var _mc:MovieClip;
      
      private var _isFree = false;
      
      private var speed:Number = 25;
      
      private var _power:Number = 2;
      
      public function BossBullet()
      {
         super();
      }
      
      public function init(param1:int, param2:int, param3:int) : void
      {
         x = param1;
         y = param2;
         this._power = param3;
         this._mc = new MovieClip(GV.assets.getTextures("BossBullet"),6);
         addChild(this._mc);
         this._mc.play();
         GV.juggler.add(this._mc);
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.juggler.remove(this._mc);
            this._mc.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         x = x - this.speed * param1;
         if(x < GV.hero.x)
         {
            GV.hero.Dmage(this._power);
            GV.sound.playSFX("explosion");
            this.free();
         }
      }
   }
}
