package com.mygame.screens
{
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class InfoScreen extends Sprite
   {
       
      
      private var _txt:TextField;
      
      private var _board1:Image;
      
      private var _board2:Image;
      
      private var _board3:Image;
      
      private var _board4:Image;
      
      public function InfoScreen()
      {
         super();
      }
      
      public function Init(param1:String) : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = -40;
         _loc3_ = -80;
         _loc4_ = GV.cent_Y - 20;
         this._board1 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board1.pivotY = this._board1.height;
         this._board1.x = GV.cent_X + _loc2_;
         this._board1.y = _loc4_ - _loc3_;
         addChild(this._board1);
         this._board2 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board2.pivotY = this._board1.height;
         this._board2.x = GV.cent_X - _loc2_;
         this._board2.y = _loc4_ - _loc3_;
         addChild(this._board2);
         this._board2.scaleX = -1;
         this._board3 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board3.pivotY = this._board1.height;
         this._board3.x = GV.cent_X + _loc2_;
         this._board3.y = _loc4_ + _loc3_;
         addChild(this._board3);
         this._board3.scaleY = -1;
         this._board4 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board4.pivotY = this._board1.height;
         this._board4.x = GV.cent_X - _loc2_;
         this._board4.y = _loc4_ + _loc3_;
         addChild(this._board4);
         this._board4.scaleX = -1;
         this._board4.scaleY = -1;
         this._txt = new TextField(300,180,param1);
         this._txt.format.setTo("PUTIN",22,16777215,"center","center");
         this._txt.x = GV.cent_X - this._txt.width / 2;
         this._txt.y = this._board1.y - 190;
         addChild(this._txt);
         this._txt.touchable = false;
      }
      
      public function Free() : *
      {
         this._txt.removeFromParent(true);
         this._board1.removeFromParent(true);
         this._board2.removeFromParent(true);
         this._board3.removeFromParent(true);
         this._board4.removeFromParent(true);
      }
   }
}
