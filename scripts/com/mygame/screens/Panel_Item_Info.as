package com.mygame.screens
{
   import com.general.Amath;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFieldAutoSize;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Panel_Item_Info extends Sprite
   {
       
      
      private var _back:Quad;
      
      private var _sprite:Sprite;
      
      private var _panel_1:Image;
      
      private var _panel_2:Image;
      
      private var _icon:Image;
      
      private var _iconBack:Image;
      
      private var _btnClose:Button;
      
      private var _btnSell:Button;
      
      private var _btnEquip:Button;
      
      private var _btnUnEquip:Button;
      
      private var _btnBuy:Button;
      
      private var _sellTxt:TextField;
      
      private var _equipTxt:TextField;
      
      private var _unequipTxt:TextField;
      
      private var _buyTxt:TextField;
      
      private var _posY:int;
      
      private var _nameTexture:String;
      
      private var _index:int;
      
      private var _location:String;
      
      private var coinImg:Image;
      
      private var _priceTxt:TextField;
      
      private var _typeTxt:TextField;
      
      private var _typeArr1;
      
      private var _typeArr2;
      
      private var _wordsArr1;
      
      private var _wordsArr2;
      
      private var _descrTxt_1:TextField;
      
      private var _descrTxt_2:TextField;
      
      private var _descrTxt_3:TextField;
      
      private var _descrTxt_4:TextField;
      
      private var _descrTxt_5:TextField;
      
      private var _delta_1:TextField;
      
      private var _delta_2:TextField;
      
      private var _delta_3:TextField;
      
      private var _delta_4:TextField;
      
      private var _delta_5:TextField;
      
      private var t:int;
      
      public function Panel_Item_Info()
      {
         this._typeArr1 = ["Common","Rare","Legendary","Unommon"];
         this._typeArr2 = ["Обычный","Редкий","Легендарный","Необычный"];
         this._wordsArr1 = ["Type: ","Damage: ","Crit: ","Defense: ","Defense: ","Extra Loot: ","Expirience: "];
         this._wordsArr2 = ["Тип: ","Урон: ","Крит: ","Защита: ","Защита: ","Экстра Лут: ","Опыт: "];
         super();
      }
      
      public function Init() : *
      {
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         this._back.alpha = 0.7;
         addChild(this._back);
         this._sprite = new Sprite();
         addChild(this._sprite);
         this._posY = GV.cent_Y - 150;
         this._panel_1 = new Image(GV.assets.getTexture("PanelItem0000"));
         this._panel_1.x = GV.cent_X - 195;
         this._panel_1.y = this._posY;
         this._sprite.addChild(this._panel_1);
         this._panel_2 = new Image(GV.assets.getTexture("PanelItem0000"));
         this._panel_2.x = GV.cent_X + 195;
         this._panel_2.y = this._posY;
         this._panel_2.scaleX = -1;
         this._sprite.addChild(this._panel_2);
         this._btnClose = new Button(GV.assets.getTexture("Btn_close0000"));
         this._btnClose.x = GV.cent_X + 160;
         this._btnClose.y = this._posY - 10;
         this._sprite.addChild(this._btnClose);
         this._btnClose.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnSell = new Button(GV.assets.getTexture("BtnSell0000"));
         this._btnSell.x = GV.cent_X - 100 - this._btnSell.width / 2;
         this._btnSell.y = this._posY + 250;
         this._sprite.addChild(this._btnSell);
         this._btnSell.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnEquip = new Button(GV.assets.getTexture("BtnEquip0000"));
         this._btnEquip.x = GV.cent_X + 100 - this._btnEquip.width / 2;
         this._btnEquip.y = this._posY + 250;
         this._sprite.addChild(this._btnEquip);
         this._btnEquip.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnUnEquip = new Button(GV.assets.getTexture("BtnUnEquip0000"));
         this._btnUnEquip.x = GV.cent_X + 100 - this._btnEquip.width / 2;
         this._btnUnEquip.y = this._posY + 250;
         this._sprite.addChild(this._btnUnEquip);
         this._btnUnEquip.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btnBuy = new Button(GV.assets.getTexture("BtnBuy0000"));
         this._btnBuy.x = GV.cent_X - this._btnEquip.width / 2;
         this._btnBuy.y = this._posY + 250;
         this._sprite.addChild(this._btnBuy);
         this._btnBuy.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._sellTxt = new TextField(120,40,"",new TextFormat("PUTIN",23,16777215,Align.CENTER));
         this._sellTxt.x = 30;
         this._sellTxt.y = 15;
         this._sellTxt.touchable = false;
         this._btnSell.overlay.addChild(this._sellTxt);
         this._equipTxt = new TextField(120,40,"",new TextFormat("PUTIN",23,16777215,Align.CENTER));
         this._equipTxt.x = 30;
         this._equipTxt.y = 15;
         this._equipTxt.touchable = false;
         this._btnEquip.overlay.addChild(this._equipTxt);
         this._unequipTxt = new TextField(120,40,"",new TextFormat("PUTIN",23,16777215,Align.CENTER));
         this._unequipTxt.x = 30;
         this._unequipTxt.y = 15;
         this._unequipTxt.touchable = false;
         this._btnUnEquip.overlay.addChild(this._unequipTxt);
         this._buyTxt = new TextField(120,40,"",new TextFormat("PUTIN",23,16777215,Align.CENTER));
         this._buyTxt.x = 15;
         this._buyTxt.y = 15;
         this._buyTxt.touchable = false;
         this._btnBuy.overlay.addChild(this._buyTxt);
         this._iconBack = new Image(GV.assets.getTexture("CellBack0000"));
         this._iconBack.x = GV.cent_X - 175;
         this._iconBack.y = this._posY + 20;
         this._sprite.addChild(this._iconBack);
         this._icon = new Image(GV.assets.getTexture("IconWeapon0000"));
         this._icon.x = GV.cent_X - 175;
         this._icon.y = this._posY + 20;
         this._sprite.addChild(this._icon);
         this.coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this.coinImg.x = GV.cent_X - 90;
         this.coinImg.y = this._posY + 65;
         addChild(this.coinImg);
         this._priceTxt = new TextField(300,30,"",new TextFormat("PUTIN",20,16754211,Align.LEFT));
         this._priceTxt.x = this.coinImg.x + 35;
         this._priceTxt.y = this.coinImg.y + 0;
         this._priceTxt.touchable = false;
         addChild(this._priceTxt);
         this._typeTxt = new TextField(300,30,"Type: Common",new TextFormat("PUTIN",20,16777215,Align.LEFT));
         this._typeTxt.x = GV.cent_X - 90;
         this._typeTxt.y = this._posY + 25;
         this._typeTxt.touchable = false;
         addChild(this._typeTxt);
         var _loc1_:int = 1;
         while(_loc1_ <= 5)
         {
            this["_descrTxt_" + _loc1_] = new TextField(340,30,"",new TextFormat("PUTIN",18,16777215,Align.CENTER,Align.CENTER));
            this["_descrTxt_" + _loc1_].x = GV.cent_X - 170;
            this["_descrTxt_" + _loc1_].y = this._posY + 70 + 30 * _loc1_;
            this["_descrTxt_" + _loc1_].touchable = false;
            addChild(this["_descrTxt_" + _loc1_]);
            this["_descrTxt_" + _loc1_].autoSize = TextFieldAutoSize.HORIZONTAL;
            this["_delta_" + _loc1_] = new TextField(340,30,"",new TextFormat("PUTIN",18,16777215,Align.CENTER,Align.CENTER));
            this["_delta_" + _loc1_].x = GV.cent_X - 170;
            this["_delta_" + _loc1_].y = this._posY + 70 + 30 * _loc1_;
            this["_delta_" + _loc1_].touchable = false;
            addChild(this["_delta_" + _loc1_]);
            this["_delta_" + _loc1_].autoSize = TextFieldAutoSize.HORIZONTAL;
            _loc1_++;
         }
         this.translate();
      }
      
      public function activation(param1:int, param2:String) : void
      {
         var _loc6_:Number = NaN;
         GV.sound.playSFX("info");
         this.visible = true;
         this._location = param2;
         this._index = param1;
         this._typeTxt.text = this["_wordsArr" + GV.settings[2]][0] + this["_typeArr" + GV.settings[2]][GV[this._location][param1][2].type];
         var _loc3_:int = GV[this._location][param1][2].price;
         if(this._location != "shop" && this._location != "potions")
         {
            _loc6_ = 0.5;
         }
         else
         {
            _loc6_ = 1;
         }
         this._priceTxt.text = Amath.rounding(_loc3_ * _loc6_);
         this._iconBack.texture = GV.assets.getTexture("CellBack000" + GV[this._location][param1][2].type);
         if(GV[this._location][param1][1] < 10)
         {
            this._nameTexture = "000" + GV[this._location][param1][1];
         }
         else
         {
            this._nameTexture = "00" + GV[this._location][param1][1];
         }
         switch(GV[this._location][param1][0])
         {
            case 1:
               this._nameTexture = "IconWeapon" + this._nameTexture;
               break;
            case 2:
               this._nameTexture = "IconShield" + this._nameTexture;
               break;
            case 3:
               this._nameTexture = "IconHelmet" + this._nameTexture;
               break;
            case 4:
               this._nameTexture = "IconArmor" + this._nameTexture;
               break;
            case 5:
               this._nameTexture = "IconBoots" + this._nameTexture;
               break;
            case 6:
               this._nameTexture = "IconPotion1_" + this._nameTexture;
               break;
            case 7:
               this._nameTexture = "IconPotion2_" + this._nameTexture;
               break;
            case 8:
               this._nameTexture = "IconPotion3_" + this._nameTexture;
         }
         this._icon.texture = GV.assets.getTexture(this._nameTexture);
         switch(this._location)
         {
            case "inventory":
               this._btnUnEquip.visible = false;
               this._btnBuy.visible = false;
               this._btnEquip.visible = true;
               this._btnSell.visible = true;
               break;
            case "equipment":
               this._btnEquip.visible = false;
               this._btnBuy.visible = false;
               this._btnUnEquip.visible = true;
               this._btnSell.visible = true;
               break;
            case "shop":
               this._btnUnEquip.visible = false;
               this._btnSell.visible = false;
               this._btnEquip.visible = false;
               if(GV.coins >= GV[this._location][this._index][2].price)
               {
                  this._btnBuy.visible = true;
                  break;
               }
               this._btnBuy.visible = false;
               break;
            case "potions":
               this._btnUnEquip.visible = false;
               this._btnSell.visible = false;
               this._btnEquip.visible = false;
               if(GV.coins >= GV[this._location][this._index][2].price)
               {
                  this._btnBuy.visible = true;
                  break;
               }
               this._btnBuy.visible = false;
               break;
            case "bag":
               this._btnUnEquip.visible = false;
               this._btnBuy.visible = false;
               this._btnEquip.visible = false;
               this._btnSell.visible = true;
         }
         var _loc4_:int = 1;
         while(_loc4_ <= 5)
         {
            this["_descrTxt_" + _loc4_].text = "";
            this["_delta_" + _loc4_].text = "";
            _loc4_++;
         }
         this.t = 1;
         this.check_attribute("power",1);
         this.check_attribute("crit",2);
         this.check_attribute("block",3);
         this.check_attribute("def",4);
         this.check_attribute("coin",5);
         this.check_attribute("exp",6);
         var _loc5_:int = 150 / this.t;
         _loc4_ = 1;
         while(_loc4_ < this.t)
         {
            this["_delta_" + _loc4_].y = this["_descrTxt_" + _loc4_].y = this._posY + 70 + _loc5_ * _loc4_;
            _loc4_++;
         }
      }
      
      private function check_attribute(param1:String, param2:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(GV[this._location][this._index][2][param1])
         {
            _loc3_ = GV[this._location][this._index][2][param1];
            _loc4_ = GV[this._location][this._index][0];
            this["_descrTxt_" + this.t].text = this["_wordsArr" + GV.settings[2]][param2] + _loc3_;
            if(param1 == "coin" || param1 == "exp")
            {
               this["_descrTxt_" + this.t].text = "+" + this["_descrTxt_" + this.t].text + "%";
            }
            if(param1 == "crit")
            {
               this["_descrTxt_" + this.t].text = this["_descrTxt_" + this.t].text + "%";
            }
            if((this._location == "inventory" || this._location == "shop") && param1 != "coin" && param1 != "exp")
            {
               if(GV.equipment[_loc4_ - 1] == null)
               {
                  _loc5_ = 0;
               }
               else if(GV.equipment[_loc4_ - 1][2][param1])
               {
                  _loc5_ = GV.equipment[_loc4_ - 1][2][param1];
               }
               else
               {
                  _loc5_ = 0;
               }
               this["_delta_" + this.t].text = " (";
               if(_loc3_ >= _loc5_)
               {
                  this["_delta_" + this.t].text = this["_delta_" + this.t].text + ("+" + int(_loc3_ - _loc5_) + ")");
                  this["_delta_" + this.t].format.color = 3918080;
               }
               else
               {
                  this["_delta_" + this.t].text = this["_delta_" + this.t].text + (int(_loc3_ - _loc5_) + ")");
                  this["_delta_" + this.t].format.color = 6558988;
               }
            }
            this["_descrTxt_" + this.t].x = GV.cent_X - this["_descrTxt_" + this.t].width / 2 - 20;
            this["_delta_" + this.t].x = this["_descrTxt_" + this.t].x + this["_descrTxt_" + this.t].width;
            this.t++;
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:Boolean = false;
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnClose)
         {
            GV.sound.playSFX("click");
            this.visible = false;
         }
         if(_loc2_ as Button == this._btnUnEquip)
         {
            this.visible = false;
            GV.sound.playSFX("equip");
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < GV[this._location][this._index].length)
            {
               _loc3_.push(GV[this._location][this._index][_loc4_]);
               _loc4_++;
            }
            GV.game.SM.screen["panel_1"].AddItem(_loc3_);
            GV.game.SM.screen["_panel_equipment"].Remove(this._index);
         }
         if(_loc2_ as Button == this._btnEquip)
         {
            this.visible = false;
            GV.sound.playSFX("equip");
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < GV[this._location][this._index].length)
            {
               _loc3_.push(GV[this._location][this._index][_loc4_]);
               _loc4_++;
            }
            if(_loc3_[2].lvl > GV.shopIndex[_loc3_[0] - 1])
            {
               GV.shopIndex[_loc3_[0] - 1] = _loc3_[2].lvl;
            }
            GV.game.SM.screen["panel_1"].Remove(this._index);
            GV.game.SM.screen["_panel_equipment"].AddItem(_loc3_);
         }
         if(_loc2_ as Button == this._btnSell)
         {
            GV.sound.playSFX("sell");
            this.visible = false;
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < GV[this._location][this._index].length)
            {
               _loc3_.push(GV[this._location][this._index][_loc4_]);
               _loc4_++;
            }
            GV.coins = GV.coins + int(GV[this._location][this._index][2].price * 0.5);
            GV.game.SM.screen["updateData"]();
            switch(this._location)
            {
               case "inventory":
                  GV.game.SM.screen["panel_1"].Remove(this._index);
                  GV.game.SM.screen["panel_2"].AddItem(_loc3_);
                  break;
               case "equipment":
                  GV.game.SM.screen["_panel_equipment"].Remove(this._index);
                  GV.game.SM.screen["panel_2"].AddItem(_loc3_);
                  break;
               case "bag":
                  GV.game.SM.screen["_panel_catBag"].Remove(this._index);
                  GV.game.SM.screen["panel_3"].AddItem(_loc3_);
            }
         }
         if(_loc2_ as Button == this._btnBuy)
         {
            if(GV[this._location][this._index][2].price <= GV.coins)
            {
               GV.sound.playSFX("buy");
               if(this._location == "potions")
               {
                  _loc5_ = false;
                  _loc4_ = 0;
                  while(_loc4_ < GV.bag.length)
                  {
                     if(GV.bag[_loc4_] == null)
                     {
                        _loc5_ = true;
                        break;
                     }
                     _loc4_++;
                  }
                  if(_loc5_ == false)
                  {
                     return;
                  }
               }
               GV.coins = GV.coins - GV[this._location][this._index][2].price;
               GV.game.SM.screen["updateData"]();
               this.visible = false;
               _loc3_ = [];
               _loc4_ = 0;
               while(_loc4_ < GV[this._location][this._index].length)
               {
                  _loc3_.push(GV[this._location][this._index][_loc4_]);
                  _loc4_++;
               }
               switch(this._location)
               {
                  case "shop":
                     if(_loc3_[2].lvl > GV.shopIndex[_loc3_[0] - 1])
                     {
                        GV.shopIndex[_loc3_[0] - 1] = _loc3_[2].lvl;
                     }
                     _loc3_[2].open = 0;
                     GV.game.SM.screen["panel_1"].AddItem(_loc3_);
                     GV.game.SM.screen["panel_2"].Remove(this._index);
                     break;
                  case "potions":
                     GV.game.SM.screen["_panel_catBag"].AddItem(_loc3_);
                     GV.game.SM.screen["panel_3"].Remove(this._index);
               }
            }
         }
      }
      
      public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this._sellTxt.text = "Sell";
            this._equipTxt.text = "Equip";
            this._unequipTxt.text = "Take off";
            this._buyTxt.text = "Buy";
         }
         if(GV.settings[2] == 2)
         {
            this._sellTxt.text = "Продать";
            this._equipTxt.text = "Надеть";
            this._unequipTxt.text = "Снять";
            this._buyTxt.text = "Купить";
         }
      }
   }
}
