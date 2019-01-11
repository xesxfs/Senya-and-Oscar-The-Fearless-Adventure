package com.mygame.managers
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.textures.Texture;
   
   public class BackManager extends Sprite
   {
       
      
      private var _land:Image;
      
      private var _back1:Image;
      
      private var _back2:Image;
      
      public var _black:Quad;
      
      private var _num:int = 0;
      
      private var _bN:int;
      
      private var _gArr:Array;
      
      private var _gN:int;
      
      private var i:int = 0;
      
      private var d:Number = 0;
      
      private var oldX:Number = 0;
      
      public function BackManager()
      {
         this._gArr = [];
         super();
      }
      
      public function init_level(param1:int) : void
      {
         var _loc2_:Texture = null;
         var _loc4_:Image = null;
         this.d = 0;
         this.oldX = 0;
         this._gN = 0;
         this.free();
         this._land = new Image(GV.assets.getTexture("Landscape" + param1 + "_0000"));
         this._land.x = int(GV.cent_X - this._land.width / 2);
         this._land.y = int(GV.groundY / 2 - this._land.height / 2 + 10);
         addChild(this._land);
         _loc2_ = GV.assets.getTexture("Back" + param1 + "_0000");
         this._back1 = new Image(_loc2_);
         this._back1.x = 0;
         this._back1.y = int(GV.groundY - this._back1.height + 10);
         addChild(this._back1);
         this._back2 = new Image(_loc2_);
         this._back2.x = -900;
         this._back2.y = int(GV.groundY - this._back2.height + 10);
         addChild(this._back2);
         this._black = new Quad(GV.scr_X + 20,GV.groundY + 20,0);
         this._black.x = -10 - GV.game._stage.x;
         this._black.y = -10;
         this._black.alpha = 0;
         this._black.touchable = false;
         addChild(this._black);
         _loc2_ = GV.assets.getTexture("Ground" + param1 + "_0000");
         var _loc3_:int = 0;
         while(_loc3_ < 8)
         {
            _loc4_ = new Image(_loc2_);
            _loc4_.x = -10 + _loc3_ * 198;
            _loc4_.y = GV.groundY;
            GV.game.lay_3.addChild(_loc4_);
            this._gArr.push(_loc4_);
            _loc3_++;
         }
         this.touchable = false;
      }
      
      public function update() : void
      {
         this.d = int(GV.game._stage.x - this.oldX);
         if(this.d > 0)
         {
            this._back1.x = this._back1.x + this.d / 3;
            this._back2.x = this._back2.x + this.d / 3;
            if(this._back1.x > 1300)
            {
               this._back1.x = this._back2.x - 1298;
            }
            if(this._back2.x > 1300)
            {
               this._back2.x = this._back1.x - 1298;
            }
            if(this._gArr[this._gN].x > -20 - GV.game._stage.x)
            {
               this._gN--;
               if(this._gN < 0)
               {
                  this._gN = 7;
               }
               this._gArr[this._gN].x = this._gArr[this._gN].x - 198 * 8;
            }
         }
         else
         {
            this._back1.x = this._back1.x + int(this.d / 2);
            this._back2.x = this._back2.x + int(this.d / 2);
            if(this._back1.x <= -1300)
            {
               this._back1.x = this._back2.x + 1298;
            }
            if(this._back2.x <= -1300)
            {
               this._back2.x = this._back1.x + 1298;
            }
            if(this._gArr[this._gN].x < -200 - GV.game._stage.x)
            {
               this._gArr[this._gN].x = this._gArr[this._gN].x + 198 * 8;
               this._gN++;
               if(this._gN > 7)
               {
                  this._gN = 0;
               }
            }
         }
         this.oldX = GV.game._stage.x;
      }
      
      public function free() : void
      {
         if(this._land)
         {
            this._land.removeFromParent(true);
            this._land = null;
         }
         if(this._back1)
         {
            this._back1.removeFromParent(true);
            this._back1 = null;
         }
         if(this._back2)
         {
            this._back2.removeFromParent(true);
            this._back2 = null;
         }
         if(this._black)
         {
            this._black.removeFromParent(true);
            this._black = null;
         }
         while(this._gArr.length > 0)
         {
            this._gArr[0].removeFromParent(true);
            this._gArr[0] = null;
            this._gArr.splice(0,1);
         }
      }
      
      public function addAplha(param1:Number, param2:Number, param3:*) : void
      {
         Tweener.removeTweens(this._black);
         Tweener.addTween(this._black,{
            "alpha":param1,
            "time":param2,
            "delay":param3,
            "transition":"linear"
         });
      }
   }
}
