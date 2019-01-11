package com.mygame.effects
{
   import com.general.Amath;
   import com.general.IGameObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class TowerFinish extends Sprite implements IGameObject
   {
       
      
      public var _img1:Image;
      
      public var _isFree = false;
      
      public var _isStop = false;
      
      private var _txt1:TextField;
      
      public function TowerFinish()
      {
         super();
      }
      
      public function init() : void
      {
         x = GV.hero.x + GV.scr_X + 1000;
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
            this._txt1.text = "FINISH";
         }
         else
         {
            this._txt1.text = "" + (GV.gameLevel + 2);
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
         if(!this._isStop)
         {
            if(x + GV.game._stage.x > GV.scr_X)
            {
               GV.game._stage.x = Amath.Lerp(GV.game._stage.x,-GV.hero.x + GV.posHero,0.1);
            }
            else if(GV.hero.x - 500 > x)
            {
               this._isStop = true;
               GV.LM.State = "End";
            }
         }
      }
   }
}
