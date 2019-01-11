package com.mygame.spells
{
   import com.general.Amath;
   import com.general.IGameObject;
   import com.mygame.effects.GravityObj;
   import dragonBones.Armature;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import starling.display.Sprite;
   
   public class Spell_Light extends Sprite implements IGameObject
   {
       
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var _nameAmimation:String = "light";
      
      public var _isFree = false;
      
      public function Spell_Light()
      {
         super();
      }
      
      public function init() : void
      {
         var _loc2_:GravityObj = null;
         x = GV.game.enemies.objects[0].x + Amath.random(-50,50);
         y = GV.groundY;
         this._armature = GV.factory.buildArmature("LightAnimation","Hero");
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play(this._nameAmimation,1);
         this._armatureDisplay.scale = 1.5;
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this.touchable = false;
         GV.game.effects.add(this);
         GV.game.lay_2.addChild(this);
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new GravityObj();
            _loc2_.init(x + Amath.random(-20,20),GV.groundY,"Oskolok000" + (GV.location - 1),Amath.random(5,15) / 10);
            _loc1_++;
         }
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            this._armatureDisplay.removeFromParent();
            WorldClock.clock.remove(this._armature);
            this._armature = null;
            GV.game.effects.remove(this);
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         switch(this._nameAmimation)
         {
            case "light":
               this.free();
         }
      }
   }
}
