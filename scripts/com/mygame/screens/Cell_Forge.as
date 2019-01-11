package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.Sprite;
   
   public class Cell_Forge extends Sprite
   {
       
      
      private var _sun:Image;
      
      private var _img:Image;
      
      private var _back:Image;
      
      private var _nameTexture:String;
      
      public function Cell_Forge()
      {
         super();
      }
      
      public function Init(param1:int) : void
      {
         GV.game.LootM.create_item(0,param1,0);
         GV.inventory.push(GV.game.LootM._arr);
         switch(param1)
         {
            case 1:
               this._back = new Image(GV.assets.getTexture("CellBack0001"));
               break;
            case 2:
               this._back = new Image(GV.assets.getTexture("CellBack0002"));
               break;
            case 3:
               this._back = new Image(GV.assets.getTexture("CellBack0003"));
         }
         if(GV.game.LootM._arr[1] < 10)
         {
            this._nameTexture = "000" + GV.game.LootM._arr[1];
         }
         else
         {
            this._nameTexture = "00" + GV.game.LootM._arr[1];
         }
         switch(GV.game.LootM._arr[0])
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
         }
         this._sun = new Image(GV.assets.getTexture("Sun0000"));
         this._sun.scale = 0.1;
         addChild(this._sun);
         Tweener.addTween(this._sun,{
            "scale":2,
            "time":0.3,
            "transition":"lenear"
         });
         Tweener.addTween(this._sun,{
            "scale":0,
            "delay":0.3,
            "time":2,
            "transition":"lenear"
         });
         this._img = new Image(GV.assets.getTexture(this._nameTexture));
         this._back.x = this._img.x = -35;
         this._back.y = this._img.y = -35;
         addChild(this._back);
         addChild(this._img);
         this.scale = 0.2;
         Tweener.addTween(this,{
            "scale":1,
            "time":0.2,
            "transition":"easeOutBack"
         });
         Tweener.addTween(this,{
            "x":x + 70,
            "y":y - 120,
            "time":0.4,
            "transition":"linear",
            "onComplete":this.stopCraft
         });
      }
      
      public function Free() : void
      {
         this.removeFromParent();
      }
      
      public function stopCraft() : void
      {
         parent["state"] = "wait";
      }
   }
}
