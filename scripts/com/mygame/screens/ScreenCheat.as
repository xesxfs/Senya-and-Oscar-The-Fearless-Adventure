package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   
   public class ScreenCheat extends ScrBase
   {
       
      
      private var _back:Quad;
      
      private var _btnClose:Button;
      
      private var _nameTxt:TextField;
      
      private var _name_level_Txt:TextField;
      
      private var _levelTxt:TextField;
      
      private var _btn_level_up:Button;
      
      private var _btn_level_down:Button;
      
      private var _name_coin_Txt:TextField;
      
      private var _coin_Txt:TextField;
      
      private var _btn_coin_up:Button;
      
      private var _btn_coin_down:Button;
      
      private var _name_hero_Txt:TextField;
      
      private var _hero_Txt:TextField;
      
      private var _btn_hero_up:Button;
      
      private var _btn_hero_down:Button;
      
      private var _name_cat_Txt:TextField;
      
      private var _cat_Txt:TextField;
      
      private var _btn_cat_up:Button;
      
      private var _btn_cat_down:Button;
      
      private var _name_god_Txt:TextField;
      
      private var _god_Txt:TextField;
      
      private var _btn_god_up:Button;
      
      private var _btn_god_down:Button;
      
      private var _board1:Image;
      
      private var _board2:Image;
      
      private var _board3:Image;
      
      private var _board4:Image;
      
      private var _sprite:Sprite;
      
      public function ScreenCheat()
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
         this._btn_level_up.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_level_down.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_coin_up.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_coin_down.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_hero_up.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_hero_down.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_cat_up.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_cat_down.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_god_up.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_god_down.addEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function deactivation() : void
      {
         this._btnClose.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_level_up.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_level_down.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_coin_up.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_coin_down.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_hero_up.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_hero_down.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_cat_up.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_cat_down.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_god_up.removeEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn_god_down.removeEventListener(Event.TRIGGERED,this.touch_btns);
      }
      
      override public function free() : void
      {
         this._back.removeFromParent(true);
         this._board1.removeFromParent(true);
         this._board2.removeFromParent(true);
         this._board3.removeFromParent(true);
         this._board4.removeFromParent(true);
         this._btnClose.removeFromParent(true);
         this._btn_level_up.removeFromParent(true);
         this._btn_level_down.removeFromParent(true);
         this._btn_coin_up.removeFromParent(true);
         this._btn_coin_down.removeFromParent(true);
         this._btn_hero_up.removeFromParent(true);
         this._btn_hero_down.removeFromParent(true);
         this._btn_cat_up.removeFromParent(true);
         this._btn_cat_down.removeFromParent(true);
         this._btn_god_up.removeFromParent(true);
         this._btn_god_down.removeFromParent(true);
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnClose)
         {
            GV.sound.playSFX("click");
            GV.shop = [];
            _loc3_ = GV.gameLevel / 2;
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            GV.shopIndex = [_loc3_,_loc3_,_loc3_,_loc3_,_loc3_];
            _loc4_ = 0;
            while(_loc4_ < 5)
            {
               GV.game.LootM.create_item(_loc4_ + 1,0,GV.shopIndex[_loc4_] + 1);
               GV.shop.push(GV.game.LootM._arr);
               _loc4_++;
            }
            this.deactivation();
            GV.save.localSave();
            GV.game.SM.transition_screen("Map",true);
         }
         if(_loc2_ as Button == this._btn_level_up)
         {
            GV.sound.playSFX("click");
            if(GV.gameLevel < 60)
            {
               GV.gameLevel++;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_level_down)
         {
            GV.sound.playSFX("click");
            if(GV.gameLevel > 0)
            {
               GV.gameLevel--;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_coin_up)
         {
            GV.sound.playSFX("click");
            if(GV.coins < 100)
            {
               GV.coins = 100;
            }
            GV.coins = GV.coins * 2;
            if(GV.coins > 1000000000)
            {
               GV.coins = 1000000000;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_coin_down)
         {
            GV.sound.playSFX("click");
            GV.coins = GV.coins / 2;
            if(GV.coins < 100)
            {
               GV.coins = 100;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_hero_up)
         {
            GV.sound.playSFX("click");
            GV.levels[0]++;
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_hero_down)
         {
            GV.sound.playSFX("click");
            GV.levels[0]--;
            if(GV.levels[0] < 1)
            {
               GV.levels[0] = 1;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_cat_up)
         {
            GV.sound.playSFX("click");
            GV.levels[1]++;
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_cat_down)
         {
            GV.sound.playSFX("click");
            GV.levels[1]--;
            if(GV.levels[1] < 1)
            {
               GV.levels[1] = 1;
            }
            this.update_Date();
         }
         if(_loc2_ as Button == this._btn_god_up || _loc2_ as Button == this._btn_god_down)
         {
            GV.sound.playSFX("click");
            if(GV.godMode == true)
            {
               GV.godMode = false;
            }
            else
            {
               GV.godMode = true;
            }
            this.update_Date();
         }
      }
      
      override public function draw() : void
      {
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
         _loc2_ = -5;
         _loc3_ = GV.cent_Y - 20;
         this._board1 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board1.pivotY = this._board1.height;
         this._board1.x = GV.cent_X + -40;
         this._board1.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board1);
         this._board2 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board2.pivotY = this._board1.height;
         this._board2.x = GV.cent_X - -40;
         this._board2.y = _loc3_ - _loc2_;
         this._sprite.addChild(this._board2);
         this._board2.scaleX = -1;
         this._board3 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board3.pivotY = this._board1.height;
         this._board3.x = GV.cent_X + -40;
         this._board3.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board3);
         this._board3.scaleY = -1;
         this._board4 = new Image(GV.assets.getTexture("Part_Board0000"));
         this._board4.pivotY = this._board1.height;
         this._board4.x = GV.cent_X - -40;
         this._board4.y = _loc3_ + _loc2_;
         this._sprite.addChild(this._board4);
         this._board4.scaleX = -1;
         this._board4.scaleY = -1;
         this._btnClose = new Button(GV.assets.getTexture("Btn_close0000"));
         this._btnClose.x = GV.cent_X + 140;
         this._btnClose.y = _loc3_ - 200;
         this._sprite.addChild(this._btnClose);
         this._nameTxt = new TextField(150,30,"Cheats");
         this._nameTxt.format.setTo("PUTIN",22,16777215,"center");
         this._nameTxt.x = GV.cent_X - this._nameTxt.width / 2;
         this._nameTxt.y = this._board1.y - 170;
         this._sprite.addChild(this._nameTxt);
         this._nameTxt.touchable = false;
         _loc3_ = GV.cent_Y - 120;
         var _loc4_:int = GV.cent_X - 220;
         var _loc7_:int = 0;
         this._name_level_Txt = new TextField(200,30,"Game_Stage:");
         this._name_level_Txt.format.setTo("PUTIN",22,3351315,"right");
         this._name_level_Txt.x = _loc4_ - 30;
         this._name_level_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._name_level_Txt);
         this._name_level_Txt.touchable = false;
         this._levelTxt = new TextField(200,30,"0");
         this._levelTxt.format.setTo("PUTIN",22,16761856,"center");
         this._levelTxt.x = _loc4_ + 190;
         this._levelTxt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._levelTxt);
         this._levelTxt.touchable = false;
         this._btn_level_up = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_level_up.x = _loc4_ + 350;
         this._btn_level_up.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_level_up.scale = 0.8;
         this._sprite.addChild(this._btn_level_up);
         this._btn_level_down = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_level_down.x = _loc4_ + 230;
         this._btn_level_down.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_level_down.scaleY = 0.8;
         this._btn_level_down.scaleX = -0.8;
         this._sprite.addChild(this._btn_level_down);
         _loc7_ = 1;
         this._name_coin_Txt = new TextField(200,30,"Coins:");
         this._name_coin_Txt.format.setTo("PUTIN",22,3351315,"right");
         this._name_coin_Txt.x = _loc4_ - 30;
         this._name_coin_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._name_coin_Txt);
         this._name_coin_Txt.touchable = false;
         this._coin_Txt = new TextField(200,30,"0");
         this._coin_Txt.format.setTo("PUTIN",22,16761856,"center");
         this._coin_Txt.x = _loc4_ + 190;
         this._coin_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._coin_Txt);
         this._coin_Txt.touchable = false;
         this._btn_coin_up = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_coin_up.x = _loc4_ + 350;
         this._btn_coin_up.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_coin_up.scale = 0.8;
         this._sprite.addChild(this._btn_coin_up);
         this._btn_coin_down = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_coin_down.x = _loc4_ + 230;
         this._btn_coin_down.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_coin_down.scaleY = 0.8;
         this._btn_coin_down.scaleX = -0.8;
         this._sprite.addChild(this._btn_coin_down);
         _loc7_ = 2;
         this._name_hero_Txt = new TextField(200,30,"Hero_Level:");
         this._name_hero_Txt.format.setTo("PUTIN",22,3351315,"right");
         this._name_hero_Txt.x = _loc4_ - 30;
         this._name_hero_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._name_hero_Txt);
         this._name_hero_Txt.touchable = false;
         this._hero_Txt = new TextField(200,30,"0");
         this._hero_Txt.format.setTo("PUTIN",22,16761856,"center");
         this._hero_Txt.x = _loc4_ + 190;
         this._hero_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._hero_Txt);
         this._hero_Txt.touchable = false;
         this._btn_hero_up = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_hero_up.x = _loc4_ + 350;
         this._btn_hero_up.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_hero_up.scale = 0.8;
         this._sprite.addChild(this._btn_hero_up);
         this._btn_hero_down = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_hero_down.x = _loc4_ + 230;
         this._btn_hero_down.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_hero_down.scaleY = 0.8;
         this._btn_hero_down.scaleX = -0.8;
         this._sprite.addChild(this._btn_hero_down);
         _loc7_ = 3;
         this._name_cat_Txt = new TextField(200,30,"Cat_Level:");
         this._name_cat_Txt.format.setTo("PUTIN",22,3351315,"right");
         this._name_cat_Txt.x = _loc4_ - 30;
         this._name_cat_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._name_cat_Txt);
         this._name_cat_Txt.touchable = false;
         this._cat_Txt = new TextField(200,30,"0");
         this._cat_Txt.format.setTo("PUTIN",22,16761856,"center");
         this._cat_Txt.x = _loc4_ + 190;
         this._cat_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._cat_Txt);
         this._cat_Txt.touchable = false;
         this._btn_cat_up = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_cat_up.x = _loc4_ + 350;
         this._btn_cat_up.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_cat_up.scale = 0.8;
         this._sprite.addChild(this._btn_cat_up);
         this._btn_cat_down = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_cat_down.x = _loc4_ + 230;
         this._btn_cat_down.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_cat_down.scaleY = 0.8;
         this._btn_cat_down.scaleX = -0.8;
         this._sprite.addChild(this._btn_cat_down);
         _loc7_ = 4;
         this._name_god_Txt = new TextField(200,30,"God_Mode:");
         this._name_god_Txt.format.setTo("PUTIN",22,3351315,"right");
         this._name_god_Txt.x = _loc4_ - 30;
         this._name_god_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._name_god_Txt);
         this._name_god_Txt.touchable = false;
         this._god_Txt = new TextField(200,30,"0");
         this._god_Txt.format.setTo("PUTIN",22,16761856,"center");
         this._god_Txt.x = _loc4_ + 190;
         this._god_Txt.y = _loc3_ + 50 * _loc7_;
         this._sprite.addChild(this._god_Txt);
         this._god_Txt.touchable = false;
         this._btn_god_up = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_god_up.x = _loc4_ + 350;
         this._btn_god_up.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_god_up.scale = 0.8;
         this._sprite.addChild(this._btn_god_up);
         this._btn_god_down = new Button(GV.assets.getTexture("BtnArrow" + "0000"));
         this._btn_god_down.x = _loc4_ + 230;
         this._btn_god_down.y = _loc3_ + 50 * _loc7_ - 5;
         this._btn_god_down.scaleY = 0.8;
         this._btn_god_down.scaleX = -0.8;
         this._sprite.addChild(this._btn_god_down);
         this.update_Date();
      }
      
      private function update_Date() : void
      {
         GV.curExp = [0,0];
         if(GV.gameLevel > 51)
         {
            GV.location = 5;
         }
         else if(GV.gameLevel > 35)
         {
            GV.location = 4;
         }
         else if(GV.gameLevel > 27)
         {
            GV.location = 3;
         }
         else if(GV.gameLevel > 16)
         {
            GV.location = 2;
         }
         else
         {
            GV.location = 1;
         }
         this._levelTxt.text = "" + (GV.gameLevel + 1);
         this._coin_Txt.text = Amath.rounding(GV.coins);
         this._hero_Txt.text = GV.levels[0];
         this._cat_Txt.text = GV.levels[1];
         this._god_Txt.text = "" + GV.godMode;
      }
      
      override public function translate() : void
      {
      }
   }
}
