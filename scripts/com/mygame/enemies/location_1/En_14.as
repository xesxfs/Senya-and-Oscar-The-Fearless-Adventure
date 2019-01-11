package com.mygame.enemies.location_1
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_14 extends EnemyBase
   {
       
      
      public function En_14()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_14","En_" + 1 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 4;
         attackPower = attackPower * 5;
         _delayAttack = _delayAttack * 2;
         reward = reward * 2;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function Attack() : void
      {
         super.Attack();
      }
   }
}
