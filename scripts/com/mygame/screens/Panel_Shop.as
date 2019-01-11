package com.mygame.screens
{
   import starling.display.Button;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Panel_Shop extends Sprite
   {
       
      
      private var nameTxt:TextField;
      
      private var line_Num:int = 6;
      
      private var row_Num:int = 3;
      
      private var startX:int;
      
      private var startY:int;
      
      private var stepX:int = 80;
      
      private var _btnR:Button;
      
      private var _btnL:Button;
      
      private var _arr:Array;
      
      private var _pagesArr:Array;
      
      private var _curPage:int = 0;
      
      private var _maxPage:int = -1;
      
      private var _sprite:Sprite;
      
      public function Panel_Shop()
      {
         this._arr = [];
         this._pagesArr = [];
         this._sprite = new Sprite();
         super();
      }
      
      public function Init() : void
      {
         var _loc2_:Cell_inventory = null;
         this.nameTxt = new TextField(200,40,"",new TextFormat("PUTIN",25,16777215,Align.CENTER));
         this.nameTxt.x = GV.posX - int(this.nameTxt.width / 2) + this.stepX / 2;
         this.nameTxt.y = 15;
         this.nameTxt.touchable = false;
         addChild(this.nameTxt);
         this.startX = GV.posX - 2.5 * this.stepX;
         this.startY = GV.cent_Y - 1.5 * this.stepX;
         this._btnR = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btnR.x = int(this.startX + this.stepX * 6);
         this._btnR.y = this.startY + this.stepX * 1;
         addChild(this._btnR);
         this._btnR.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnL = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btnL.x = int(this.startX - 18);
         this._btnL.y = this.startY + this.stepX * 1;
         this._btnL.scaleX = -1;
         addChild(this._btnL);
         this._btnL.addEventListener(Event.TRIGGERED,this.touch_btns);
         addChild(this._sprite);
         var _loc1_:int = 0;
         while(_loc1_ < GV.shop.length)
         {
            _loc2_ = new Cell_inventory();
            _loc2_.Init(_loc1_,"shop");
            this._sprite.addChild(_loc2_);
            this._arr.push(_loc2_);
            _loc1_++;
         }
         this.Disposition();
         this.translate();
      }
      
      public function Activate() : void
      {
         this.visible = true;
      }
      
      public function AddItem(param1:Array) : void
      {
         GV.shop.push(param1);
         var _loc2_:Cell_inventory = new Cell_inventory();
         _loc2_.Init(GV.shop.length - 1,"shop");
         this._sprite.addChild(_loc2_);
         this._arr.push(_loc2_);
         this.Disposition();
      }
      
      public function Remove(param1:*) : void
      {
         GV.shop.splice(param1,1);
         this._arr[param1].Free();
         this._arr[param1] = null;
         this._arr.splice(param1,1);
         var _loc2_:int = 0;
         while(_loc2_ < this._arr.length)
         {
            this._arr[_loc2_]._index = _loc2_;
            _loc2_++;
         }
         this.Disposition();
      }
      
      public function Chek_Price() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._arr.length)
         {
            this._arr[_loc1_].check_price();
            _loc1_++;
         }
      }
      
      public function Disposition() : void
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:MovieClip = null;
         this.startX = GV.posX - 2.5 * this.stepX;
         this.startY = GV.cent_Y - 1.5 * this.stepX;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         while(_loc4_ < this._arr.length)
         {
            this._arr[_loc4_].x = this.startX + _loc1_ * this.stepX;
            this._arr[_loc4_].y = this.startY + _loc2_ * this.stepX;
            _loc1_++;
            if(_loc1_ == 6)
            {
               _loc1_ = 0;
               _loc2_++;
               if(_loc2_ == 3)
               {
                  _loc2_ = 0;
                  this.startX = this.startX + GV.scr_X;
                  if(_loc4_ != this._arr.length - 1)
                  {
                     _loc3_++;
                  }
               }
            }
            _loc4_++;
         }
         if(this._maxPage == -1 || _loc3_ != this._maxPage)
         {
            this._sprite.x = 0;
            this._maxPage = _loc3_;
            this._curPage = 0;
            this._btnL.alpha = 0;
            while(this._pagesArr.length > 0)
            {
               this._pagesArr[0].removeFromParent();
               this._pagesArr.splice(0,1);
            }
            _loc5_ = 30;
            _loc6_ = GV.posX - this._maxPage * _loc5_ / 2 + _loc5_;
            if(this._maxPage > 0)
            {
               _loc4_ = 0;
               while(_loc4_ <= this._maxPage)
               {
                  _loc7_ = new MovieClip(GV.assets.getTextures("Page"));
                  _loc7_.x = _loc6_ + _loc4_ * _loc5_;
                  _loc7_.y = GV.cent_Y + 125;
                  addChild(_loc7_);
                  this._pagesArr.push(_loc7_);
                  _loc4_++;
               }
               this._pagesArr[0].currentFrame = 1;
               this._btnR.alpha = 1;
            }
            else
            {
               this._btnR.alpha = 0;
            }
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnL)
         {
            if(this._curPage > 0)
            {
               this._curPage--;
               this._sprite.x = this._sprite.x + GV.scr_X;
               this._btnR.alpha = 1;
               _loc3_ = 0;
               while(_loc3_ < this._pagesArr.length)
               {
                  if(_loc3_ == this._curPage)
                  {
                     this._pagesArr[_loc3_].currentFrame = 1;
                  }
                  else
                  {
                     this._pagesArr[_loc3_].currentFrame = 0;
                  }
                  _loc3_++;
               }
               if(this._curPage == 0)
               {
                  this._btnL.alpha = 0;
               }
            }
         }
         if(_loc2_ as Button == this._btnR)
         {
            if(this._curPage < this._maxPage)
            {
               this._curPage++;
               this._sprite.x = this._sprite.x - GV.scr_X;
               this._btnL.alpha = 1;
               _loc3_ = 0;
               while(_loc3_ < this._pagesArr.length)
               {
                  if(_loc3_ == this._curPage)
                  {
                     this._pagesArr[_loc3_].currentFrame = 1;
                  }
                  else
                  {
                     this._pagesArr[_loc3_].currentFrame = 0;
                  }
                  _loc3_++;
               }
               if(this._curPage == this._maxPage)
               {
                  this._btnR.alpha = 0;
               }
            }
         }
      }
      
      public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this.nameTxt.text = "Shop";
         }
         if(GV.settings[2] == 2)
         {
            this.nameTxt.text = "Магазин";
         }
      }
   }
}
