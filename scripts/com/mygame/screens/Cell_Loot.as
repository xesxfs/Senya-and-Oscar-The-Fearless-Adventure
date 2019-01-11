package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Cell_Loot extends Sprite
   {
       
      
      private var _img:Image;
      
      private var _back:Image;
      
      private var _numTxt:TextField;
      
      public function Cell_Loot()
      {
         super();
      }
      
      public function Init(param1:int) : void
      {
         this._numTxt = new TextField(200,40,"1",new TextFormat("FontGoldExport",25,16777215,Align.CENTER));
         this._numTxt.x = -100;
         this._numTxt.y = 25;
         this._numTxt.touchable = false;
         addChild(this._numTxt);
         switch(param1)
         {
            case 0:
               this._back = new Image(GV.assets.getTexture("CellBack0000"));
               this._img = new Image(GV.assets.getTexture("CellLoot0000"));
               GV.loot[0] = int(GV.loot[0] * (1 + GV.multiCoins / 100));
               GV.coins = GV.coins + GV.loot[0];
               this._numTxt.text = Amath.rounding(GV.loot[0]);
               break;
            case 1:
               this._back = new Image(GV.assets.getTexture("CellBack0000"));
               this._img = new Image(GV.assets.getTexture("CellLoot0001"));
               this._numTxt.text = GV.loot[param1];
               break;
            case 2:
               this._back = new Image(GV.assets.getTexture("CellBack0000"));
               this._img = new Image(GV.assets.getTexture("CellLoot0002"));
               this._numTxt.text = GV.loot[param1];
               break;
            case 3:
               this.ItemIcon(0);
               this._numTxt.visible = false;
               break;
            case 4:
               this.ItemIcon(1);
               this._numTxt.visible = false;
               break;
            case 5:
               this.ItemIcon(2);
               this._numTxt.visible = false;
               break;
            case 6:
               this.ItemIcon(3);
               this._numTxt.visible = false;
         }
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
      }
      
      public function Free() : void
      {
         this.removeFromParent();
      }
      
      private function ItemIcon(param1:int) : void
      {
         var _loc2_:String = null;
         GV.game.LootM.create_item(0,param1);
         GV.inventory.push(GV.game.LootM._arr);
         GV.shopIndex[GV.game.LootM._arr[0] - 1]++;
         this._back = new Image(GV.assets.getTexture("CellBack000" + param1));
         if(GV.game.LootM._arr[1] < 10)
         {
            _loc2_ = "000" + GV.game.LootM._arr[1];
         }
         else
         {
            _loc2_ = "00" + GV.game.LootM._arr[1];
         }
         switch(GV.game.LootM._arr[0])
         {
            case 1:
               _loc2_ = "IconWeapon" + _loc2_;
               break;
            case 2:
               _loc2_ = "IconShield" + _loc2_;
               break;
            case 3:
               _loc2_ = "IconHelmet" + _loc2_;
               break;
            case 4:
               _loc2_ = "IconArmor" + _loc2_;
               break;
            case 5:
               _loc2_ = "IconBoots" + _loc2_;
         }
         this._img = new Image(GV.assets.getTexture(_loc2_));
      }
   }
}
