package com.mygame.screens
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ForgeButton extends Sprite
   {
       
      
      private var _back:Image;
      
      private var _frame:Image;
      
      private var _btn:Button;
      
      private var _icon:Image;
      
      private var crystTxt:TextField;
      
      private var _id:int;
      
      private var _num:int;
      
      public function ForgeButton()
      {
         super();
      }
      
      public function Init(param1:int, param2:int, param3:int) : *
      {
         x = param1;
         y = param2;
         this._id = param3;
         switch(this._id)
         {
            case 1:
               this._num = 3;
               break;
            case 2:
               this._num = 5;
               break;
            case 3:
         }
         this._back = new Image(GV.assets.getTexture("CellBack000" + param3));
         addChild(this._back);
         this._frame = new Image(GV.assets.getTexture("IconForge0000"));
         addChild(this._frame);
         this._btn = new Button(GV.assets.getTexture("BtnGrey0000"));
         this._btn.x = this._frame.width + 10;
         this._btn.y = -1;
         addChild(this._btn);
         this._icon = new Image(GV.assets.getTexture("IcCrystal0000"));
         this._icon.scale = 0.8;
         this._icon.x = 42;
         this._icon.y = 25;
         this._icon.touchable = false;
         this._btn.overlay.addChild(this._icon);
         this._btn.addEventListener(Event.TRIGGERED,this.craft);
         this.crystTxt = new TextField(300,30,"" + this._num,new TextFormat("PUTIN",28,16777215,Align.LEFT));
         this.crystTxt.x = this._icon.x + 33;
         this.crystTxt.y = this._icon.y - 7;
         this.crystTxt.touchable = false;
         this._btn.overlay.addChild(this.crystTxt);
      }
      
      private function craft(param1:Event) : *
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btn)
         {
            if(parent["state"] == "wait")
            {
               if(GV.crystals >= this._num)
               {
                  GV.crystals = GV.crystals - this._num;
                  parent["Craft"](this._id);
                  GV.save.localSave();
               }
            }
         }
      }
      
      public function Free() : *
      {
         this._btn.removeEventListener(Event.TRIGGERED,this.craft);
      }
   }
}
