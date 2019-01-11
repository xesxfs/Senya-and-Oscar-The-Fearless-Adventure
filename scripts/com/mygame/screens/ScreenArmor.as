package com.mygame.screens
{
   import com.general.Amath;
   import starling.display.Button;
   import starling.display.Image;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.textures.Texture;
   import starling.utils.Align;
   
   public class ScreenArmor extends ScrBase
   {
       
      
      private var _btnQuit:Button;
      
      private var coinImg:Image;
      
      private var coinTxt:TextField;
      
      private var _btn1:Button;
      
      private var _btn2:Button;
      
      private var _btn3:Button;
      
      public var panel_1:Panel_Inventory;
      
      public var panel_2:Panel_Shop;
      
      public var panel_3:Panel_Potions;
      
      public var _panel_equipment:Panel_Equipment;
      
      public var _panel_catBag:Panel_CatBag;
      
      private var _state:String = "inventory";
      
      private var _itemInfo:Panel_Item_Info;
      
      public function ScreenArmor()
      {
         super();
         this.draw();
         GV.game.addChildAt(this,0);
         this.activation();
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn1.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn2.addEventListener(Event.TRIGGERED,this.touch_btns);
         this._btn3.addEventListener(Event.TRIGGERED,this.touch_btns);
         this.updateData();
      }
      
      override public function deactivation() : void
      {
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
            GV.sound.playSFX("click");
            GV.game.SM.transition_screen("Map",false);
         }
         if(_loc2_ as Button == this._btn1)
         {
            GV.sound.playSFX("click");
            if(this._state != "inventory")
            {
               this.unSelectButton();
               this._btn1.upState = this._btn1.downState = GV.assets.getTexture("BtnInventory_" + "0000");
               this._itemInfo.visible = false;
               this.panel_2.visible = false;
               this.panel_3.visible = false;
               this._panel_catBag.visible = false;
               this._panel_equipment.visible = true;
               this.panel_1.Activate();
               this._state = "inventory";
            }
         }
         if(_loc2_ as Button == this._btn2)
         {
            GV.sound.playSFX("click");
            if(this._state != "shop")
            {
               this.unSelectButton();
               this._btn2.upState = this._btn2.downState = GV.assets.getTexture("BtnInventory_" + "0000");
               this._itemInfo.visible = false;
               this.panel_1.visible = false;
               this.panel_3.visible = false;
               this._panel_catBag.visible = false;
               this._panel_equipment.visible = true;
               this.panel_2.Activate();
               this._state = "shop";
            }
         }
         if(_loc2_ as Button == this._btn3)
         {
            GV.sound.playSFX("click");
            if(this._state != "alchimia")
            {
               this.unSelectButton();
               this._btn3.upState = this._btn3.downState = GV.assets.getTexture("BtnInventory_" + "0000");
               this._itemInfo.visible = false;
               this.panel_1.visible = false;
               this.panel_2.visible = false;
               this._panel_equipment.visible = false;
               this.panel_3.visible = true;
               this._panel_catBag.visible = true;
               this._state = "alchimia";
            }
         }
      }
      
      private function unSelectButton() : void
      {
         switch(this._state)
         {
            case "inventory":
               this._btn1.upState = this._btn1.downState = GV.assets.getTexture("BtnInventory_" + "0001");
               this.panel_1.visible = false;
               break;
            case "shop":
               this._btn2.upState = this._btn2.downState = GV.assets.getTexture("BtnInventory_" + "0001");
               break;
            case "alchimia":
               this._btn3.upState = this._btn3.downState = GV.assets.getTexture("BtnInventory_" + "0001");
         }
      }
      
      public function openItemPanel(param1:int, param2:String) : void
      {
         this._itemInfo.activation(param1,param2);
      }
      
      public function updateData() : void
      {
         this.coinTxt.text = Amath.rounding(GV.coins);
         this.panel_2.Chek_Price();
      }
      
      override public function draw() : void
      {
         var _loc1_:Texture = null;
         var _loc2_:Image = null;
         var _loc8_:int = 0;
         var _loc9_:Image = null;
         _loc2_ = new Image(GV.assets.getTexture("Wall"));
         _loc2_.pivotY = 0;
         _loc2_.pivotX = 0;
         _loc2_.x = GV.cent_X - _loc2_.width / 2;
         _loc2_.y = GV.cent_Y - _loc2_.height / 2;
         addChild(_loc2_);
         this._btnQuit = new Button(GV.assets.getTexture("Btn_back" + "0000"));
         this._btnQuit.x = int(GV.scr_X - this._btnQuit.width - 20);
         this._btnQuit.y = 20;
         addChild(this._btnQuit);
         this._btn1 = new Button(GV.assets.getTexture("BtnInventory_" + "0000"));
         this._btn1.x = int(GV.scr_X - this._btn1.width + 15);
         this._btn1.y = this._btnQuit.y + 90;
         addChild(this._btn1);
         var _loc3_:Image = new Image(GV.assets.getTexture("IconBtn1_0000"));
         this._btn1.overlay.addChild(_loc3_);
         _loc3_.touchable = false;
         this._btn2 = new Button(GV.assets.getTexture("BtnInventory_" + "0001"));
         this._btn2.x = int(GV.scr_X - this._btn2.width + 15);
         this._btn2.y = this._btn1.y + 90;
         addChild(this._btn2);
         _loc3_ = new Image(GV.assets.getTexture("IconBtn2_0000"));
         this._btn2.overlay.addChild(_loc3_);
         _loc3_.touchable = false;
         this._btn3 = new Button(GV.assets.getTexture("BtnInventory_" + "0001"));
         this._btn3.x = int(GV.scr_X - this._btn3.width + 15);
         this._btn3.y = this._btn2.y + 90;
         addChild(this._btn3);
         this._btn3.visible = false;
         _loc3_ = new Image(GV.assets.getTexture("IconBtn3_0000"));
         this._btn3.overlay.addChild(_loc3_);
         _loc3_.touchable = false;
         _loc3_.visible = false;
         GV.posX = (GV.scr_X - 200) / 2;
         var _loc5_:int = GV.posX - 2.5 * 80;
         var _loc6_:int = GV.cent_Y - 1.5 * 80;
         _loc1_ = GV.assets.getTexture("EmptyCell0000");
         var _loc7_:int = 0;
         while(_loc7_ < 3)
         {
            _loc8_ = 0;
            while(_loc8_ < 6)
            {
               _loc9_ = new Image(_loc1_);
               _loc9_.x = _loc5_ + _loc8_ * 80;
               _loc9_.y = _loc6_ + _loc7_ * 80;
               addChild(_loc9_);
               _loc8_++;
            }
            _loc7_++;
         }
         this.panel_1 = new Panel_Inventory();
         this.panel_1.Init();
         addChild(this.panel_1);
         this.panel_2 = new Panel_Shop();
         this.panel_2.Init();
         addChild(this.panel_2);
         this.panel_2.visible = false;
         this.panel_3 = new Panel_Potions();
         this.panel_3.Init();
         addChild(this.panel_3);
         this.panel_3.visible = false;
         this._panel_equipment = new Panel_Equipment();
         this._panel_equipment.Init();
         addChild(this._panel_equipment);
         this._panel_catBag = new Panel_CatBag();
         this._panel_catBag.Init();
         addChild(this._panel_catBag);
         this._panel_catBag.visible = false;
         this._itemInfo = new Panel_Item_Info();
         this._itemInfo.Init();
         addChild(this._itemInfo);
         this._itemInfo.visible = false;
         this.coinImg = new Image(GV.assets.getTexture("Coin0000"));
         this.coinImg.x = 20;
         this.coinImg.y = 20;
         addChild(this.coinImg);
         this.coinTxt = new TextField(300,30,GV.coins + "",new TextFormat("PUTIN",25,16754211,Align.LEFT));
         this.coinTxt.x = this.coinImg.x + 35;
         this.coinTxt.y = this.coinImg.y + -3;
         this.coinTxt.touchable = false;
         addChild(this.coinTxt);
      }
   }
}
