package com.mygame.spells
{
   import caurina.transitions.Tweener;
   
   public class SpellManager
   {
       
      
      private var _btnsArr:Array;
      
      public var selected_spells:Array;
      
      public var _isState:String = "wait";
      
      private var spellPY:int;
      
      public function SpellManager()
      {
         this._btnsArr = [];
         this.selected_spells = [];
         super();
      }
      
      public function InitButtons() : *
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:BtnSkillBase = null;
         if(GV.isWEB)
         {
            _loc2_ = 80;
            _loc3_ = GV.cent_X + 120;
         }
         else
         {
            _loc3_ = GV.cent_X + 180;
            _loc2_ = 78;
         }
         this.spellPY = GV.groundY + int(GV.scr_Y - GV.groundY) / 2 - 35;
         var _loc1_:int = 0;
         while(_loc1_ <= 4)
         {
            _loc4_ = new BtnSkillBase();
            _loc4_.init(_loc1_,false);
            _loc4_.x = _loc3_ - _loc2_ * _loc1_;
            _loc4_.y = this.spellPY;
            GV.game.gui.addChild(_loc4_);
            this._btnsArr.push(_loc4_);
            _loc1_++;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ <= 4)
         {
            this._btnsArr[_loc1_].update();
            _loc1_++;
         }
         if(GV.LM.State == "Battle" && this._isState == "wait" && this.selected_spells.length > 0)
         {
            this._btnsArr[this.selected_spells[0]].activation_spell();
            this.activation(this.selected_spells[0]);
            this.selected_spells.splice(0,1);
            this._isState = "action";
         }
      }
      
      public function RefreshAll() : void
      {
         this._btnsArr[0].open();
         if(GV.levels[1] >= 4)
         {
            this._btnsArr[1].open();
         }
         else
         {
            this._btnsArr[1].close();
         }
         if(GV.levels[1] >= 10)
         {
            this._btnsArr[2].open();
         }
         else
         {
            this._btnsArr[2].close();
         }
         if(GV.levels[1] >= 15)
         {
            this._btnsArr[3].open();
         }
         else
         {
            this._btnsArr[3].close();
         }
         if(GV.levels[1] >= 20)
         {
            this._btnsArr[4].open();
         }
         else
         {
            this._btnsArr[4].close();
         }
         this.selected_spells = [];
         var _loc1_:int = 0;
         while(_loc1_ < this._btnsArr.length)
         {
            this._btnsArr[_loc1_].y = this.spellPY;
            _loc1_++;
         }
      }
      
      public function RemoveFromSelected(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < this.selected_spells.length)
         {
            if(param1 == this.selected_spells[_loc2_])
            {
               this.selected_spells.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function AddToSelected(param1:int) : void
      {
         this.selected_spells.push(param1);
      }
      
      public function activation(param1:int) : void
      {
         GV.cat.StartSpell(param1);
      }
      
      public function HideSpell() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ <= 4)
         {
            Tweener.addTween(this._btnsArr[_loc1_],{
               "y":GV.scr_Y + 100,
               "time":0.5,
               "transition":"linear"
            });
            _loc1_++;
         }
      }
   }
}
