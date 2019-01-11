package com
{
   import com.general.Amath;
   import com.general.ObjectController;
   import com.general.SimpleCache;
   import com.mygame.effects.Damage_info;
   import com.mygame.managers.BackManager;
   import com.mygame.managers.LevelManager;
   import com.mygame.managers.LootManager;
   import com.mygame.screens.ScreenManager;
   import com.mygame.screens.UI;
   import dragonBones.animation.WorldClock;
   import flash.utils.getTimer;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class Game extends Sprite
   {
       
      
      public var _stage:Sprite;
      
      public var lay_0:Sprite;
      
      public var lay_1:Sprite;
      
      public var lay_2:Sprite;
      
      public var lay_3:Sprite;
      
      public var SM:ScreenManager;
      
      public var BM:BackManager;
      
      public var LootM:LootManager;
      
      public var gui:UI;
      
      public var cacheDamage:SimpleCache;
      
      public var effects:ObjectController;
      
      public var objs:ObjectController;
      
      public var enemies:ObjectController;
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 10;
      
      private var _isShake:Boolean = false;
      
      public function Game()
      {
         this._stage = new Sprite();
         this.lay_0 = new Sprite();
         this.lay_1 = new Sprite();
         this.lay_2 = new Sprite();
         this.lay_3 = new Sprite();
         super();
         GV.game = this;
      }
      
      public function init() : void
      {
         GV.groundY = int(GV.scr_Y - GV.scr_Y * 0.35);
         this.effects = new ObjectController();
         this.objs = new ObjectController();
         this.enemies = new ObjectController();
         this.BM = new BackManager();
         addChildAt(this.BM,0);
         addChild(this._stage);
         this._stage.visible = false;
         this._stage.addChild(this.lay_0);
         this._stage.addChild(this.lay_1);
         this._stage.addChild(this.lay_2);
         this._stage.addChild(this.lay_3);
         this.lay_0.touchable = false;
         this.lay_2.touchable = false;
         this.lay_3.touchable = false;
         this.gui = new UI();
         this.gui.Draw();
         addChild(this.gui);
         this.gui.visible = false;
         GV.LM = new LevelManager();
         this.LootM = new LootManager();
         this.cacheDamage = new SimpleCache(Damage_info,8);
         addEventListener(TouchEvent.TOUCH,this.onTouch);
         this.SM = new ScreenManager();
         this.SM.transition_screen("Map",true);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      public function init_level() : void
      {
         GV.real_time = 0;
         GV.start_time = getTimer();
         GV.delta = 0;
         GV.sound.free_time();
         this._stage.y = 0;
         this._stage.x = 0;
         this._isShake = false;
         GV.LM.init_level();
         this.gui.InitLevel();
         this._stage.visible = true;
         this.gui.visible = true;
         GV.isPlay = true;
      }
      
      public function free_level(param1:Event = null) : void
      {
         GV.isPlay = false;
         this.effects.clear();
         this.objs.clear();
         this.enemies.clear();
         GV.LM.free_level();
         this.BM.free();
         this._stage.visible = false;
         this.gui.visible = false;
         GV.sound.free_time();
         GV.juggler.purge();
      }
      
      public function damage(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         switch(this.enemies.objects.length)
         {
            case 0:
               break;
            case 1:
               this.enemies.objects[0].BladeDamage(param1,param2);
               break;
            case 2:
               _loc3_ = Amath.random(0,1);
               this.enemies.objects[_loc3_].BladeDamage(param1,param2);
               break;
            case 3:
               _loc3_ = Amath.random(0,2);
               this.enemies.objects[_loc3_].BladeDamage(param1,param2);
         }
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         var _loc2_:Number = param1.passedTime * 30;
         this.effects.update(_loc2_);
         if(GV.isPlay)
         {
            GV.juggler.advanceTime(param1.passedTime);
            WorldClock.clock.advanceTime(-1);
            this.objs.update(_loc2_);
            GV.LM.update(_loc2_);
            if(this._isShake)
            {
               this.shake_move(_loc2_);
            }
            GV.real_time = getTimer() - (GV.start_time + GV.delta);
         }
         else
         {
            GV.delta = getTimer() - (GV.start_time + GV.real_time);
         }
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            GV.touchX = _loc2_.globalX;
            GV.touchY = _loc2_.globalY;
         }
      }
      
      public function shake_move(param1:Number) : void
      {
         this._stage.y = Math.sin(this._angle) * this.amplitude;
         this._angle = this._angle + 3 * param1;
         this.amplitude = this.amplitude - 0.6 * param1;
         if(this.amplitude <= 0)
         {
            this._stage.y = 0;
            this._isShake = false;
         }
      }
      
      public function shake(param1:int) : void
      {
         this._stage.y = 0;
         this._angle = 0;
         this.amplitude = param1;
         this._isShake = true;
      }
   }
}
