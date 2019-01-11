package com.mygame.effects
{
   import caurina.transitions.Tweener;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Crit extends Sprite implements IGameObject
   {
       
      
      public var _img:Image;
      
      public var _isFree = false;
      
      public function Crit()
      {
         super();
      }
      
      public function init(param1:int, param2:int) : void
      {
         x = param1;
         y = param2;
         this._img = new Image(GV.assets.getTexture("crit0000"));
         addChild(this._img);
         this._img.scale = 0.2;
         this.touchable = false;
         GV.game.objs.add(this);
         GV.game.lay_2.addChild(this);
         Tweener.addTween(this._img,{
            "scale":1,
            "time":0.3,
            "transition":"easeOutBack"
         });
         Tweener.addTween(this._img,{
            "scale":1,
            "time":0.1,
            "delay":0.3,
            "transition":"linear",
            "onComplete":this.free
         });
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            Tweener.removeTweens(this._img);
            this._isFree = true;
            GV.game.objs.remove(this);
            this._img.removeFromParent(true);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
      }
   }
}
