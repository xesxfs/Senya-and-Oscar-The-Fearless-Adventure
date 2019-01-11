package com.mygame.screens
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenMap extends ScrBase
   {
       
      
      private var back:Image;
      
      private var flag:MovieClip;
      
      private var _btnToBattle:Button;
      
      private var _btnSettings:Button;
      
      private var _btnCredits:Button;
      
      private var _btnArmor:Button;
      
      private var _btnTreasury:Button;
      
      private var _btnForge:Button;
      
      private var _btnGoogle:Button;
      
      private var _indic1:MovieClip;
      
      private var _indic2:MovieClip;
      
      private var _txt1:TextField;
      
      private var _txt2:TextField;
      
      private var _txt3:TextField;
      
      private var _txt4:TextField;
      
      private var px:Array;
      
      private var py:Array;
      
      public function ScreenMap()
      {
         this.px = [353,380,370,351,330,367,402,431,462,500,538,575,614,650,723,755,786,762,756,733,702,674,676,666,633,603,571,540,506,477,442,411,418,451,484,513,573,606,806,776,740,705,630,643,670,702,735,765,796,827,881,904,913,903,897,893,898,918,948,978,1004,1009];
         this.py = [332,343,368,393,411,417,406,388,380,381,384,387,389,390,416,411,402,323,301,286,277,278,305,328,329,321,309,296,278,263,254,245,226,223,219,210,150,144,129,137,144,149,174,189,197,201,204,206,208,210,215,227,242,257,277,312,335,351,360,357,344,290];
         super();
         this.draw();
         GV.game.addChildAt(this,0);
         this.activation();
      }
      
      override public function activation() : void
      {
         if(this._btnToBattle)
         {
            this._btnToBattle.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnArmor)
         {
            this._btnArmor.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnTreasury)
         {
            this._btnTreasury.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnSettings)
         {
            this._btnSettings.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnForge)
         {
            this._btnForge.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnCredits)
         {
            this._btnCredits.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnGoogle)
         {
            this._btnGoogle.addEventListener(Event.TRIGGERED,this.touch_btns);
         }
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         if(this._btnToBattle)
         {
            this._btnToBattle.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnArmor)
         {
            this._btnArmor.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnTreasury)
         {
            this._btnTreasury.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnSettings)
         {
            this._btnSettings.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnForge)
         {
            this._btnForge.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnCredits)
         {
            this._btnCredits.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         if(this._btnGoogle)
         {
            this._btnCredits.removeEventListener(Event.TRIGGERED,this.touch_btns);
         }
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function free() : void
      {
         super.free();
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         GV.juggler.advanceTime(param1.passedTime);
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnToBattle)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Game",false);
         }
         if(_loc2_ as Button == this._btnCredits)
         {
            GV.sound.playSFX("click");
            GV.game.SM.open_screen("Credits");
         }
         if(_loc2_ as Button == this._btnArmor)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Armor",false);
         }
         if(_loc2_ as Button == this._btnTreasury)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Treasury",false);
         }
         if(_loc2_ as Button == this._btnSettings)
         {
            GV.sound.playSFX("click");
            GV.game.SM.open_screen("Settings");
         }
         if(_loc2_ as Button == this._btnForge)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Forge",false);
         }
         if(_loc2_ as Button == this._btnGoogle)
         {
            GV.sound.playSFX("click");
            navigateToURL(new URLRequest("https://play.google.com/store/apps/details?id=air.dennatolich.senyaandoscar"));
         }
      }
      
      override public function draw() : void
      {
         var _loc1_:Image = null;
         this.back = new Image(GV.assets.getTexture("Map"));
         this.back.x = int(GV.cent_X - this.back.width / 2);
         this.back.y = int(GV.cent_Y - this.back.height / 2);
         addChild(this.back);
         this._btnToBattle = new Button(GV.assets.getTexture("btn_start" + "0000"));
         this._btnToBattle.x = int(GV.scr_X - this._btnToBattle.width - 20);
         this._btnToBattle.y = int(GV.scr_Y - this._btnToBattle.height - 15);
         addChild(this._btnToBattle);
         this._btnSettings = new Button(GV.assets.getTexture("BtnSettings" + "0000"));
         this._btnSettings.x = int(GV.scr_X - this._btnSettings.width - 20);
         this._btnSettings.y = 15;
         addChild(this._btnSettings);
         this._btnCredits = new Button(GV.assets.getTexture("BtnCredits" + "0000"));
         this._btnCredits.x = int(this._btnSettings.x - this._btnCredits.width - 20);
         this._btnCredits.y = 15;
         addChild(this._btnCredits);
         this._btnGoogle = new Button(GV.assets.getTexture("Btn_Google" + "0000"));
         this._btnGoogle.x = 150;
         this._btnGoogle.y = 15;
         addChild(this._btnGoogle);
         if(GV.gameLevel < 5)
         {
            this._btnGoogle.visible = false;
         }
         this._btnArmor = new Button(GV.assets.getTexture("Btn_armory" + "0000"));
         this._btnArmor.x = int(20);
         this._btnArmor.y = int(GV.scr_Y - this._btnArmor.height - 15);
         addChild(this._btnArmor);
         if(GV.gameLevel < 2)
         {
            this._btnArmor.visible = false;
         }
         this._btnTreasury = new Button(GV.assets.getTexture("Btn_treasury" + "0000"));
         this._btnTreasury.x = int(20 + this._btnArmor.width + 20);
         this._btnTreasury.y = int(GV.scr_Y - this._btnTreasury.height - 15);
         addChild(this._btnTreasury);
         if(GV.treasury_keys != 0)
         {
            GV.isTreasure = true;
         }
         this._btnTreasury.visible = GV.isTreasure;
         this._btnForge = new Button(GV.assets.getTexture("Btn_forge" + "0000"));
         this._btnForge.x = int(this._btnTreasury.x + this._btnTreasury.width + 20);
         this._btnForge.y = int(GV.scr_Y - this._btnTreasury.height - 15);
         addChild(this._btnForge);
         if(GV.crystals >= 3)
         {
            GV.isForge = true;
         }
         this._btnForge.visible = GV.isForge;
         if(GV.treasury_keys > 0 || GV.treasury_openArr.length > 0)
         {
            this._indic1 = new MovieClip(GV.assets.getTextures("Indicator"),6);
            this._indic1.x = 50;
            this._indic1.y = -10;
            this._btnTreasury.overlay.addChild(this._indic1);
            GV.juggler.add(this._indic1);
            this._indic1.play();
         }
         if(GV.crystals >= 3)
         {
            this._indic2 = new MovieClip(GV.assets.getTextures("Indicator"),6);
            this._indic2.x = 50;
            this._indic2.y = -10;
            this._btnForge.overlay.addChild(this._indic2);
            GV.juggler.add(this._indic2);
            this._indic2.play();
         }
         this.flag = new MovieClip(GV.assets.getTextures("ProgressFlag"),12);
         if(GV.gameLevel <= this.px.length - 1)
         {
            this.flag.x = this.back.x + this.px[GV.gameLevel];
         }
         if(GV.gameLevel <= this.py.length - 1)
         {
            this.flag.y = this.back.y + this.py[GV.gameLevel];
         }
         addChild(this.flag);
         GV.juggler.add(this.flag);
         _loc1_ = new Image(GV.assets.getTexture("IcCoin0000"));
         _loc1_.x = 20;
         _loc1_.y = 10;
         addChild(_loc1_);
         var _loc2_:Image = new Image(GV.assets.getTexture("IcCrystal0000"));
         _loc2_.x = 20;
         _loc2_.y = 45;
         addChild(_loc2_);
         var _loc3_:Image = new Image(GV.assets.getTexture("IcKey0000"));
         _loc3_.x = 20;
         _loc3_.y = 80;
         addChild(_loc3_);
         var _loc4_:TextField = new TextField(300,30,"" + GV.coins,new TextFormat("FontGoldExport",27,16777215,Align.LEFT));
         _loc4_.x = _loc1_.x + 40;
         _loc4_.y = _loc1_.y - 5;
         _loc4_.touchable = false;
         addChild(_loc4_);
         var _loc5_:TextField = new TextField(300,30,"" + GV.crystals,new TextFormat("FontSilverExport",27,16777215,Align.LEFT));
         _loc5_.x = _loc2_.x + 40;
         _loc5_.y = _loc2_.y - 5;
         _loc5_.touchable = false;
         addChild(_loc5_);
         var _loc6_:TextField = new TextField(300,30,"" + GV.treasury_keys,new TextFormat("FontSilverExport",27,16777215,Align.LEFT));
         _loc6_.x = _loc3_.x + 40;
         _loc6_.y = _loc3_.y - 5;
         _loc6_.touchable = false;
         addChild(_loc6_);
         this._txt1 = new TextField(200,40,"ARMORY",new TextFormat("FontSilverExport",25,16777215,Align.CENTER));
         this._txt1.x = -60;
         this._txt1.y = 50;
         this._btnArmor.overlay.addChild(this._txt1);
         this._txt1.touchable = false;
         this._txt2 = new TextField(200,40,"",new TextFormat("FontSilverExport",25,16777215,Align.CENTER));
         this._txt2.x = -60;
         this._txt2.y = 50;
         this._btnTreasury.overlay.addChild(this._txt2);
         this._txt2.touchable = false;
         this._txt3 = new TextField(200,40,"",new TextFormat("FontSilverExport",25,16777215,Align.CENTER));
         this._txt3.x = -60;
         this._txt3.y = 50;
         this._btnForge.overlay.addChild(this._txt3);
         this._txt3.touchable = false;
         this._txt4 = new TextField(200,40,"",new TextFormat("FontSilverExport",30,16777215,Align.CENTER));
         this._txt4.x = -60;
         this._txt4.y = 56;
         this._btnToBattle.overlay.addChild(this._txt4);
         this._txt4.touchable = false;
         this.translate();
         this.ShopFree();
         this.ShopGenerator();
         GV.save.localSave();
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this._txt1.text = "ARMORY";
            this._txt2.text = "TREASURY";
            this._txt3.text = "FORGE";
            this._txt4.text = "BATTLE";
         }
         if(GV.settings[2] == 2)
         {
            this._txt1.text = "АРСЕНАЛ";
            this._txt2.text = "СОКРОВИЩЕ";
            this._txt3.text = "КУЗНИЦА";
            this._txt4.text = "В БОЙ";
         }
      }
      
      public function ShopFree() : void
      {
         var _loc1_:int = GV.shop.length - 1;
         while(_loc1_ >= 0)
         {
            if(GV.equipment[GV.shop[_loc1_][0] - 1] != null)
            {
               if(GV.shop[_loc1_][2].lvl < GV.shopIndex[GV.shop[_loc1_][0] - 1])
               {
                  GV.shop[_loc1_] = null;
                  GV.shop.splice(_loc1_,1);
               }
            }
            _loc1_--;
         }
      }
      
      public function ShopGenerator() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < GV.shop.length)
            {
               if(GV.shop[_loc3_][0] == _loc1_ + 1 && GV.shop[_loc3_][2].lvl == GV.shopIndex[_loc1_] + 1)
               {
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
            if(_loc2_ == false)
            {
               GV.game.LootM.create_item(_loc1_ + 1,0,GV.shopIndex[_loc1_] + 1);
               GV.shop.push(GV.game.LootM._arr);
            }
            _loc2_ = false;
            _loc3_ = 0;
            while(_loc3_ < GV.shop.length)
            {
               if(GV.shop[_loc3_][0] == _loc1_ + 1 && GV.shop[_loc3_][2].lvl == GV.shopIndex[_loc1_] + 2)
               {
                  _loc2_ = true;
                  break;
               }
               _loc3_++;
            }
            if(_loc2_ == false)
            {
               GV.game.LootM.create_item(_loc1_ + 1,0,GV.shopIndex[_loc1_] + 2);
               GV.shop.push(GV.game.LootM._arr);
            }
            _loc1_++;
         }
      }
   }
}
