package com.mygame.enemies.location_1
{
   import com.mygame.enemies.EnemyBase;
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_11 extends EnemyBase
   {
       
      
      public function En_11()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_11","En_" + 1 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 1;
         attackPower = attackPower * 1;
         _delayAttack = _delayAttack * 1;
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
