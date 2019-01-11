package com.mygame.enemies.location_1
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_12 extends EnemyBase
   {
       
      
      public function En_12()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_12","En_" + 1 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 2;
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
