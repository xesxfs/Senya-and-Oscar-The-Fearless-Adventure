package com.mygame.managers
{
   import com.general.Amath;
   import com.mygame.effects.LootItem;
   
   public class LootManager
   {
       
      
      private var _item:int;
      
      private var _id:int;
      
      private var _type:int;
      
      private var _obj:Object;
      
      public var _arr:Array;
      
      public var _price:int = 0;
      
      private var power:int;
      
      private var block:int;
      
      private var price:int;
      
      private var crit:int;
      
      private var def:int;
      
      public function LootManager()
      {
         this._obj = {};
         this._arr = [];
         super();
      }
      
      public function loot(param1:int, param2:int, param3:int) : void
      {
         var _loc5_:LootItem = null;
         GV.loot[0] = GV.loot[0] + param3;
         var _loc4_:int = 0;
         while(_loc4_ < 6)
         {
            _loc5_ = new LootItem();
            _loc5_.init(param1 + Amath.random(-50,50),param2 - 100,"Coin0000");
            _loc4_++;
         }
         if(Math.random() < GV.chance.crystal)
         {
            _loc5_ = new LootItem();
            _loc5_.init(param1 + Amath.random(-50,50),param2 - 100,"Crystal_0000");
            GV.loot[1]++;
            GV.crystals++;
            GV.chance.crystal = 0.1;
         }
         if(Math.random() < GV.chance.key)
         {
            _loc5_ = new LootItem();
            _loc5_.init(param1 + Amath.random(-50,50),param2 - 100,"Key_mc0000");
            GV.loot[2]++;
            GV.treasury_keys++;
            GV.chance.key = 0.1;
         }
         if(GV.loot[3] == 0 && GV.loot[4] == 0 && GV.loot[5] == 0 && GV.loot[6] == 0)
         {
            if(Math.random() < GV.chance.item)
            {
               GV.loot[3]++;
               _loc5_ = new LootItem();
               _loc5_.init(param1 + Amath.random(-50,50),param2 - 100,"ItemChest0000");
               GV.chance.item = 0.1;
            }
         }
      }
      
      public function create_item(param1:int, param2:int, param3:int = 0) : void
      {
         var _loc5_:int = 0;
         this._arr = [];
         var _loc4_:int = param3;
         this._type = param2;
         this._item = param1;
         if(param1 != 0)
         {
            switch(param1)
            {
               case 1:
                  this.Create_Sword(_loc4_);
                  break;
               case 2:
                  this.Create_Shield(_loc4_);
                  break;
               case 3:
                  this.Create_Hat(_loc4_);
                  break;
               case 4:
                  this.Create_Dress(_loc4_);
                  break;
               case 5:
                  this.Create_Boots(_loc4_);
            }
         }
         else
         {
            _loc5_ = Amath.random(1,100);
            if(_loc5_ > 80)
            {
               this._item = 1;
               this.Create_Sword(_loc4_);
            }
            else if(_loc5_ > 60)
            {
               this._item = 2;
               this.Create_Shield(_loc4_);
            }
            else if(_loc5_ > 40)
            {
               this._item = 3;
               this.Create_Hat(_loc4_);
            }
            else if(_loc5_ > 20)
            {
               this._item = 4;
               this.Create_Dress(_loc4_);
            }
            else
            {
               this._item = 5;
               this.Create_Boots(_loc4_);
            }
         }
         this._arr[2].price = this._arr[2].price - 3400;
         if(this._arr[2].price > 100 && this._arr[2].price < 10000)
         {
            this._arr[2].price = Math.floor(this._arr[2].price / 10) * 10;
         }
         if(this._arr[2].price > 10000 && this._arr[2].price < 100000)
         {
            this._arr[2].price = Math.floor(this._arr[2].price / 100) * 100;
         }
         if(this._arr[2].price > 100000)
         {
            this._arr[2].price = Math.floor(this._arr[2].price / 1000) * 1000;
         }
      }
      
      private function Create_Sword(param1:int) : void
      {
         this.select_Sword_id();
         this._arr.push(this._item);
         this._arr.push(this._id);
         this._obj = {
            "type":this._type,
            "power":0,
            "price":0,
            "crit":0,
            "coin":0,
            "exp":0,
            "extraDam":0,
            "open":0,
            "lvl":0
         };
         this._arr.push(this._obj);
         if(param1 == 0)
         {
            param1 = GV.shopIndex[0] + 1;
         }
         switch(this._arr[2].type)
         {
            case 0:
               this.crit = Amath.random(1,4);
               break;
            case 1:
               param1 = param1 + 1;
               this.crit = Amath.random(4,6);
               if(Math.random() > 0.5)
               {
                  this._arr[2].coin = Amath.random(10,20);
                  break;
               }
               this._arr[2].exp = Amath.random(10,20);
               break;
            case 2:
               param1 = param1 + 2;
               this.crit = Amath.random(6,10);
               this._arr[2].coin = Amath.random(25,30);
               this._arr[2].exp = Amath.random(25,30);
         }
         this.power = 6 * param1;
         this._arr[2].power = int(this.power + Amath.random(0,4));
         this._arr[2].crit = this.crit;
         this._arr[2].price = int(Math.pow(1.2,param1 + 15) * 100) * 3 - 1000;
         if(param1 != 1 && param1 != 2)
         {
            this._arr[2].price = this._arr[2].price + int(this._arr[2].price * Amath.random(0,20) / 100);
         }
         this._arr[2].lvl = param1;
      }
      
      private function Create_Shield(param1:int) : void
      {
         this.select_item_id();
         this._arr.push(this._item);
         this._arr.push(this._id);
         this._obj = {
            "type":this._type,
            "price":0,
            "block":0,
            "coin":0,
            "exp":0,
            "open":0,
            "lvl":0
         };
         this._arr.push(this._obj);
         if(param1 == 0)
         {
            param1 = GV.shopIndex[1] + 1;
         }
         switch(this._arr[2].type)
         {
            case 0:
               break;
            case 1:
               param1 = param1 + 1;
               if(Math.random() > 0.5)
               {
                  this._arr[2].coin = Amath.random(10,20);
                  break;
               }
               this._arr[2].exp = Amath.random(10,20);
               break;
            case 2:
               param1 = param1 + 2;
               this._arr[2].coin = Amath.random(25,30);
               this._arr[2].exp = Amath.random(25,30);
         }
         this._arr[2].block = this.block = int(65 * param1 * 1.2) * 2;
         this._arr[2].price = int(Math.pow(1.2,param1 + 15) * 100) * 2;
         this._arr[2].price = this._arr[2].price + int(this._arr[2].price * Amath.random(0,20) / 100);
         this._arr[2].lvl = param1;
      }
      
      private function Create_Hat(param1:int) : void
      {
         this.select_item_id();
         this._arr.push(this._item);
         this._arr.push(this._id);
         this._obj = {
            "type":this._type,
            "price":0,
            "def":0,
            "coin":0,
            "exp":0,
            "open":0,
            "lvl":0
         };
         this._arr.push(this._obj);
         if(param1 == 0)
         {
            param1 = GV.shopIndex[2] + 1;
         }
         switch(this._arr[2].type)
         {
            case 0:
               break;
            case 1:
               param1 = param1 + 1;
               if(Math.random() > 0.5)
               {
                  this._arr[2].coin = Amath.random(10,20);
                  break;
               }
               this._arr[2].exp = Amath.random(10,20);
               break;
            case 2:
               param1 = param1 + 2;
               this._arr[2].coin = Amath.random(25,30);
               this._arr[2].exp = Amath.random(25,30);
         }
         this._arr[2].def = int(55 * param1 * 1.2) * 2;
         this._arr[2].price = int(Math.pow(1.2,param1 + 15) * 100) * 2;
         this._arr[2].price = this._arr[2].price + int(this._arr[2].price * Amath.random(0,20) / 100);
         this._arr[2].lvl = param1;
      }
      
      private function Create_Dress(param1:int) : void
      {
         this.select_item_id();
         this._arr.push(this._item);
         this._arr.push(this._id);
         this._obj = {
            "type":this._type,
            "price":0,
            "def":0,
            "coin":0,
            "exp":0,
            "open":0,
            "lvl":0
         };
         this._arr.push(this._obj);
         if(param1 == 0)
         {
            param1 = GV.shopIndex[3] + 1;
         }
         switch(this._arr[2].type)
         {
            case 0:
               break;
            case 1:
               param1 = param1 + 1;
               if(Math.random() > 0.5)
               {
                  this._arr[2].coin = Amath.random(10,20);
                  break;
               }
               this._arr[2].exp = Amath.random(10,20);
               break;
            case 2:
               param1 + 2;
               this._arr[2].coin = Amath.random(25,30);
               this._arr[2].exp = Amath.random(25,30);
         }
         this._arr[2].def = int(80 * param1 * 1.2) * 2;
         this._arr[2].price = int(Math.pow(1.2,param1 + 15) * 100) * 2;
         this._arr[2].price = this._arr[2].price + int(this._arr[2].price * Amath.random(0,20) / 100);
         this._arr[2].lvl = param1;
      }
      
      private function Create_Boots(param1:int) : void
      {
         this.select_item_id();
         this.select_item_id();
         this._arr.push(this._item);
         this._arr.push(this._id);
         this._obj = {
            "type":this._type,
            "price":0,
            "def":0,
            "coin":0,
            "exp":0,
            "open":0,
            "lvl":0
         };
         this._arr.push(this._obj);
         if(param1 == 0)
         {
            param1 = GV.shopIndex[4] + 1;
         }
         switch(this._arr[2].type)
         {
            case 0:
               break;
            case 1:
               param1 + 1;
               if(Math.random() > 0.5)
               {
                  this._arr[2].coin = Amath.random(10,20);
                  break;
               }
               this._arr[2].exp = Amath.random(10,20);
               break;
            case 2:
               param1 + 2;
               this._arr[2].coin = Amath.random(25,30);
               this._arr[2].exp = Amath.random(25,30);
         }
         this._arr[2].def = int(40 * param1 * 1.2) * 2;
         this._arr[2].price = int(Math.pow(1.2,param1 + 15) * 100) * 2;
         this._arr[2].price = this._arr[2].price + int(this._arr[2].price * Amath.random(0,20) / 100);
         this._arr[2].lvl = param1;
      }
      
      private function select_Sword_id() : void
      {
         this._id = GV.gameLevel / 4;
         if(this._type == 1)
         {
            this._id++;
         }
         if(this._type == 2 || this._type == 3)
         {
            this._id = this._id + 2;
         }
         if(this._id < 1)
         {
            this._id = 1;
         }
         if(this._id > 15)
         {
            this._id = 15;
         }
      }
      
      private function select_item_id() : void
      {
         this._id = GV.gameLevel / 6;
         if(this._type == 1 || this._type == 2 || this._type == 3)
         {
            this._id = this._id + 1;
         }
         if(this._id < 1)
         {
            this._id = 1;
         }
         if(this._id > 10)
         {
            this._id = 10;
         }
      }
   }
}
