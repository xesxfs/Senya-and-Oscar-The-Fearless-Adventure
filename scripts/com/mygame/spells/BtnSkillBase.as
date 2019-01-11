package com.mygame.spells
{
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class BtnSkillBase extends Sprite
   {
       
      
      public var _btn:Button;
      
      public var _timer:TextField;
      
      public var _selectImg:Image;
      
      public var _isFree:Boolean = false;
      
      public var _isAvaliable:Boolean = false;
      
      public var _isState:String = "ready";
      
      public var _isSelected:Boolean = false;
      
      public var _id:int = 0;
      
      public var _time:int = 0;
      
      public var _sec:int = 0;
      
      public var _delay:int = 30;
      
      public var _sound:String;
      
      public function BtnSkillBase()
      {
         super();
      }
      
      public function init(param1:int, param2:Boolean, param3:String = "spell") : void
      {
         this._id = param1;
         this._sound = param3;
         switch(this._id)
         {
            case 0:
               this._delay = 15;
         }
         this._isAvaliable = param2;
         this._btn = new Button(GV.assets.getTexture("Spell_lock0000"));
         addChild(this._btn);
         this._timer = new TextField(75,75,"00",new TextFormat("PUTIN",18,16777215,Align.CENTER));
         this._timer.x = this._btn.x;
         this._timer.y = this._btn.y;
         this._btn.overlay.addChild(this._timer);
         this._timer.touchable = false;
         this._timer.visible = false;
         this._selectImg = new Image(GV.assets.getTexture("SpellSelect0000"));
         this._btn.overlay.addChild(this._selectImg);
         this._selectImg.touchable = false;
         this._selectImg.visible = false;
      }
      
      public function open() : void
      {
         this._isAvaliable = true;
         this._btn.downState = this._btn.overState = this._btn.upState = GV.assets.getTexture("Spell" + this._id + "_0000");
         this._btn.addEventListener(Event.TRIGGERED,this.select);
         this._isState = "ready";
         this._timer.visible = false;
         this._isSelected = false;
         this._selectImg.visible = false;
      }
      
      public function close() : void
      {
         if(this._isAvaliable == true)
         {
            this._isAvaliable = false;
            this._btn.downState = this._btn.overState = this._btn.upState = GV.assets.getTexture("Spell_lock0000");
            this._btn.removeEventListener(Event.TRIGGERED,this.select);
            this._isState = "ready";
            this._timer.visible = false;
            this._isSelected = false;
            this._selectImg.visible = false;
         }
      }
      
      public function update() : void
      {
         if(this._isState == "timer")
         {
            if(this._time < GV.real_time)
            {
               this._sec--;
               if(this._sec >= 10)
               {
                  this._timer.text = "" + this._sec;
               }
               else if(this._sec > 0)
               {
                  this._timer.text = "0" + this._sec;
               }
               else
               {
                  this.open();
               }
               this._time = GV.real_time + 1000;
            }
         }
      }
      
      public function activation_spell() : void
      {
         this._isState = "timer";
         this._btn.downState = this._btn.overState = this._btn.upState = GV.assets.getTexture("Spell" + this._id + "_0001");
         this._time = GV.real_time + 1000;
         this._sec = this._delay;
         this._timer.visible = true;
         this._timer.text = "" + this._sec;
         this._isSelected = false;
         this._selectImg.visible = false;
      }
      
      public function select(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btn)
         {
            if(this._isAvaliable && this._isState == "ready")
            {
               if(this._isSelected)
               {
                  this._isSelected = false;
                  this._selectImg.visible = false;
                  GV.game.gui.spellManager.RemoveFromSelected(this._id);
               }
               else
               {
                  this._isSelected = true;
                  this._selectImg.visible = true;
                  GV.game.gui.spellManager.AddToSelected(this._id);
               }
            }
         }
      }
   }
}
