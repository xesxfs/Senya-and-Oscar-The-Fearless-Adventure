package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Quad;
   import starling.events.EnterFrameEvent;
   
   public class ScreenManager
   {
       
      
      private var _blackScreen:Quad;
      
      public var screen:ScrBase;
      
      public var screen2:ScrBase;
      
      private var _isBlack:Boolean = false;
      
      private var _isLoading:Boolean = false;
      
      public var newScreenName:String;
      
      public function ScreenManager()
      {
         super();
      }
      
      public function transition_screen(param1:String, param2:Boolean) : void
      {
         Tweener.removeAllTweens();
         GV.game.addEventListener(EnterFrameEvent.ENTER_FRAME,this.init_blackscreen);
         this.newScreenName = param1;
         this._isBlack = false;
         this._isLoading = true;
      }
      
      private function init_blackscreen() : void
      {
         GV.game.removeEventListener(EnterFrameEvent.ENTER_FRAME,this.init_blackscreen);
         this._blackScreen = new Quad(GV.scr_X + 10,GV.scr_Y + 10,0);
         this._blackScreen.x = -5;
         this._blackScreen.y = -5;
         GV.game.addChild(this._blackScreen);
         this._blackScreen.alpha = 0;
         Tweener.addTween(this._blackScreen,{
            "alpha":1,
            "time":0.2,
            "transition":"linear",
            "onComplete":this.under_blackscreen
         });
      }
      
      private function under_blackscreen() : void
      {
         if(this._isLoading && !this._isBlack)
         {
            this.new_screen(this.newScreenName);
         }
         this._isBlack = true;
      }
      
      public function assets_loaded() : void
      {
         if(this._isBlack && !this._isLoading)
         {
            this.new_screen(this.newScreenName);
         }
         this._isLoading = true;
      }
      
      public function new_screen(param1:String) : void
      {
         this.newScreenName = param1;
         if(this.screen2)
         {
            this.free_screen();
         }
         if(this.screen)
         {
            this.screen.free();
            this.screen = null;
         }
         GV.game.free_level();
         switch(param1)
         {
            case "Game":
               GV.game.init_level();
               GV.sound.playMusic("game");
               break;
            case "Map":
               this.screen = new ScreenMap();
               GV.sound.playMusic("menu");
               break;
            case "Armor":
               this.screen = new ScreenArmor();
               break;
            case "Treasury":
               this.screen = new ScreenTreasury();
               break;
            case "Forge":
               this.screen = new ScreenForge();
               break;
            case "Final":
               this.screen = new ScreenFinal();
               GV.sound.playMusic("menu");
         }
         if(this._blackScreen)
         {
            GV.game.setChildIndex(this._blackScreen,GV.game.numChildren - 1);
            Tweener.addTween(this._blackScreen,{
               "alpha":0,
               "time":0.4,
               "delay":0.2,
               "transition":"linear",
               "onComplete":this.remove_blackScreen
            });
         }
      }
      
      private function remove_blackScreen() : void
      {
         this._blackScreen.removeFromParent(true);
         this._blackScreen = null;
         this._isBlack = false;
      }
      
      public function open_screen(param1:String) : void
      {
         this.free_screen();
         switch(param1)
         {
            case "Pause":
               GV.sound.playMusic("menu");
               this.screen2 = new ScreenPause();
               break;
            case "End":
               if(GV.levelComplete)
               {
                  GV.sound.playSFX("win");
               }
               else
               {
                  GV.sound.playSFX("fail");
               }
               GV.sound.stopMusic();
               this.screen2 = new ScreenEnd();
               break;
            case "Settings":
               this.screen2 = new ScreenSettings();
               break;
            case "Cheat":
               this.screen2 = new ScreenCheat();
               break;
            case "Credits":
               this.screen2 = new ScreenCredits();
               break;
            case "ResetData":
               this.screen2 = new ScreenResetData();
         }
      }
      
      public function free_screen() : void
      {
         if(this.screen2)
         {
            this.screen2.free();
            this.screen2 = null;
         }
      }
      
      public function translate() : void
      {
         if(this.screen)
         {
            this.screen.translate();
         }
         if(this.screen2)
         {
            this.screen2.translate();
         }
      }
   }
}
