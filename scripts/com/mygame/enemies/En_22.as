package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_22 extends EnemyBase
   {
       
      
      public function En_22()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_22","En_" + 2 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.scale = 1.2;
         super.init(param1);
         curHP = maxHP = maxHP * 3;
         attackPower = attackPower * 2;
         _delayAttack = _delayAttack * 1.2;
         reward = reward * 5;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
