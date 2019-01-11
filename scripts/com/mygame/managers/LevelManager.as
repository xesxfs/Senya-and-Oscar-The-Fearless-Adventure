package com.mygame.managers
{
   import com.general.Amath;
   import com.mygame.effects.TowerFinish;
   import com.mygame.effects.TowerStart;
   import com.mygame.effects.TutorHand;
   import com.mygame.enemies.En_21;
   import com.mygame.enemies.En_22;
   import com.mygame.enemies.En_23;
   import com.mygame.enemies.En_24;
   import com.mygame.enemies.En_32;
   import com.mygame.enemies.En_33;
   import com.mygame.enemies.En_34;
   import com.mygame.enemies.En_41;
   import com.mygame.enemies.En_42;
   import com.mygame.enemies.En_43;
   import com.mygame.enemies.En_44;
   import com.mygame.enemies.En_51;
   import com.mygame.enemies.En_52;
   import com.mygame.enemies.En_53;
   import com.mygame.enemies.En_54;
   import com.mygame.enemies.EnemyBase;
   import com.mygame.enemies.location_1.En_11;
   import com.mygame.enemies.location_1.En_12;
   import com.mygame.enemies.location_1.En_13;
   import com.mygame.enemies.location_1.En_14;
   import com.mygame.objects.Cat;
   import com.mygame.objects.Hero;
   
   public class LevelManager
   {
       
      
      public var _isCamMove:Boolean = false;
      
      public var State:String = "";
      
      public var timer:int = 0;
      
      public var _maxWave:int;
      
      public var _curWave:int;
      
      public var _isFinish:Boolean;
      
      private var enCol:Array;
      
      private var lvl_0:Array;
      
      private var lvl_1:Array;
      
      private var lvl_2:Array;
      
      private var lvl_3:Array;
      
      private var lvl_4:Array;
      
      private var lvl_5:Array;
      
      private var lvl_6:Array;
      
      private var lvl_7:Array;
      
      private var lvl_8:Array;
      
      private var lvl_9:Array;
      
      private var lvl_10:Array;
      
      private var lvl_11:Array;
      
      private var lvl_12:Array;
      
      private var lvl_13:Array;
      
      private var lvl_14:Array;
      
      private var lvl_15:Array;
      
      private var lvl_16:Array;
      
      private var lvl_17:Array;
      
      private var lvl_18:Array;
      
      private var lvl_19:Array;
      
      private var lvl_20:Array;
      
      private var lvl_21:Array;
      
      private var lvl_22:Array;
      
      private var lvl_23:Array;
      
      private var lvl_24:Array;
      
      private var lvl_25:Array;
      
      private var lvl_26:Array;
      
      private var lvl_27:Array;
      
      private var lvl_28:Array;
      
      private var lvl_29:Array;
      
      private var lvl_30:Array;
      
      private var lvl_31:Array;
      
      private var lvl_32:Array;
      
      private var lvl_33:Array;
      
      private var lvl_34:Array;
      
      private var lvl_35:Array;
      
      private var lvl_36:Array;
      
      private var lvl_37:Array;
      
      private var lvl_38:Array;
      
      private var lvl_39:Array;
      
      private var lvl_40:Array;
      
      private var lvl_41:Array;
      
      private var lvl_42:Array;
      
      private var lvl_43:Array;
      
      private var lvl_44:Array;
      
      private var lvl_45:Array;
      
      private var lvl_46:Array;
      
      private var lvl_47:Array;
      
      private var lvl_48:Array;
      
      private var lvl_49:Array;
      
      private var lvl_50:Array;
      
      private var lvl_51:Array;
      
      private var lvl_52:Array;
      
      private var lvl_53:Array;
      
      private var lvl_54:Array;
      
      private var lvl_55:Array;
      
      private var lvl_56:Array;
      
      private var lvl_57:Array;
      
      private var lvl_58:Array;
      
      private var lvl_59:Array;
      
      private var lvl_60:Array;
      
      public function LevelManager()
      {
         this.enCol = [1,2,2,3,3,3,3,3,4,4,4,4,4,4,4,4,5,5,5,5,5,5,5,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,6,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,7,1,1,1,1,1,1,1];
         this.lvl_0 = [[1]];
         this.lvl_1 = [[1],[1]];
         this.lvl_2 = [[2],[1]];
         this.lvl_3 = [[2],[2]];
         this.lvl_4 = [[1,1],[2,1]];
         this.lvl_5 = [[3],[1],[2]];
         this.lvl_6 = [[2,1],[1,1],[2]];
         this.lvl_7 = [[3,2],[2,1]];
         this.lvl_8 = [[1,1,1],[3],[2,1]];
         this.lvl_9 = [[2,1],[1,1],[4,1]];
         this.lvl_10 = [[2],[2,1],[4,2]];
         this.lvl_11 = [[4,3],[2],[2,1]];
         this.lvl_12 = [[3],[4,1],[4,1]];
         this.lvl_13 = [[4,1,1],[2,1],[3,1]];
         this.lvl_14 = [[3],[4,1,1],[4,2]];
         this.lvl_15 = [[3,2],[3],[4,1],[3]];
         this.lvl_16 = [[3],[4,2],[4],[2],[2]];
         this.lvl_17 = [[1],[1],[2],[1]];
         this.lvl_18 = [[1],[2,1],[1,1],[2]];
         this.lvl_19 = [[2,2],[1],[2,1]];
         this.lvl_20 = [[2],[2],[3],[2,2]];
         this.lvl_21 = [[3,1],[2],[2],[3,1]];
         this.lvl_22 = [[2],[2,1],[4,2],[3]];
         this.lvl_23 = [[2],[2,1],[4,3],[2,2]];
         this.lvl_24 = [[1],[4,1],[2,2],[4,1,3]];
         this.lvl_25 = [[4,1,1],[2,1],[3,3,1]];
         this.lvl_26 = [[3],[4,1,1],[4,2],[4,3]];
         this.lvl_27 = [[3,2],[2,3],[4,1],[4,3],[3]];
         this.lvl_28 = [[3],[2],[2,2],[3]];
         this.lvl_29 = [[2,2],[2,2],[4,2],[3]];
         this.lvl_30 = [[2,2,2],[2],[4,3],[2]];
         this.lvl_31 = [[4,2],[4,3],[2,2,2]];
         this.lvl_32 = [[4,2,2],[2,2],[3,2,2],[2]];
         this.lvl_33 = [[3,2,2],[4],[4,2,2],[4,3,2]];
         this.lvl_34 = [[3,2,2],[2,3],[4],[4,3,2],[3,2]];
         this.lvl_35 = [[4,3,2],[4,2,2],[4,2],[2,2,2]];
         this.lvl_36 = [[3,1],[2],[2],[3,1]];
         this.lvl_37 = [[2],[2,1],[4,2],[3]];
         this.lvl_38 = [[2],[2,1],[4,3],[2,2]];
         this.lvl_39 = [[1],[4,1],[4,1,3],[2,2]];
         this.lvl_40 = [[4,1],[2,1],[3,3,1],[2]];
         this.lvl_41 = [[3],[4,1,1],[4,2],[4,3]];
         this.lvl_42 = [[3,2],[2,3],[4,1],[4,3],[3]];
         this.lvl_43 = [[4,3,2],[4,2,2],[4]];
         this.lvl_44 = [[3,1],[2],[2],[3,1],[2,1]];
         this.lvl_45 = [[3,2],[2,1],[4,2],[3,1]];
         this.lvl_46 = [[2],[2,1],[4,3],[2,2],[4]];
         this.lvl_47 = [[1],[4,1],[4,1,3],[2,2]];
         this.lvl_48 = [[4,1,1],[2,1],[3,1],[4,2]];
         this.lvl_49 = [[3],[4,1,1],[4,2],[2,3]];
         this.lvl_50 = [[3,2],[2,3],[4,1],[4,3]];
         this.lvl_51 = [[4,3,2],[4,2],[4,2]];
         this.lvl_52 = [[3],[2],[2,2],[3]];
         this.lvl_53 = [[2,2],[2,2],[4,2],[3]];
         this.lvl_54 = [[2,2,2],[2],[4,0,3],[2]];
         this.lvl_55 = [[4,2],[4,0,3],[2,2,2]];
         this.lvl_56 = [[4,2,2],[2,2],[3,2]];
         this.lvl_57 = [[3,2,2],[4],[4],[4,2]];
         this.lvl_58 = [[3,2,2],[2,3],[3,2]];
         this.lvl_59 = [[4,3,2],[4,2,2],[4]];
         this.lvl_60 = [[4],[4],[4],[5]];
         super();
      }
      
      public function init_level() : void
      {
         var _loc2_:TutorHand = null;
         GV.game.BM.init_level(GV.location);
         GV.freeExp = [0,0];
         GV.hero = new Hero();
         GV.hero.Init();
         GV.cat = new Cat();
         GV.cat.Init();
         GV.posHero = GV.cent_X - 200;
         this._isCamMove = false;
         this._isFinish = false;
         GV.levelComplete = false;
         this._maxWave = this["lvl_" + GV.gameLevel].length;
         this._curWave = 0;
         GV.game.gui.Init_Line(this._maxWave);
         var _loc1_:TowerStart = new TowerStart();
         _loc1_.init();
         if(GV.numClick < 20)
         {
            _loc2_ = new TutorHand();
            _loc2_.init();
         }
         this.State = "Start";
      }
      
      public function free_level() : void
      {
         GV.game.gui.btnClick.visible = false;
         GV.game.gui.hpTxt2.visible = false;
         if(GV.hero)
         {
            GV.hero.Free();
            GV.hero = null;
         }
         if(GV.cat)
         {
            GV.cat.Free();
            GV.cat = null;
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:TowerFinish = null;
         GV.game.gui.spellManager.update();
         switch(this.State)
         {
            case "Start":
               if(GV.hero.x >= GV.posHero)
               {
                  this.State = "Init_Run";
                  break;
               }
               break;
            case "Init_Battle":
               this.State = "Battle";
               GV.game.gui.btnClick.visible = true;
               break;
            case "Battle":
               GV.game.enemies.update(param1);
               break;
            case "Init_Run":
               GV.hero.changeState("Run");
               GV.cat.changeState("Run");
               GV.game.gui.enLife = 0;
               GV.game.gui.maxLife = 0;
               if(this._curWave < this._maxWave)
               {
                  _loc2_ = 0;
                  while(_loc2_ < this["lvl_" + GV.gameLevel][this._curWave].length)
                  {
                     if(this["lvl_" + GV.gameLevel][this._curWave][_loc2_] != 0)
                     {
                        this.CreateEnemy(this["lvl_" + GV.gameLevel][this._curWave][_loc2_],_loc2_);
                     }
                     _loc2_++;
                  }
                  this.State = "Run";
                  this._isCamMove = true;
               }
               else
               {
                  _loc3_ = new TowerFinish();
                  _loc3_.init();
                  this.State = "Finish";
                  this._isCamMove = false;
               }
               this._curWave++;
               GV.game.gui.next_skull(this._curWave);
               break;
            case "Run":
               if(GV.game.enemies.objects[0].x - 550 < GV.hero.x)
               {
                  GV.hero.changeState("Idle");
                  GV.cat.changeState("Idle");
                  this.State = "Break";
                  this.timer = GV.real_time + 1300;
                  GV.game.gui.EnemyLife(0);
                  GV.game.gui.Tween_Life();
                  GV.game.gui.hpTxt2.visible = true;
                  break;
               }
               break;
            case "Break":
               GV.hero.Break(param1);
               if(GV.hero.x > GV.game.enemies.objects[0].x - 550)
               {
                  GV.hero.x == GV.game.enemies.objects[0].x - 550;
               }
               if(this.timer < GV.real_time)
               {
                  GV.hero.curSpeedX - 0;
                  this.State = "Init_Battle";
                  break;
               }
               break;
            case "Init_Win":
               GV.hero.changeState("Idle");
               GV.cat.FreeAllState();
               this.State = "Win";
               this.timer = GV.real_time + 1300;
               GV.game.gui.btnClick.visible = false;
               break;
            case "Win":
               if(this.timer < GV.real_time)
               {
                  this.State = "Init_Run";
                  break;
               }
               break;
            case "End":
               GV.levelComplete = true;
               if(GV.gameLevel < 60)
               {
                  GV.gameLevel++;
               }
               else
               {
                  this._isFinish = true;
               }
               GV.game.SM.open_screen("End");
               this.State = "Stop";
               switch(GV.gameLevel)
               {
                  case 17:
                     GV.location = 2;
                     break;
                  case 28:
                     GV.location = 3;
                     break;
                  case 36:
                     GV.location = 4;
                     break;
                  case 52:
                     GV.location = 5;
               }
               GV.save.localSave();
               break;
            case "Die":
         }
         GV.hero.update(param1);
         GV.cat.update(param1);
         if(this._isCamMove)
         {
            GV.game._stage.x = Amath.Lerp(GV.game._stage.x,-GV.hero.x + GV.posHero,0.1);
         }
         GV.game.BM.update();
      }
      
      private function CreateEnemy(param1:int, param2:int) : void
      {
         var _loc3_:EnemyBase = null;
         loop0:
         switch(GV.location)
         {
            case 1:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_11();
                     break loop0;
                  case 2:
                     _loc3_ = new En_12();
                     break loop0;
                  case 3:
                     _loc3_ = new En_13();
                     break loop0;
                  case 4:
                     _loc3_ = new En_14();
                     break loop0;
                  default:
                     break loop0;
               }
            case 2:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_21();
                     break loop0;
                  case 2:
                     _loc3_ = new En_22();
                     break loop0;
                  case 3:
                     _loc3_ = new En_23();
                     break loop0;
                  case 4:
                     _loc3_ = new En_24();
                     break loop0;
                  default:
                     break loop0;
               }
            case 3:
               switch(param1)
               {
                  case 2:
                     _loc3_ = new En_32();
                     break loop0;
                  case 3:
                     _loc3_ = new En_33();
                     break loop0;
                  case 4:
                     _loc3_ = new En_34();
                     break loop0;
                  default:
                     break loop0;
               }
            case 4:
               switch(param1)
               {
                  case 1:
                     _loc3_ = new En_41();
                     break loop0;
                  case 2:
                     _loc3_ = new En_42();
                     break loop0;
                  case 3:
                     _loc3_ = new En_43();
                     break loop0;
                  case 4:
                     _loc3_ = new En_44();
                     break loop0;
                  default:
                     break loop0;
               }
            case 5:
               switch(param1)
               {
                  case 3:
                     _loc3_ = new En_51();
                     break loop0;
                  case 2:
                     _loc3_ = new En_52();
                     break loop0;
                  case 4:
                     _loc3_ = new En_53();
                     break loop0;
                  case 5:
                     _loc3_ = new En_54();
                     break loop0;
                  default:
                     break loop0;
               }
         }
         _loc3_.init(GV.gameLevel + 1);
         _loc3_.x = GV.hero.x + GV.scr_X * 3 + param2 * 70;
      }
      
      private function Generator() : void
      {
      }
   }
}
