package com.mygame.screens
{
   import com.general.Amath;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Cell_inventory extends Sprite
   {
       
      
      private var _img:Button;
      
      private var _nameTexture:String;
      
      public var _index:int;
      
      private var _location:String;
      
      private var priceTxt:TextField;
      
      private var _field:Image = null;
      
      public function Cell_inventory()
      {
         super();
      }
      
      public function Init(param1:*, param2:String) : void
      {
         var _loc4_:int = 0;
         this._index = param1;
         this._location = param2;
         var _loc3_:Image = new Image(GV.assets.getTexture("CellBack000" + GV[this._location][param1][2].type));
         addChild(_loc3_);
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
         this._img = new Button(GV.assets.getTexture(this._nameTexture));
         addChild(this._img);
         this._img.addEventListener(Event.TRIGGERED,this.select);
         if(this._location == "shop" || this._location == "potions" || this._location == "inventory" && GV[this._location][this._index][2].open == 0)
         {
            this._field = new Image(GV.assets.getTexture("PriceField0000"));
            this._img.overlay.addChild(this._field);
            this.priceTxt = new TextField(67,20,"",new TextFormat("PUTIN",16,16763904,Align.CENTER));
            this.priceTxt.x = 10;
            this.priceTxt.y = 55;
            this.priceTxt.touchable = false;
            this._img.overlay.addChild(this.priceTxt);
            _loc4_ = GV[this._location][this._index][2].price;
            this.priceTxt.text = Amath.rounding(_loc4_);
            if(this._location == "inventory")
            {
               if(GV.settings[2] == 1)
               {
                  this.priceTxt.text = "new";
               }
               if(GV.settings[2] == 2)
               {
                  this.priceTxt.text = "новое";
               }
            }
         }
      }
      
      public function check_price() : void
      {
         if(this._location == "shop" || this._location == "potions")
         {
            if(GV[this._location][this._index][2].price > GV.coins)
            {
               this._field.texture = GV.assets.getTexture("PriceField0000");
            }
            else
            {
               this._field.texture = GV.assets.getTexture("Price2Field0000");
            }
         }
      }
      
      private function select(param1:Event) : void
      {
         if(this._location == "inventory" && this._field)
         {
            this._field.visible = false;
            this.priceTxt.visible = false;
            GV[this._location][this._index][2].open = 1;
         }
         GV.game.SM.screen["openItemPanel"](this._index,this._location);
      }
      
      public function Free() : void
      {
         this._img.removeEventListener(Event.TRIGGERED,this.select);
         this.removeFromParent();
      }
   }
}
