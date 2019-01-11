package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_51 extends EnemyBase
   {
       
      
      public function En_51()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_51","En_" + 5 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 4;
         attackPower = attackPower * 3;
         _delayAttack = _delayAttack * 1;
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
