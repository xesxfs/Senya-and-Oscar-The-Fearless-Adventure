package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenTreasury extends ScrBase
   {
       
      
      private var nameTxt:TextField;
      
      private var rewardTxt:TextField;
      
      public var keyTxt:TextField;
      
      private var winTxt:TextField;
      
      private var winNumberTxt:TextField;
      
      private var continueTxt:TextField;
      
      private var _btnContinue:Button;
      
      private var _btnQuit:Button;
      
      public var _state:String = "open";
      
      private var _scrollImg:Image;
      
      private var _keyImg:Image;
      
      private var _sprite1:Sprite;
      
      private var _sprite2:Sprite;
      
      private var _reward_line_0:RewardPanel;
      
      private var _reward_line_1:RewardPanel;
      
      private var _reward_line_2:RewardPanel;
      
      private var _reward_line_3:RewardPanel;
      
      private var _reward_line_4:RewardPanel;
      
      private var arr:Array;
      
      private var chestArr:Array;
      
      public function ScreenTreasury()
      {
         this.arr = [3,1,1,1,2,0,2,2,2,2,0,2,3,3,0,3,3,1,3,3];
         this.chestArr = [];
         super();
         this.draw();
         GV.game.addChildAt(this,0);
         this.activation();
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnContinue.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnQuit.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnContinue.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         Tweener.removeTweens(this);
         if(this.winTxt)
         {
            Tweener.removeTweens(this.winTxt);
         }
         if(this.winNumberTxt)
         {
            Tweener.removeTweens(this.winNumberTxt);
         }
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnQuit)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.save.localSave();
            GV.game.SM.transition_screen("Map",false);
         }
         if(_loc2_ as Button == this._btnContinue)
         {
            this.deactivation();
            GV.save.localSave();
            GV.game.SM.transition_screen("Treasury",false);
         }
      }
      
      public function add_item(param1:int) : void
      {
         this["_reward_line_" + param1].Add();
      }
      
      public function stop_open(param1:String) : void
      {
         GV.sound.playSFX("reward");
         this.winNumberTxt.text = param1;
         GV.treasury_openArr = [];
         this._state = "stop";
         var _loc2_:int = 0;
         while(_loc2_ < this.chestArr.length)
         {
            this.chestArr[_loc2_]["open"]();
            _loc2_++;
         }
         Tweener.addTween(this,{
            "x":0,
            "time":2.5,
            "transition":"linear",
            "onComplete":this.showWin
         });
      }
      
      public function showWin() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.chestArr.length)
         {
            this.chestArr[_loc1_]["fall"]();
            _loc1_++;
         }
         this.winTxt.visible = true;
         Tweener.addTween(this.winTxt,{
            "x":GV.cent_X - 90,
            "time":0.4,
            "transition":"easeOutBack"
         });
         this.winNumberTxt.visible = true;
         Tweener.addTween(this.winNumberTxt,{
            "x":GV.cent_X - 40,
            "time":0.4,
            "delay":0.2,
            "transition":"easeOutBack"
         });
         if(GV.treasury_keys > 0)
         {
            this._btnContinue.visible = true;
         }
         Tweener.addTween(this._btnContinue,{
            "y":GV.cent_Y + 100,
            "time":0.4,
            "delay":0.4,
            "transition":"easeOutBack"
         });
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         GV.juggler.advanceTime(param1.passedTime);
      }
      
      override public function draw() : void
      {
         var _loc1_:Image = null;
         var _loc7_:int = 0;
         var _loc9_:Array = null;
         var _loc10_:* = undefined;
         var _loc11_:ChestTreasury = null;
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
         this._btnContinue = new Button(GV.assets.getTexture("BtnGreen" + "0000"));
         this._btnContinue.x = GV.cent_X + 50;
         this._btnContinue.y = GV.scr_Y + 50;
         addChild(this._btnContinue);
         this._btnContinue.visible = false;
         this._keyImg = new Image(GV.assets.getTexture("Key_mc0000"));
         this._keyImg.x = 50;
         this._keyImg.y = 40;
         addChild(this._keyImg);
         this._sprite1 = new Sprite();
         addChild(this._sprite1);
         this._scrollImg = new Image(GV.assets.getTexture("Tr_scroll0000"));
         this._scrollImg.x = GV.cent_X - 380;
         this._scrollImg.y = GV.cent_Y - 140;
         this._sprite1.addChild(this._scrollImg);
         var _loc2_:int = this._scrollImg.x + 20;
         var _loc3_:int = this._scrollImg.y + 110;
         var _loc4_:int = 55;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         while(_loc6_ < 4)
         {
            this["_reward_line_" + _loc6_] = new RewardPanel();
            this["_reward_line_" + _loc6_].Init(_loc6_);
            this["_reward_line_" + _loc6_].x = _loc2_;
            this["_reward_line_" + _loc6_].y = _loc3_ + _loc6_ * _loc4_;
            this._sprite1.addChild(this["_reward_line_" + _loc6_]);
            _loc6_++;
         }
         if(GV.treasury_openArr.length == 0)
         {
            _loc9_ = [];
            GV.treasury_chestsArr = [];
            _loc6_ = 0;
            while(_loc6_ < 20)
            {
               _loc9_.push(this.arr[_loc6_]);
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < 20)
            {
               _loc7_ = Amath.random(0,_loc9_.length - 1);
               GV.treasury_chestsArr.push(_loc9_[_loc7_]);
               _loc9_.splice(_loc7_,1);
               _loc6_++;
            }
         }
         this._sprite2 = new Sprite();
         addChild(this._sprite2);
         _loc2_ = GV.cent_X - 90;
         _loc3_ = GV.cent_Y - 120;
         _loc4_ = 80;
         _loc5_ = 90;
         var _loc8_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc10_ = 0;
            while(_loc10_ < 4)
            {
               _loc11_ = new ChestTreasury();
               _loc11_.init(_loc8_);
               _loc11_.x = _loc2_ + _loc6_ * _loc5_;
               _loc11_.y = _loc3_ + _loc10_ * _loc4_;
               this._sprite2.addChild(_loc11_);
               this.chestArr.push(_loc11_);
               _loc8_++;
               _loc10_++;
            }
            _loc6_++;
         }
         this.rewardTxt = new TextField(250,40,"Rewards:",new TextFormat("FontGoldExport",35,16777215,Align.CENTER));
         this.rewardTxt.x = this._scrollImg.x;
         this.rewardTxt.y = this._scrollImg.y + 35;
         this.rewardTxt.touchable = false;
         this._sprite1.addChild(this.rewardTxt);
         this.nameTxt = new TextField(300,40,"",new TextFormat("FontGoldExport",35,16777215,Align.CENTER));
         this.nameTxt.x = GV.cent_X - int(this.nameTxt.width / 2);
         this.nameTxt.y = 10;
         this.nameTxt.touchable = false;
         addChild(this.nameTxt);
         this.keyTxt = new TextField(300,40,"x" + GV.treasury_keys,new TextFormat("FontGoldExport",35,16777215,Align.LEFT));
         this.keyTxt.x = this._keyImg.x + 40;
         this.keyTxt.y = this._keyImg.y - 25;
         this.keyTxt.touchable = false;
         addChild(this.keyTxt);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         this.winTxt = new TextField(420,80,"YOU WIN:",new TextFormat("FontGoldExport",60,16777215,Align.CENTER));
         this.winTxt.x = GV.scr_X + 70;
         this.winTxt.y = GV.cent_Y - 100;
         this.winTxt.touchable = false;
         addChild(this.winTxt);
         this.winTxt.visible = false;
         this.winNumberTxt = new TextField(300,80,"100,000",new TextFormat("FontGoldExport",60,16777215,Align.CENTER));
         this.winNumberTxt.x = GV.scr_X + 50;
         this.winNumberTxt.y = GV.cent_Y - 10;
         this.winNumberTxt.touchable = false;
         addChild(this.winNumberTxt);
         this.winNumberTxt.visible = false;
         this.continueTxt = new TextField(150,70,"Rewards:",new TextFormat("PUTIN",20,16777215,Align.CENTER));
         this.continueTxt.x = 0;
         this.continueTxt.y = 0;
         this.continueTxt.touchable = false;
         this._btnContinue.overlay.addChild(this.continueTxt);
         this.translate();
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this.nameTxt.text = "Treasury";
            this.winTxt.text = "YOU WIN:";
            this.rewardTxt.text = "Rewards:";
            this.continueTxt.text = "Continue";
         }
         if(GV.settings[2] == 2)
         {
            this.nameTxt.text = "Сокровищница";
            this.winTxt.text = "ВЫ ВЫИГРАЛИ:";
            this.rewardTxt.text = "Выигрыши:";
            this.continueTxt.text = "ПРодолжить";
         }
      }
   }
}
