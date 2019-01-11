package com.mygame.enemies
{
   import com.general.Amath;
   import com.general.IGameObject;
   import com.mygame.effects.Crit;
   import com.mygame.effects.Damage_info;
   import com.mygame.effects.GravityObj;
   import com.mygame.effects.LootItem;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import flash.geom.Rectangle;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class EnemyBase extends Sprite implements IGameObject
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var frame:Image;
      
      public var back:Image;
      
      public var line:Image;
      
      public var levelTxt:TextField;
      
      public var index:int;
      
      public var type:int;
      
      public var level:int;
      
      public var exp:int;
      
      public var reward:int;
      
      public var H_Def:Number = 1;
      
      public var M_Def:Number = 1;
      
      public var curHP:int;
      
      public var maxHP:int;
      
      public var _curState:String = "Wait";
      
      public var _nameAmimation:String = "Wait";
      
      public var _isFree:Boolean = false;
      
      private var isCollide = false;
      
      public var _isComleteAttack:Boolean = false;
      
      public var _isForward:Boolean = false;
      
      public var _isBack:Boolean = false;
      
      public var _isAttack:Boolean = false;
      
      public var _isPlant:Boolean = false;
      
      public var attackbox:Rectangle;
      
      public var hitbox:Rectangle;
      
      protected var _debugH:Quad;
      
      protected var _debugA:Quad;
      
      public var _delayAttack:int = 0;
      
      public var _timeAttack:int = 5000;
      
      public var attackPower:int = 0;
      
      public var posX:int;
      
      public var curSpeedX:Number = 0;
      
      public var maxSpeedX:Number;
      
      public var accX:Number;
      
      public var distX:int;
      
      public var maxX:int = 0;
      
      public var minX:int = 0;
      
      public var attX:int = 0;
      
      public var curSpeedY:Number = 0;
      
      public var accY:Number = 8;
      
      public var timeJump:int = 0;
      
      public var posY:int;
      
      public var en:Sprite;
      
      public var hX:int = 0;
      
      public var hY:int = 0;
      
      public var aX:int = 0;
      
      public var aY:int = 0;
      
      public var numTap:int = 0;
      
      public function EnemyBase()
      {
         super();
      }
      
      public function init(param1:int) : *
      {
         this.level = param1;
         y = GV.groundY;
         this.curHP = this.maxHP = 50 + 70 * (GV.gameLevel + 1);
         this.attackPower = 20 + 40 * (GV.gameLevel + 1) / 10;
         this._delayAttack = 1000 + Amath.random(0,100);
         this.reward = 70 + int(1.2 ^ GV.gameLevel + 1) * 10;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this._armature.animation.play("Idle",9999999);
         GV.game.lay_0.addChild(this);
         GV.game.enemies.add(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            if(!GV.debug)
            {
            }
            WorldClock.clock.remove(this._armature);
            removeChild(this._armatureDisplay);
            this._armatureDisplay = null;
            this._armature = null;
            this.removeFromParent();
            GV.game.enemies.remove(this);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(this.curHP <= 0)
         {
            this.deathEffects();
            if(GV.game.enemies.objects.length == 1)
            {
               GV.LM.State = "Init_Win";
            }
            this.free();
            return;
         }
         switch(this._curState)
         {
            case "Wait":
               if(this._timeAttack < GV.real_time)
               {
                  this._armature.animation.play("Attack");
                  this._nameAmimation = "Attack";
                  this._timeAttack = GV.real_time + this._delayAttack;
                  break;
               }
         }
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(this._nameAmimation)
         {
            case "Attack":
               this.Attack();
               this._armature.animation.play("Return");
               this._nameAmimation = "Return";
               break;
            case "Return":
               this._armature.animation.play("Idle",9999999);
               this._nameAmimation = "Wait";
         }
      }
      
      public function Attack() : void
      {
         GV.hero.Dmage(int(this.attackPower + Amath.random(0,this.attackPower * 1.2)));
      }
      
      public function BladeDamage(param1:int, param2:Boolean) : void
      {
         var _loc4_:Crit = null;
         var _loc3_:Damage_info = GV.game.cacheDamage.get() as Damage_info;
         _loc3_.init(x,y - Amath.random(50,100),param1);
         if(param2)
         {
            _loc4_ = new Crit();
            _loc4_.init(x,y - Amath.random(50,100));
         }
         this.damage(param1);
      }
      
      public function ClickDamage(param1:int) : void
      {
         this.damage(param1);
      }
      
      public function damage(param1:int) : void
      {
         var _loc2_:LootItem = null;
         this.numTap++;
         this.curHP = this.curHP - param1;
         GV.game.gui.EnemyLife(param1);
         if(Math.random() > 0.9)
         {
            GV.loot[0] = GV.loot[0] + int(this.reward * 0.1);
            _loc2_ = new LootItem();
            _loc2_.init(x + Amath.random(-50,50),y - 100,"Coin0000");
         }
      }
      
      public function deathEffects() : void
      {
         var _loc1_:GravityObj = new GravityObj();
         _loc1_.init(x,y,"Skull_0000");
         var _loc2_:int = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new GravityObj();
            _loc1_.init(x,y,"Bone" + Amath.random(1,10) + "_0000");
            _loc2_++;
         }
         GV.game.LootM.loot(x,y,this.reward);
         GV.game.shake(7);
         GV.sound.playSFX("splash_" + Amath.random(1,4));
      }
      
      public function create_life(param1:int, param2:int) : void
      {
         this.frame = new Image(GV.assets.getTexture("FrameLife0000"));
         this.frame.pivotX = int(this.frame.width / 2);
         this.frame.x = 0;
         this.frame.y = -this._armatureDisplay.height - 30;
         addChild(this.frame);
         this.back = new Image(GV.assets.getTexture("LineBack0000"));
         this.back.x = this.frame.x + 36 - int(this.frame.width / 2);
         this.back.y = this.frame.y + 13;
         addChildAt(this.back,this.numChildren - 1);
         this.line = new Image(GV.assets.getTexture("LineLIfe0000"));
         this.line.x = this.frame.x + 36 - int(this.frame.width / 2);
         this.line.y = this.frame.y + 13;
         addChildAt(this.line,this.numChildren - 1);
         this.levelTxt = new TextField(35,35,"" + this.level,new TextFormat("PUTIN",18,16777215,Align.CENTER));
         this.levelTxt.x = this.frame.x - int(this.frame.width / 2);
         this.levelTxt.y = this.frame.y + 1;
         addChild(this.levelTxt);
      }
   }
}
