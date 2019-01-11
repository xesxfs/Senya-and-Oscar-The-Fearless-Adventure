package com.mygame.effects
{
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class TowerStart extends Sprite implements IGameObject
   {
       
      
      public var _img1:Image;
      
      public var _isFree = false;
      
      private var _txt1:TextField;
      
      public function TowerStart()
      {
         super();
      }
      
      public function init() : void
      {
         x = 600;
         y = GV.groundY + 5;
         this._img1 = new Image(GV.assets.getTexture("Stolb0000"));
         this._img1.x = -230;
         addChild(this._img1);
         this._txt1 = new TextField(100,50,"00",new TextFormat("FontGoldExport",40,16777215,Align.CENTER));
         this._txt1.x = -222;
         this._txt1.y = -205;
         addChild(this._txt1);
         this.touchable = false;
         if(GV.gameLevel == 60)
         {
            this._txt1.text = "BOSS";
         }
         else
         {
            this._txt1.text = "" + (GV.gameLevel + 1);
         }
         GV.game.objs.add(this);
         GV.game.lay_0.addChildAt(this,0);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._img1.removeFromParent(true);
            this._txt1.removeFromParent(true);
            GV.game.objs.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(x + 300 < -GV.game._stage.x)
         {
            this.free();
         }
      }
   }
}
