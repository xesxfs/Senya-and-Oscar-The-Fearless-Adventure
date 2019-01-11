package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class IconExpirience extends Sprite
   {
       
      
      private var _icon:Image;
      
      private var _line:Image;
      
      private var _frame:Image;
      
      private var _back:Image;
      
      private var _sun:Image;
      
      public var _index:int;
      
      public var _curLevel:int;
      
      private var _levelTxt:TextField;
      
      private var _expTxt:TextField;
      
      private var _curExp:int;
      
      private var _maxExp:int;
      
      private var _stepExp:int;
      
      private var _freeExp:int;
      
      private var isEnd:Boolean = false;
      
      public function IconExpirience()
      {
         super();
      }
      
      public function init(param1:int) : *
      {
         this._index = param1;
         this._curLevel = GV.levels[param1];
         this._curExp = GV.curExp[param1];
         this._freeExp = int(GV.freeExp[param1] * (1 + GV.multiExp / 100));
         this._frame = new Image(GV.assets.getTexture("ExpFrame0000"));
         this._frame.x = 50;
         this._frame.y = -17;
         addChild(this._frame);
         this._line = new Image(GV.assets.getTexture("ExpLine0000"));
         this._line.x = 55;
         this._line.y = -15;
         addChildAt(this._line,0);
         this._back = new Image(GV.assets.getTexture("ExpBack0000"));
         this._back.x = 55;
         this._back.y = -15;
         addChildAt(this._back,0);
         this._levelTxt = new TextField(200,35,"",new TextFormat("FontGoldExport",30,16777215,Align.LEFT));
         this._levelTxt.x = 50;
         this._levelTxt.y = -52;
         addChild(this._levelTxt);
         this._levelTxt.touchable = false;
         this._expTxt = new TextField(208,35,"",new TextFormat("FontSilverExport",25,16777215,Align.CENTER));
         this._expTxt.x = 50;
         this._expTxt.y = 10;
         addChild(this._expTxt);
         this._expTxt.touchable = false;
         this._sun = new Image(GV.assets.getTexture("Sun0000"));
         this._sun.scale = 0.1;
         addChild(this._sun);
         this._icon = new Image(GV.assets.getTexture("Face" + this._index + "_0000"));
         this._icon.pivotY = this._icon.pivotX = int(this._icon.width / 2);
         addChild(this._icon);
         this.calculateExp();
      }
      
      public function free() : *
      {
         Tweener.removeTweens(this._icon);
         Tweener.removeTweens(this._sun);
         this.removeFromParent(true);
      }
      
      private function calculateExp() : *
      {
         this._maxExp = 150 * this._curLevel * this._curLevel - 100;
         this._stepExp = this._maxExp / 50;
         this._expTxt.text = this._curExp + "/" + this._maxExp;
         this._line.scaleX = this._curExp / this._maxExp;
         this._levelTxt.text = "Level: " + this._curLevel;
      }
      
      public function update() : *
      {
         this._sun.rotation = this._sun.rotation + 0.05;
         if(this._freeExp > 0)
         {
            if(this._freeExp > this._stepExp)
            {
               this._freeExp = this._freeExp - this._stepExp;
               this._curExp = this._curExp + this._stepExp;
            }
            else
            {
               this._curExp = this._curExp + this._freeExp;
               this._freeExp = 0;
            }
            GV.curExp[this._index] = this._curExp;
            if(this._curExp < this._maxExp)
            {
               this._expTxt.text = this._curExp + "/" + this._maxExp;
               this._line.scaleX = this._curExp / this._maxExp;
            }
            else
            {
               this._curLevel++;
               GV.levels[this._index]++;
               this._curExp = 0;
               GV.curExp[this._index] = 0;
               this.calculateExp();
               Tweener.addTween(this._icon,{
                  "scale":1.3,
                  "time":0.3,
                  "transition":"lenear"
               });
               Tweener.addTween(this._sun,{
                  "scale":2,
                  "time":0.3,
                  "transition":"lenear"
               });
               Tweener.addTween(this._icon,{
                  "scale":1,
                  "delay":0.3,
                  "time":0.9,
                  "transition":"lenear"
               });
               Tweener.addTween(this._sun,{
                  "scale":0,
                  "delay":0.3,
                  "time":2,
                  "transition":"lenear"
               });
               GV.sound.playSFX("levelUp");
            }
         }
         else if(!this.isEnd)
         {
            this.isEnd = true;
            parent["StopExpirience"]();
         }
      }
   }
}
