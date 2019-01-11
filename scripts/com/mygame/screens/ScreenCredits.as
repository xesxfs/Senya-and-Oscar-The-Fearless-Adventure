package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   
   public class ScreenCredits extends ScrBase
   {
       
      
      private var _back:Quad;
      
      private var _btnClose:Button;
      
      private var _Txt1:TextField;
      
      private var _Txt2:TextField;
      
      private var _Txt3:TextField;
      
      private var _board1:Image;
      
      private var _board2:Image;
      
      private var _board3:Image;
      
      private var _board4:Image;
      
      private var _sprite:Sprite;
      
      public function ScreenCredits()
      {
         super();
         this.draw();
         GV.game.addChild(this);
         this.activation();
      }
      
      override public function activation() : void
      {
         Tweener.addTween(this._sprite,{
            "y":0,
            "time":0.2,
            "transition":"linear",
            "onComplete":this.init_btn
         });
      }
      
      private function init_btn() : void
      {
         this._btnClose.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnClose.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         this._back.removeFromParent(true);
         this._board1.removeFromParent(true);
         this._board2.removeFromParent(true);
         this._board3.removeFromParent(true);
         this._board4.removeFromParent(true);
         this._btnClose.removeFromParent(true);
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnClose)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.free_screen();
         }
      }
      
      override public function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0.3;
         Tweener.addTween(this._back,{
            "alpha":0.7,
            "time":0.2,
            "delay":0,
            "transition":"linear"
         });
         this._sprite = new Sprite();
         addChild(this._sprite);
         this._sprite.y = -GV.scr_Y;
         _loc1_ = -40;
         _loc2_ = -5;
         _loc3_ = GV.cent_Y - 20;
         this._board1 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board1.pivotY = this._board1.height;
         this._board1.x = GV.cent_X + _loc1_;
         this._board1.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board1);
         this._board2 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board2.pivotY = this._board1.height;
         this._board2.x = GV.cent_X - _loc1_;
         this._board2.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board2);
         this._board2.scaleX = -1;
         this._board3 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board3.pivotY = this._board1.height;
         this._board3.x = GV.cent_X + _loc1_;
         this._board3.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board3);
         this._board3.scaleY = -1;
         this._board4 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board4.pivotY = this._board1.height;
         this._board4.x = GV.cent_X - _loc1_;
         this._board4.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board4);
         this._board4.scaleX = -1;
         this._board4.scaleY = -1;
         this._btnClose = new Button(GV.assets.getTexture("Btn_close0000"));
         this._btnClose.x = GV.cent_X + 140;
         this._btnClose.y = _loc3_ - 200;
         this._sprite.addChild(this._btnClose);
         this._Txt1 = new TextField(300,100,"\"Senya and Oscar\" \n developed by \n DENIS VASILEV");
         this._Txt1.format.setTo("PUTIN",22,16777215,"center");
         this._Txt1.x = GV.cent_X - this._Txt1.width / 2;
         this._Txt1.y = this._board1.y - 120;
         this._sprite.addChild(this._Txt1);
         this._Txt1.touchable = false;
         this._Txt2 = new TextField(300,100,"dennatolich@gmail.com");
         this._Txt2.format.setTo("PUTIN",22,16763904,"center");
         this._Txt2.x = GV.cent_X - this._Txt2.width / 2;
         this._Txt2.y = this._board1.y - 40;
         this._sprite.addChild(this._Txt2);
         this._Txt2.touchable = false;
         this._Txt3 = new TextField(300,100,"Please rate and comment \n my game. \n Have a good game!");
         this._Txt3.format.setTo("PUTIN",22,16777215,"center");
         this._Txt3.x = GV.cent_X - this._Txt3.width / 2;
         this._Txt3.y = this._board1.y + 35;
         this._sprite.addChild(this._Txt3);
         this.translate();
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 2)
         {
            this._Txt1.text = "\"Сеня и Оскар\" \n автор \n ДЕНИС ВАСИЛЬЕВ";
            this._Txt3.text = "Пожалуйста оцените и  \n прокомментируйте мою игру. \n Удачи!";
         }
      }
   }
}
