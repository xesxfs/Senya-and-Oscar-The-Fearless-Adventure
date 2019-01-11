package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   
   public class ScreenResetData extends ScrBase
   {
       
      
      private var _back:Quad;
      
      private var _sprite:Sprite;
      
      private var _panel:InfoScreen;
      
      private var _btnYes:Button;
      
      private var _btnNo:Button;
      
      public function ScreenResetData()
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
         this._btnYes.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnNo.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnYes.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnNo.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         this._back.removeFromParent(true);
         this._btnYes.removeFromParent(true);
         this._btnNo.removeFromParent(true);
         this._panel.Free();
         this._sprite.removeFromParent(true);
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnYes)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.save.reset();
            GV.game.SM.transition_screen("Map",true);
         }
         if(_loc2_ as Button == this._btnNo)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.free_screen();
         }
      }
      
      override public function draw() : void
      {
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
         this._panel = new InfoScreen();
         this._sprite.addChild(this._panel);
         if(GV.settings[2] == 1)
         {
            this._panel.Init("It will erase \n current progress. \n Continue?");
         }
         if(GV.settings[2] == 2)
         {
            this._panel.Init("Стереть прогресс?");
         }
         this._btnYes = new Button(GV.assets.getTexture("Btn_Yes0000"));
         this._btnYes.x = GV.cent_X - 80 - this._btnYes.width / 2;
         this._btnYes.y = GV.cent_Y + 60;
         this._sprite.addChild(this._btnYes);
         this._btnNo = new Button(GV.assets.getTexture("Btn_No0000"));
         this._btnNo.x = GV.cent_X + 80 - this._btnNo.width / 2;
         this._btnNo.y = GV.cent_Y + 60;
         this._sprite.addChild(this._btnNo);
      }
      
      override public function translate() : void
      {
      }
   }
}
