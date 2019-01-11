package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_53 extends EnemyBase
   {
       
      
      public function En_53()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_53","En_" + 5 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 5;
         attackPower = attackPower * 5;
         _delayAttack = _delayAttack * 2;
         reward = reward * 70;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
