package com.mygame.effects
{
   import com.general.IGameObject;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   
   public class TutorHand extends Sprite implements IGameObject
   {
       
      
      public var _sprite:MovieClip;
      
      public var _isFree = false;
      
      public function TutorHand()
      {
         super();
      }
      
      public function init() : void
      {
         this._sprite = new MovieClip(GV.assets.getTextures("Hand"),6);
         addChild(this._sprite);
         GV.starling.juggler.add(this._sprite);
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChild(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._sprite.stop();
            GV.starling.juggler.remove(this._sprite);
            GV.game.objs.remove(this);
            this._sprite.removeFromParent(true);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(GV.game.enemies.objects.length > 0)
         {
            x = GV.game.enemies.objects[0].x + 50;
            y = GV.game.enemies.objects[0].y - 70;
         }
         else
         {
            x = -200;
            y = -200;
         }
      }
   }
}
