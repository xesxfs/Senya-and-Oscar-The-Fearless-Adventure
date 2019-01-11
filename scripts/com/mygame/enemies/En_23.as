package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_23 extends EnemyBase
   {
       
      
      public function En_23()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_23","En_" + 2 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         super.init(param1);
         curHP = maxHP = maxHP * 3;
         attackPower = attackPower * 3;
         _delayAttack = _delayAttack * 1.5;
         reward = reward * 5;
         GV.game.gui.enLife = GV.game.gui.enLife + curHP;
         GV.game.gui.maxLife = GV.game.gui.maxLife + curHP;
      }
      
      override public function Attack() : void
      {
         var _loc1_:Bomb = new Bomb();
         _loc1_.init(x - 40,y - 30,attackPower);
      }
   }
}
