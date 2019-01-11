package com.general
{
   import flash.net.SharedObject;
   import flash.net.SharedObjectFlushStatus;
   
   public class MySaveGame
   {
      
      public static var _instance:MySaveGame;
       
      
      private var name:String = "SnO6";
      
      public var _myData:Object;
      
      public var _sharedObject:SharedObject;
      
      public function MySaveGame()
      {
         super();
         this.bind();
      }
      
      public static function getInstance() : MySaveGame
      {
         if(_instance == null)
         {
            _instance = new MySaveGame();
         }
         return _instance;
      }
      
      public function init_saves() : void
      {
         if(this._sharedObject.size == 0)
         {
            this.reset();
         }
         else
         {
            this.local_load();
         }
      }
      
      public function bind() : Boolean
      {
         this._sharedObject = null;
         try
         {
            this._sharedObject = SharedObject.getLocal(this.name,"/");
         }
         catch(e:Error)
         {
            _sharedObject = null;
            return false;
         }
         return true;
      }
      
      public function local_load() : void
      {
         if(this._sharedObject != null)
         {
            this._myData = JSONN.decode(this._sharedObject.data.myJson);
            GV.settings = this._myData.settings;
            GV.location = this._myData.location;
            GV.gameLevel = this._myData.gameLevel;
            GV.coins = this._myData.coins;
            GV.crystals = this._myData.crystals;
            GV.numClick = this._myData.numClick;
            GV.treasury_openArr = this._myData.treasury_openArr;
            GV.treasury_chestsArr = this._myData.treasury_chestsArr;
            GV.treasury_keys = this._myData.treasury_keys;
            GV.levels = this._myData.levels;
            GV.curExp = this._myData.curExp;
            GV.shopIndex = this._myData.shopIndex;
            GV.inventory = this._myData.inventory;
            GV.equipment = this._myData.equipment;
            GV.shop = this._myData.shop;
            GV.equipment = this._myData.equipment;
         }
      }
      
      public function localSave(param1:uint = 0) : Boolean
      {
         var myJson:String = null;
         var MinFileSize:uint = param1;
         if(this._sharedObject == null)
         {
            return false;
         }
         var status:Object = null;
         try
         {
            this._myData = {
               "settings":GV.settings,
               "location":GV.location,
               "gameLevel":GV.gameLevel,
               "coins":GV.coins,
               "crystals":GV.crystals,
               "numClick":GV.numClick,
               "treasury_openArr":GV.treasury_openArr,
               "treasury_chestsArr":GV.treasury_chestsArr,
               "treasury_keys":GV.treasury_keys,
               "levels":GV.levels,
               "curExp":GV.curExp,
               "shopIndex":GV.shopIndex,
               "inventory":GV.inventory,
               "equipment":GV.equipment,
               "shop":GV.shop,
               "equipment":GV.equipment
            };
            myJson = JSONN.encode(this._myData);
            this._sharedObject.data.myJson = myJson;
            status = this._sharedObject.flush(MinFileSize);
         }
         catch(e:Error)
         {
            return false;
         }
         return status == SharedObjectFlushStatus.FLUSHED;
      }
      
      public function reset() : void
      {
         GV.location = 1;
         GV.gameLevel = 0;
         GV.coins = 430;
         GV.crystals = 0;
         GV.inventory = [];
         GV.equipment = [null,null,null,null,null];
         GV.shop = [];
         GV.treasury_openArr = [];
         GV.treasury_chestsArr = [];
         GV.treasury_keys = 0;
         GV.curExp = [0,0];
         GV.levels = [1,1];
         GV.shopIndex = [0,0,0,0,0];
         GV.numClick = 0;
         this.localSave();
      }
      
      public function load_cheat() : void
      {
         this.localSave();
      }
   }
}
