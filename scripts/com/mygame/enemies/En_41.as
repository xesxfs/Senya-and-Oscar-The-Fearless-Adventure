package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_41 extends EnemyBase
   {
       
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 15;
      
      public function En_41()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_41","En_" + 4 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 3.5;
         attackPower = attackPower * 3;
         _delayAttack = _delayAttack * 1;
         reward = reward * 10;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function update(param1:Number) : void
      {
         y = GV.groundY + Math.sin(this._angle) * this.amplitude;
         this._angle = this._angle + 0.1;
         super.update(param1);
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
