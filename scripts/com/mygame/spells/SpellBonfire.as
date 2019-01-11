package com.mygame.spells
{
   import com.general.IGameObject;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class SpellBonfire extends Sprite implements IGameObject
   {
       
      
      public var _fire:MovieClip;
      
      private var _isFree:Boolean = false;
      
      public var _time:int = 0;
      
      private var _power:int = 0;
      
      private var _exp:int = 0;
      
      public function SpellBonfire()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         this._power = param1;
         this._exp = param2;
         x = GV.game.enemies.objects[0].x;
         y = GV.groundY + 10;
         this._fire = new MovieClip(GV.assets.getTextures("Bonfire"),12);
         addChild(this._fire);
         GV.juggler.add(this._fire);
         this._fire.play();
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.objs.remove(this);
            this._fire.stop();
            this._fire.removeFromParent(true);
            GV.juggler.remove(this._fire);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         if(GV.LM.State != "Battle")
         {
            y = y + 1;
            if(y > GV.groundY + 100)
            {
               this.free();
            }
         }
         else if(this._time < GV.real_time)
         {
            GV.sound.playSFX("flame");
            _loc2_ = 0;
            while(_loc2_ < GV.game.enemies.objects.length)
            {
               GV.game.enemies.objects[_loc2_].BladeDamage(this._power,false);
               GV.freeExp[1] = GV.freeExp[1] + this._power;
               _loc2_++;
            }
            this._time = GV.real_time + 700;
         }
      }
   }
}
