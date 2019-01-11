package com.mygame.screens
{
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Panel_CatBag extends Sprite
   {
       
      
      private var startX:int;
      
      private var startY:int;
      
      private var stepX:int = 80;
      
      private var _arr:Array;
      
      public function Panel_CatBag()
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
         _loc1_ = new Image(GV.assets.getTexture("Face1_0000"));
         _loc1_.x = this.startX - 110;
         _loc1_.y = this.startY - 15;
         addChild(_loc1_);
         var _loc2_:int = 0;
         while(_loc2_ < GV.bag.length)
         {
            _loc3_ = new Image(GV.assets.getTexture("EmptyCell0000"));
            _loc3_.x = this.startX + _loc2_ * this.stepX;
            _loc3_.y = this.startY;
            addChild(_loc3_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < GV.bag.length)
         {
            if(GV.bag[_loc2_] != null)
            {
               _loc4_ = new Cell_inventory();
               _loc4_.Init(_loc2_,"bag");
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
         var _loc2_:int = 0;
         var _loc3_:Cell_inventory = null;
         _loc2_ = 0;
         while(_loc2_ < this._arr.length)
         {
            if(this._arr[_loc2_] == null)
            {
               GV.bag[_loc2_] = param1;
               _loc3_ = new Cell_inventory();
               _loc3_.Init(_loc2_,"bag");
               _loc3_.x = this.startX + _loc2_ * this.stepX;
               _loc3_.y = this.startY;
               addChild(_loc3_);
               this._arr[_loc2_] = _loc3_;
               break;
            }
            _loc2_++;
         }
      }
      
      public function Remove(param1:*) : void
      {
         this._arr[param1].Free();
         this._arr[param1] = null;
         GV.bag[param1] = null;
      }
   }
}
