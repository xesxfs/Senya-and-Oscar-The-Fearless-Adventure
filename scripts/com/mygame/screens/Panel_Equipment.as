package com.mygame.screens
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Panel_Equipment extends Sprite
   {
       
      
      private var startX:int;
      
      private var startY:int;
      
      private var stepX:int = 80;
      
      private var _arr:Array;
      
      public function Panel_Equipment()
      {
         this.startX = GV.posX - 150;
         this.startY = GV.scr_Y - 85;
         this._arr = [];
         super();
      }
      
      public function Init() : void
      {
         var _loc1_:Image = null;
         var _loc3_:Image = null;
         var _loc4_:Cell_inventory = null;
         _loc1_ = new Image(GV.assets.getTexture("Face0_0000"));
         _loc1_.x = this.startX - 110;
         _loc1_.y = this.startY - 15;
         addChild(_loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new Image(GV.assets.getTexture("CellHero000" + _loc2_));
            _loc3_.x = this.startX + _loc2_ * this.stepX;
            _loc3_.y = this.startY;
            addChild(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(GV.equipment[_loc2_] != null)
            {
               _loc4_ = new Cell_inventory();
               _loc4_.Init(_loc2_,"equipment");
               _loc4_.x = this.startX + _loc2_ * this.stepX;
               _loc4_.y = this.startY;
               addChild(_loc4_);
               this._arr.push(_loc4_);
            }
            else
            {
               this._arr.push(null);
            }
            _loc2_++;
         }
      }
      
      public function AddItem(param1:Array) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(this._arr[param1[0] - 1] != null)
         {
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < GV.equipment[param1[0] - 1].length)
            {
               _loc3_.push(GV.equipment[param1[0] - 1][_loc4_]);
               _loc4_++;
            }
            GV.game.SM.screen["panel_1"].AddItem(_loc3_);
            this._arr[param1[0] - 1].Free();
            this._arr[param1[0] - 1] = null;
         }
         GV.equipment[param1[0] - 1] = param1;
         var _loc2_:Cell_inventory = new Cell_inventory();
         _loc2_.Init(param1[0] - 1,"equipment");
         _loc2_.x = this.startX + (param1[0] - 1) * this.stepX;
         _loc2_.y = this.startY;
         addChild(_loc2_);
         this._arr[param1[0] - 1] = _loc2_;
      }
      
      public function Remove(param1:*) : void
      {
         this._arr[param1].Free();
         this._arr[param1] = null;
         GV.equipment[param1] = null;
      }
   }
}
