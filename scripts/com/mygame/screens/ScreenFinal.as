package com.mygame.screens
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenFinal extends ScrBase
   {
       
      
      private var CongTxt:TextField;
      
      private var WinTxt:TextField;
      
      public var ThankTxt:TextField;
      
      private var _btnQuit:Button;
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var _armature2:Armature = null;
      
      public var _armatureDisplay2:StarlingArmatureDisplay = null;
      
      public var _state:int = 1;
      
      public var _numDance:int = 1;
      
      public function ScreenFinal()
      {
         super();
         this.draw();
         GV.game.addChildAt(this,0);
         this.activation();
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         this._btnQuit.removeEventListener(Event.TRIGGERED,this.touch_btns);
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnQuit)
         {
            this.deactivation();
            GV.game.SM.transition_screen("Map",false);
         }
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         WorldClock.clock.advanceTime(-1);
      }
      
      override public function draw() : void
      {
         var _loc1_:Image = null;
         var _loc3_:int = 0;
         _loc1_ = new Image(GV.assets.getTexture("Wall"));
         _loc1_.pivotY = 0;
         _loc1_.pivotX = 0;
         _loc1_.x = GV.cent_X - _loc1_.width / 2;
         _loc1_.y = GV.cent_Y - _loc1_.height / 2;
         addChild(_loc1_);
         this._btnQuit = new Button(GV.assets.getTexture("Btn_back" + "0000"));
         this._btnQuit.x = int(GV.scr_X - this._btnQuit.width - 15);
         this._btnQuit.y = 10;
         addChild(this._btnQuit);
         this._armature = GV.factory.buildArmature("HeroAnimation");
         this._armature.animation.timeScale = 1.2;
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play("Win1",1);
         this._armatureDisplay.scale = 1.4;
         this._armatureDisplay.x = GV.cent_X - 180;
         this._armatureDisplay.y = GV.scr_Y - 105;
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         if(GV.equipment[0] == null)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = GV.equipment[0][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[0][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[0][2].exp;
         }
         this.ChangeImg("sword","sw" + _loc3_ + "_0000");
         if(GV.equipment[1] == null)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = GV.equipment[1][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[1][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[1][2].exp;
         }
         this.ChangeImg("shield","H_t" + _loc3_ + "_0000");
         this.ChangeImg("head","H_h" + 0 + "_0000");
         if(GV.equipment[3] == null)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = GV.equipment[3][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[3][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[3][2].exp;
         }
         this.ChangeImg("body","H_b" + _loc3_ + "_0000");
         this.ChangeImg("shR","H_r" + _loc3_ + "_0000");
         this.ChangeImg("shL","H_l" + _loc3_ + "_0000");
         if(GV.equipment[4] == null)
         {
            _loc3_ = 0;
         }
         else
         {
            _loc3_ = GV.equipment[4][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[4][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[4][2].exp;
         }
         this.ChangeImg("bootR","H_f" + _loc3_ + "_0000");
         this.ChangeImg("bootL","H_f" + _loc3_ + "_0000");
         this.ChangeImg("legR","H_j" + _loc3_ + "_0000");
         this.ChangeImg("legL","H_j" + _loc3_ + "_0000");
         this.ChangeImg("handL","H_ruch0000");
         this.ChangeImg("femL","H_fem0000");
         this.ChangeImg("femR","H_fem0000");
         this.ChangeImg("forR","H_arm0000");
         this._armature2 = GV.factory.buildArmature("Cat");
         this._armatureDisplay2 = this._armature2.display as StarlingArmatureDisplay;
         this._armature2.animation.timeScale = 1.2;
         this._armature2.animation.play("Dance",99999999);
         this._armatureDisplay2.scaleX = -1.4;
         this._armatureDisplay2.scaleY = 1.4;
         this._armatureDisplay2.x = GV.cent_X + 180;
         this._armatureDisplay2.y = GV.scr_Y - 95;
         addChild(this._armatureDisplay2);
         WorldClock.clock.add(this._armature2);
         var _loc2_:Image = new Image(GV.assets.getTexture("Wood0000"));
         _loc2_.width = GV.scr_X + 10;
         _loc2_.x = 0;
         _loc2_.y = GV.scr_Y - 105;
         addChild(_loc2_);
         this.CongTxt = new TextField(500,60,"CONGRATULATIONS!",new TextFormat("PUTIN",50,16763904,Align.CENTER));
         this.CongTxt.x = GV.cent_X - int(this.CongTxt.width / 2);
         this.CongTxt.y = GV.cent_Y - 230;
         this.CongTxt.touchable = false;
         addChild(this.CongTxt);
         this.WinTxt = new TextField(500,50,"YOU WIN!",new TextFormat("PUTIN",40,16763904,Align.CENTER));
         this.WinTxt.x = GV.cent_X - int(this.WinTxt.width / 2);
         this.WinTxt.y = GV.cent_Y - 150;
         this.WinTxt.touchable = false;
         addChild(this.WinTxt);
         this.ThankTxt = new TextField(800,50,"THANK YOU FOR PLAYING!",new TextFormat("PUTIN",40,16777215,Align.CENTER));
         this.ThankTxt.x = GV.cent_X - int(this.ThankTxt.width / 2);
         this.ThankTxt.y = GV.scr_Y - 80;
         this.ThankTxt.touchable = false;
         addChild(this.ThankTxt);
         this.translate();
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         if(this._state == 1)
         {
            if(this._numDance < 1)
            {
               this._armature.animation.play("Win1",1);
               this._numDance++;
            }
            else
            {
               this._state = 2;
               this._numDance = 0;
               this._armature.animation.play("Win3",1);
            }
         }
         else if(this._numDance < 1)
         {
            this._armature.animation.play("Win3",1);
            this._numDance++;
         }
         else
         {
            this._state = 1;
            this._numDance = 0;
            this._armature.animation.play("Win1",1);
         }
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this.CongTxt.text = "CONGRATULATIONS!";
            this.WinTxt.text = "YOU WIN!";
            this.ThankTxt.text = "THANK YOU FOR PLAYING!";
         }
         if(GV.settings[2] == 2)
         {
            this.CongTxt.text = "ПОЗДРАВЛЯЕМ!";
            this.WinTxt.text = "ПОБЕДА!";
            this.ThankTxt.text = "СПАСИБО ЗА ИГРУ!";
         }
      }
      
      public function ChangeImg(param1:String, param2:String) : void
      {
         var _loc3_:Slot = this._armature.getSlot(param1);
         _loc3_.display = new Sprite();
         var _loc4_:Image = new Image(GV.assets.getTexture(param2));
         _loc3_.display.addChild(_loc4_);
      }
   }
}
