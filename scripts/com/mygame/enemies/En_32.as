package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_32 extends EnemyBase
   {
       
      
      public function En_32()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_32","En_" + 3 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 4;
         attackPower = attackPower * 2;
         _delayAttack = _delayAttack * 1.2;
         reward = reward * 30;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
