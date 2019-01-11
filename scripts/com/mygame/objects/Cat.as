package com.mygame.objects
{
   import com.general.Amath;
   import com.mygame.effects.Effect;
   import com.mygame.spells.FireBallArrow;
   import com.mygame.spells.SpellBonfire;
   import com.mygame.spells.Spell_Arrow;
   import com.mygame.spells.Spell_Light;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.text.TextField;
   
   public class Cat extends Sprite
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var frame:Image;
      
      public var back:Image;
      
      public var line:Image;
      
      public var levelTxt:TextField;
      
      public var curHP:int;
      
      public var maxHP:int;
      
      public var _state:String = "Run";
      
      public var _animation:String = "Run";
      
      public var curSpeedX:Number = 0;
      
      public var maxSpeedX:int = 30;
      
      public var accX:Number = 1.0;
      
      public var attackTime:int = 100;
      
      public var typeSpell:int = 0;
      
      public var numSpell:int = 0;
      
      public var timerSpell:int = 0;
      
      public var lvl:int = 0;
      
      public var damage:int = 0;
      
      public var min_dam:int = 0;
      
      public var max_dam:int = 0;
      
      public var minExp:int = 0;
      
      public var maxExp:int = 0;
      
      public var sleepTimer:int = 0;
      
      public var isSleep:Boolean = false;
      
      public function Cat()
      {
         super();
      }
      
      public function Init() : *
      {
         this.lvl = GV.levels[0];
         this.damage = 5 * this.lvl;
         this.min_dam = this.damage - this.damage * 0.1;
         this.max_dam = this.damage + this.damage * 0.1;
         this._armature = GV.factory.buildArmature("Cat");
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.y = 5;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play("Run",999999999);
         this._armature.animation.timeScale = 1.2;
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         y = GV.groundY + 2;
         GV.game.lay_0.addChild(this);
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
         var _loc2_:Effect = null;
         var _loc3_:Spell_Arrow = null;
         var _loc4_:FireBallArrow = null;
         var _loc5_:Spell_Light = null;
         x = GV.hero.x - 100;
         switch(this._state)
         {
            case "Drag":
               GV.hero.x = GV.hero.x - 2;
               if(GV.posHero > GV.cent_X - 320)
               {
                  GV.posHero = GV.posHero - 1;
                  break;
               }
               break;
            case "Spell":
               switch(this.typeSpell)
               {
                  case 0:
                     if(this.numSpell > 0)
                     {
                        if(this.timerSpell < GV.real_time)
                        {
                           this.numSpell--;
                           this.timerSpell = GV.real_time + 300;
                           if(GV.game.enemies.objects.length > 0)
                           {
                              if(GV.LM.State == "Battle")
                              {
                                 GV.sound.playSFX("paw");
                                 _loc2_ = new Effect();
                                 _loc2_.init(GV.game.enemies.objects[0].x - 30,GV.groundY - 150,"EffectLapa",12);
                                 _loc2_.rotation = Amath.random(-2,2) / 10;
                                 this.damage = Amath.random(this.min_dam,this.max_dam);
                                 GV.game.damage(this.damage);
                                 GV.freeExp[1] = GV.freeExp[1] + this.damage;
                                 GV.game.shake(7);
                                 break;
                              }
                              break;
                           }
                           this.numSpell = 0;
                           this.timerSpell = 0;
                           break;
                        }
                        break;
                     }
                     this.typeSpell = -1;
                     GV.game.BM.addAplha(0,0.4,0);
                     GV.game.gui.spellManager._isState = "wait";
                     this.changeState("Idle");
                     break;
                  case 2:
                     if(this.numSpell > 0)
                     {
                        if(this.timerSpell < GV.real_time)
                        {
                           this.numSpell--;
                           this.timerSpell = GV.real_time + 100;
                           if(GV.game.enemies.objects.length > 0)
                           {
                              this.damage = Amath.random(this.min_dam,this.max_dam) * 2;
                              GV.freeExp[1] = GV.freeExp[1] + this.damage;
                              GV.sound.playSFX("arrow");
                              _loc3_ = new Spell_Arrow();
                              _loc3_.init(Amath.random(GV.game.enemies.objects[0].x - 400,GV.game.enemies.objects[0].x - 0),this.damage);
                              break;
                           }
                           this.numSpell = 0;
                           this.timerSpell = 0;
                           break;
                        }
                        break;
                     }
                     this.typeSpell = -1;
                     GV.game.BM.addAplha(0,0.4,0);
                     GV.game.gui.spellManager._isState = "wait";
                     this.changeState("Idle");
                     break;
                  case 3:
                     if(this.numSpell > 0)
                     {
                        if(this.timerSpell < GV.real_time)
                        {
                           this.numSpell--;
                           this.timerSpell = GV.real_time + 800;
                           if(GV.game.enemies.objects.length > 0)
                           {
                              this.damage = this.max_dam * 10;
                              GV.freeExp[1] = GV.freeExp[1] + this.damage;
                              _loc4_ = new FireBallArrow();
                              _loc4_.init(this.damage);
                              break;
                           }
                           this.numSpell = 0;
                           this.timerSpell = 0;
                           break;
                        }
                        break;
                     }
                     this.typeSpell = -1;
                     GV.game.BM.addAplha(0,0.4,0);
                     this._animation = "StopSpell_2";
                     this._armature.animation.play(this._animation,1);
                     break;
                  case 4:
                     if(this.numSpell > 0)
                     {
                        if(this.timerSpell < GV.real_time)
                        {
                           this.numSpell--;
                           this.timerSpell = GV.real_time + 300;
                           if(GV.game.enemies.objects.length)
                           {
                              GV.sound.playSFX("electro");
                              _loc5_ = new Spell_Light();
                              _loc5_.init();
                              this.damage = this.max_dam * 15;
                              GV.freeExp[1] = GV.freeExp[1] + this.damage;
                              GV.game.damage(this.damage);
                              GV.game.BM._black.alpha = 0.3;
                              GV.game.BM.addAplha(0.8,0.1,0);
                              GV.game.shake(7);
                              break;
                           }
                           this.numSpell = 0;
                           this.timerSpell = 0;
                           break;
                        }
                        break;
                     }
                     this.typeSpell = -1;
                     GV.game.BM.addAplha(0,0.4,0);
                     this._animation = "StopSpell_1";
                     this._armature.animation.play(this._animation,1);
                     break;
               }
         }
      }
      
      public function FreeAllState() : void
      {
         if(this._animation != "Idle" && this._animation != "Sleep")
         {
            this.changeState("Idle");
         }
         GV.game.gui.spellManager._isState = "wait";
         GV.game.BM.addAplha(0,0.4,0);
      }
      
      public function changeState(param1:String) : void
      {
         switch(param1)
         {
            case "Run":
               this._state = param1;
               this._animation = "Run";
               this._armature.animation.play("Run",999999999);
               break;
            case "Idle":
               this._state = param1;
               this._animation = "Idle";
               this._armature.animation.play("Idle",999999999);
               this.sleepTimer = GV.real_time + 2000;
               break;
            case "Die":
               this._state = param1;
               this._animation = "Die";
               this._armature.animation.play("Die",1);
               break;
            case "Attack":
               if(this._state == "Drag" || this._state == "Spell" || this._state == "Attack")
               {
                  return;
               }
               this._state = param1;
               this._animation = "Attack";
               this._armature.animation.play("Attack",1);
               break;
         }
      }
      
      public function StartSpell(param1:int) : void
      {
         var _loc2_:SpellBonfire = null;
         GV.sound.playSFX("cat");
         this._state = "Spell";
         this.typeSpell = param1;
         switch(this.typeSpell)
         {
            case 0:
               this._animation = "Spell_0";
               this._armature.animation.play(this._animation,100);
               this.numSpell = 5;
               this.timerSpell = GV.real_time + 500;
               GV.game.BM.addAplha(0.8,0.5,0);
               break;
            case 1:
               this._animation = "Spell_4";
               this._armature.animation.play(this._animation,1);
               if(GV.game.enemies.objects.length > 0)
               {
                  _loc2_ = new SpellBonfire();
                  _loc2_.init(this.max_dam * 2,0);
                  GV.game.BM.addAplha(0.8,0.5,0);
                  GV.game.BM.addAplha(0,0.5,1.5);
                  break;
               }
               break;
            case 2:
               this._animation = "Spell_3";
               this._armature.animation.play(this._animation,1);
               this.numSpell = 15;
               this.timerSpell = GV.real_time + 700;
               GV.game.BM.addAplha(0.8,0.5,0);
               break;
            case 3:
               this._animation = "Spell_2";
               this._armature.animation.play(this._animation,100);
               this.numSpell = 5;
               this.timerSpell = GV.real_time + 100;
               GV.game.BM.addAplha(0.8,0.5,0);
               break;
            case 4:
               this._animation = "Spell_1";
               this._armature.animation.play(this._animation,1);
               this.numSpell = 5;
               this.timerSpell = GV.real_time + 500;
               GV.game.BM.addAplha(0.8,0.5,0);
         }
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(this._animation)
         {
            case "Idle":
               if(this.sleepTimer < GV.real_time && GV.game.enemies.objects.length > 0)
               {
                  this._animation = "Sleep";
                  this._armature.animation.play("Sleep",999999);
                  break;
               }
               break;
            case "Attack":
               this.changeState("Idle");
               break;
            case "StopSpell_1":
            case "StopSpell_2":
            case "Spell_4":
               GV.game.gui.spellManager._isState = "wait";
               this.changeState("Idle");
               break;
            case "Die":
               this._state = "Drag";
               this._animation = "Drag";
               this._armature.animation.play("Drag",999999);
               GV.hero.changeState("Drag");
               GV.game.SM.open_screen("End");
         }
      }
   }
}
