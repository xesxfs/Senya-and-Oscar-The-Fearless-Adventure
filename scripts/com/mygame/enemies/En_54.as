package com.mygame.enemies
{
   import dragonBones.starling.StarlingArmatureDisplay;
   
   public class En_54 extends EnemyBase
   {
       
      
      private var _angle:Number = 0;
      
      private var amplitude:Number = 20;
      
      public function En_54()
      {
         super();
      }
      
      override public function init(param1:int) : *
      {
         _armature = GV.factory.buildArmature("Animation_54","En_" + 5 + "_Loc");
         _armatureDisplay = _armature.display as StarlingArmatureDisplay;
         _armatureDisplay.x = -128;
         _armatureDisplay.y = -242;
         super.init(param1);
         curHP = maxHP = maxHP * 40;
         attackPower = attackPower * 5;
         _delayAttack = _delayAttack * 2;
         reward = reward * 300;
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
         var _loc1_:BossBullet = new BossBullet();
         _loc1_.init(x - 50,y - 100,attackPower);
      }
   }
}
