package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Button;
   import starling.display.Quad;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenEnd extends ScrBase
   {
       
      
      private var _back:Quad;
      
      private var _icon1:IconExpirience;
      
      private var _icon2:IconExpirience;
      
      private var numStopExp:int = 0;
      
      private var isStopExp:Boolean = false;
      
      private var _arr:Array;
      
      private var _num:int = 0;
      
      private var _timer:int = 40;
      
      private var ContinueTxt:TextField;
      
      private var state:String = "";
      
      private var _stepX:int = 90;
      
      public function ScreenEnd()
      {
         this._arr = [];
         super();
         this.draw();
         GV.game.addChild(this);
         this.activation();
      }
      
      override public function activation() : void
      {
         GV.game.gui.HideBoost();
         GV.game.gui.spellManager.HideSpell();
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
         Tweener.removeTweens(this.ContinueTxt);
         removeEventListener(TouchEvent.TOUCH,this.onTouch);
      }
      
      override public function free() : void
      {
         this._icon1.free();
         this._icon2.free();
         super.free();
      }
      
      private function update(param1:EnterFrameEvent) : void
      {
         var _loc2_:Cell_Loot = null;
         var _loc3_:* = undefined;
         var _loc4_:int = 0;
         switch(this.state)
         {
            case "exp":
               this._icon1.update();
               this._icon2.update();
               break;
            case "loot":
               if(this._timer <= 0)
               {
                  if(this._num == 7)
                  {
                     GV.save.localSave();
                     this.ContinueTxt.visible = true;
                     this.Fade();
                     addEventListener(TouchEvent.TOUCH,this.onTouch);
                     GV.loot = [0,0,0,0,0,0,0];
                     this.state = "stop";
                     return;
                  }
                  if(GV.loot[this._num] != 0)
                  {
                     this._timer = 40;
                     GV.sound.playSFX("loot");
                     _loc2_ = new Cell_Loot();
                     _loc2_.Init(this._num);
                     _loc2_.y = GV.cent_Y + 70;
                     if(this._num == 0)
                     {
                        _loc2_.x = GV.cent_X;
                     }
                     else
                     {
                        _loc2_.x = this._arr[this._arr.length - 1].x + this._stepX;
                     }
                     addChild(_loc2_);
                     this._arr.push(_loc2_);
                     _loc3_ = GV.cent_X - this._stepX * (this._arr.length - 1) / 2;
                     _loc4_ = 0;
                     while(_loc4_ < this._arr.length)
                     {
                        Tweener.addTween(this._arr[_loc4_],{
                           "x":_loc3_ + _loc4_ * this._stepX,
                           "time":0.2,
                           "transition":"linear"
                        });
                        _loc4_++;
                     }
                  }
                  this._num++;
               }
               this._timer = this._timer - 1 * param1.passedTime * 30;
         }
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
      }
      
      public function StopExpirience() : void
      {
         this.numStopExp++;
         if(this.numStopExp == 2)
         {
            this.state = "loot";
         }
      }
      
      override public function draw() : void
      {
         this._back = new Quad(GV.scr_X,GV.scr_Y,0);
         addChild(this._back);
         this._back.alpha = 0;
         Tweener.addTween(this._back,{
            "alpha":0.8,
            "time":0.4,
            "delay":0,
            "transition":"linear"
         });
         this._icon1 = new IconExpirience();
         this._icon1.init(0);
         this._icon1.x = GV.cent_X - 130;
         this._icon1.y = -50;
         addChild(this._icon1);
         this._icon1.touchable = false;
         Tweener.addTween(this._icon1,{
            "y":GV.cent_Y - 145,
            "time":0.3,
            "delay":0.5,
            "transition":"easeOutBack"
         });
         this._icon2 = new IconExpirience();
         this._icon2.init(1);
         this._icon2.x = GV.cent_X - 130;
         this._icon2.y = -50;
         addChild(this._icon2);
         this._icon2.touchable = false;
         Tweener.addTween(this._icon2,{
            "y":GV.cent_Y - 30,
            "time":0.3,
            "delay":0.8,
            "transition":"easeOutBack",
            "onComplete":this.Start_exp
         });
         this.ContinueTxt = new TextField(400,50,"",new TextFormat("PUTIN",30,16777215,Align.CENTER));
         this.ContinueTxt.x = GV.cent_X - 200;
         this.ContinueTxt.y = GV.cent_Y + 150;
         addChild(this.ContinueTxt);
         this.ContinueTxt.touchable = false;
         this.ContinueTxt.visible = false;
         this.translate();
      }
      
      private function Start_exp() : void
      {
         this.state = "exp";
      }
      
      public function Fade() : void
      {
         Tweener.addTween(this.ContinueTxt,{
            "alpha":0.1,
            "time":0.3,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this.ContinueTxt,{
            "alpha":1,
            "time":0.3,
            "delay":0.6,
            "transition":"linear",
            "onComplete":this.Fade
         });
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               this.deactivation();
               if(GV.LM._isFinish && GV.levelComplete)
               {
                  GV.game.SM.transition_screen("Final",false);
               }
               else
               {
                  GV.game.SM.transition_screen("Map",true);
               }
            }
         }
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this.ContinueTxt.text = "Click to continue";
         }
         if(GV.settings[2] == 2)
         {
            this.ContinueTxt.text = "Нажмите для продолжения";
         }
      }
   }
}
