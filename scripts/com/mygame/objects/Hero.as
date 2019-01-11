package com.mygame.objects
{
   import com.general.Amath;
   import com.mygame.effects.Damage_info;
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class Hero extends Sprite
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var frame:Image;
      
      public var back:Image;
      
      public var line:Image;
      
      public var levelTxt:TextField;
      
      public var curHP:int;
      
      public var maxHP:int;
      
      public var mc:MovieClip;
      
      public var _state:String = "Run";
      
      public var _animation:String = "Run";
      
      public var curSpeedX:Number = 0;
      
      public var maxSpeedX:int = 30;
      
      public var accX:Number = 2.0;
      
      public var hitArr:Array;
      
      public var attackTime:int = 100;
      
      public var attackDelay:int = 1000;
      
      public var damage:int = 0;
      
      public var min_dam:int = 0;
      
      public var max_dam:int = 0;
      
      public var crit:Number = 0;
      
      public var block:int = 0;
      
      public var min_block:int = 0;
      
      public var max_block:int = 0;
      
      public var num:int = 0;
      
      public var lvl:int = 0;
      
      public var def:int = 0;
      
      public var minExp:int = 0;
      
      public var maxExp:int = 0;
      
      public function Hero()
      {
         this.hitArr = [1,2,3,1,1,1];
         super();
      }
      
      public function Init() : *
      {
         var _loc1_:int = 0;
         this.lvl = GV.levels[0];
         this.damage = 2 + 3 * this.lvl;
         this.curHP = 200 + 300 * this.lvl;
         this.crit = 0;
         this.block = 0;
         this.def = 0;
         if(GV.equipment[0] != null)
         {
            this.damage = this.damage + GV.equipment[0][2].power;
            this.crit = GV.equipment[0][2].crit / 10;
         }
         if(GV.equipment[1] != null)
         {
            this.curHP = this.curHP + GV.equipment[1][2].block;
         }
         if(GV.equipment[2] != null)
         {
            this.curHP = this.curHP + GV.equipment[2][2].def;
         }
         if(GV.equipment[3] != null)
         {
            this.curHP = this.curHP + GV.equipment[3][2].def;
         }
         if(GV.equipment[4] != null)
         {
            this.curHP = this.curHP + GV.equipment[4][2].def;
         }
         this.maxHP = this.curHP;
         this.min_dam = this.damage - this.damage * 0.1;
         this.max_dam = this.damage + this.damage * 0.1;
         this.min_block = this.block - this.block * 0.1;
         this.max_block = this.block + this.block * 0.1;
         this._armature = GV.factory.buildArmature("HeroAnimation");
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play("Run",999999999);
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         GV.game.gui.hpTxt.text = this.curHP + "/" + this.maxHP;
         x = -200;
         y = GV.groundY + 0;
         GV.game.lay_0.addChild(this);
         GV.multiCoins = 0;
         GV.multiExp = 0;
         if(GV.equipment[0] == null)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = GV.equipment[0][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[0][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[0][2].exp;
         }
         this.ChangeImg("sword","sw" + _loc1_ + "_0000");
         if(GV.equipment[1] == null)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = GV.equipment[1][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[1][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[1][2].exp;
         }
         this.ChangeImg("shield","H_t" + _loc1_ + "_0000");
         if(GV.equipment[2] == null)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = GV.equipment[2][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[2][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[2][2].exp;
         }
         this.ChangeImg("head","H_h" + _loc1_ + "_0000");
         if(GV.equipment[3] == null)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = GV.equipment[3][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[3][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[3][2].exp;
         }
         this.ChangeImg("body","H_b" + _loc1_ + "_0000");
         this.ChangeImg("shR","H_r" + _loc1_ + "_0000");
         this.ChangeImg("shL","H_l" + _loc1_ + "_0000");
         if(GV.equipment[4] == null)
         {
            _loc1_ = 0;
         }
         else
         {
            _loc1_ = GV.equipment[4][1];
            GV.multiCoins = GV.multiCoins + GV.equipment[4][2].coin;
            GV.multiExp = GV.multiExp + GV.equipment[4][2].exp;
         }
         this.ChangeImg("bootR","H_f" + _loc1_ + "_0000");
         this.ChangeImg("bootL","H_f" + _loc1_ + "_0000");
         this.ChangeImg("legR","H_j" + _loc1_ + "_0000");
         this.ChangeImg("legL","H_j" + _loc1_ + "_0000");
         this.ChangeImg("handL","H_ruch0000");
         this.ChangeImg("femL","H_fem0000");
         this.ChangeImg("femR","H_fem0000");
         this.ChangeImg("forR","H_arm0000");
      }
      
      public function Free() : *
      {
         this._armatureDisplay.removeFromParent(true);
         WorldClock.clock.remove(this._armature);
         this._armature = null;
         this.removeFromParent(true);
      }
      
      public function update(param1:Number) : *
      {
         if(this.curHP == 0 && this._state != "Die" && this._state != "Drag")
         {
            this.changeState("Die");
            GV.cat.FreeAllState();
            GV.LM.State = "Die";
            return;
         }
         switch(this._state)
         {
            case "Run":
               x = x + this.curSpeedX * param1;
               if(this.curSpeedX < this.maxSpeedX)
               {
                  this.curSpeedX = this.curSpeedX + this.accX * param1;
                  break;
               }
               break;
            case "Idle":
               if(GV.LM.State == "Battle" && this.attackTime < GV.real_time)
               {
                  this.attackTime = GV.real_time + this.attackDelay;
                  this.num = this.hitArr[Amath.random(0,5)];
                  this.changeState("Attack");
                  GV.numClick--;
                  break;
               }
         }
      }
      
      public function ClickAttack() : void
      {
         if(this._state == "Idle")
         {
            this.attackTime = GV.real_time + this.attackDelay;
            this.num = this.hitArr[Amath.random(0,5)];
            this.changeState("Attack");
         }
      }
      
      public function Break(param1:Number) : void
      {
         x = x + this.curSpeedX * param1;
         if(this.curSpeedX > 0)
         {
            this.curSpeedX = this.curSpeedX - this.accX * param1;
         }
         else
         {
            this.curSpeedX = 0;
         }
      }
      
      public function Attack() : void
      {
         this.damage = Amath.random(this.min_dam,this.max_dam);
         if(Math.random() < this.crit)
         {
            GV.game.damage(this.damage * 2,true);
            GV.freeExp[0] = GV.freeExp[0] + this.damage * 2;
         }
         else
         {
            GV.game.damage(this.damage);
            GV.freeExp[0] = GV.freeExp[0] + this.damage;
         }
      }
      
      public function changeState(param1:String) : void
      {
         this._state = param1;
         switch(param1)
         {
            case "Run":
               this._animation = "Run";
               this._armature.animation.play("Run",999999999);
               break;
            case "Attack":
               this._animation = "Attack_" + this.num;
               this._armature.animation.play("Attack_" + this.num,1);
               break;
            case "Return":
               this._animation = "Return_" + this.num;
               this._armature.animation.play("Return_" + this.num,1);
               break;
            case "Idle":
               this._animation = "Idle";
               this._armature.animation.play("Idle",999999999);
               break;
            case "Win":
               this._animation = "Win" + Amath.random(1,3);
               this._armature.animation.play(this._animation,999999999);
               break;
            case "Die":
               this._animation = "Die";
               this._armature.animation.play("Die",1);
               break;
            case "Drag":
               this._animation = "Drag";
               this._armature.animation.play("Drag",999999999);
         }
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(this._state)
         {
            case "Attack":
               this.Attack();
               GV.sound.sword();
               this.changeState("Return");
               break;
            case "Return":
               this.changeState("Idle");
               break;
            case "Die":
               GV.cat.changeState("Die");
         }
      }
      
      public function create_life(param1:int, param2:int) : void
      {
         this.frame = new Image(GV.assets.getTexture("FrameLife0000"));
         this.frame.pivotX = int(this.frame.width / 2);
         this.frame.x = param1;
         this.frame.y = param2;
         addChild(this.frame);
         this.back = new Image(GV.assets.getTexture("LineBack0000"));
         this.back.x = this.frame.x + 36 - int(this.frame.width / 2);
         this.back.y = this.frame.y + 13;
         addChildAt(this.back,this.numChildren - 1);
         this.line = new Image(GV.assets.getTexture("LineLIfe0000"));
         this.line.x = this.frame.x + 36 - int(this.frame.width / 2);
         this.line.y = this.frame.y + 13;
         addChildAt(this.line,this.numChildren - 1);
         this.levelTxt = new TextField(35,35,"99",new TextFormat("PUTIN",18,16777215,Align.CENTER));
         this.levelTxt.x = this.frame.x - int(this.frame.width / 2) + 1;
         this.levelTxt.y = this.frame.y;
         addChild(this.levelTxt);
      }
      
      public function Dmage(param1:int) : void
      {
         if(!GV.godMode)
         {
            this.curHP = this.curHP - param1;
         }
         var _loc2_:Damage_info = GV.game.cacheDamage.get() as Damage_info;
         _loc2_.init(x,y - Amath.random(50,100),param1);
         _loc2_._speedX = _loc2_._speedX * -1;
         _loc2_._isRight = false;
         if(this.curHP <= 0)
         {
            this.curHP = 0;
            GV.game.gui.HeroLife(0);
            GV.game.gui.hpTxt.text = 0 + "/" + 0;
         }
         else
         {
            GV.game.gui.HeroLife(this.curHP / this.maxHP);
            GV.game.gui.hpTxt.text = this.curHP + "/" + this.maxHP;
         }
      }
      
      public function Healing(param1:Number) : void
      {
         this.curHP = this.curHP + this.curHP * param1;
         if(this.curHP > this.maxHP)
         {
            this.curHP = this.maxHP;
         }
         GV.game.gui.HeroLife(this.curHP / this.maxHP);
      }
      
      public function Angry() : void
      {
         var _loc1_:Slot = this._armature.getSlot("head");
         _loc1_.display = new Sprite();
         this.mc = new MovieClip(GV.assets.getTextures("ScullFlame_"),12);
         _loc1_.display.addChild(this.mc);
         GV.juggler.add(this.mc);
         this.mc.play();
         this.attackDelay = 100;
         this._armature.animation.timeScale = 2;
      }
      
      public function ChangeImg(param1:String, param2:String) : void
      {
         var _loc3_:Slot = this._armature.getSlot(param1);
         _loc3_.display = new Sprite();
         var _loc4_:Image = new Image(GV.assets.getTexture(param2));
         _loc3_.display.addChild(_loc4_);
      }
   }
}
