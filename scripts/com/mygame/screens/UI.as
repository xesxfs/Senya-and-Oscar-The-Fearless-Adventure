package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.mygame.effects.Effect;
   import com.mygame.spells.BoostBtn;
   import com.mygame.spells.SpellManager;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.textures.Texture;
   import starling.utils.Align;
   
   public class UI extends Sprite
   {
       
      
      private var _lineR:Image;
      
      private var _lineCenter:Image;
      
      private var _lineL:Image;
      
      private var _scullsArr:Array;
      
      private var frame:Image;
      
      private var back:Image;
      
      private var line:Image;
      
      public var hpTxt:TextField;
      
      private var frame2:Image;
      
      private var back2:Image;
      
      private var line2:Image;
      
      public var hpTxt2:TextField;
      
      public var btnClick:Button;
      
      private var btnPause:Button;
      
      private var btnSword:Button;
      
      private var coinTxt:TextField;
      
      private var coinImg:Image;
      
      private var boost_0:BoostBtn;
      
      private var boost_1:BoostBtn;
      
      private var boost_2:BoostBtn;
      
      private var boostPY:int;
      
      public var enLife:int;
      
      public var maxLife:int;
      
      public var spellManager:SpellManager;
      
      public function UI()
      {
         this._scullsArr = [];
         super();
      }
      
      public function Draw() : *
      {
         var _loc1_:Image = null;
         var _loc2_:Texture = null;
         this._lineCenter = new Image(GV.assets.getTexture("BattleLine0000"));
         this._lineCenter.pivotX = this._lineCenter.width / 2;
         this._lineCenter.x = GV.cent_X;
         this._lineCenter.y = 25;
         addChild(this._lineCenter);
         this._lineCenter.touchable = false;
         this._lineR = new Image(GV.assets.getTexture("SideR0000"));
         this._lineR.x = GV.cent_X;
         this._lineR.y = this._lineCenter.y;
         addChild(this._lineR);
         this._lineR.touchable = false;
         this._lineL = new Image(GV.assets.getTexture("SideL0000"));
         this._lineL.x = GV.cent_X;
         this._lineL.y = this._lineCenter.y;
         addChild(this._lineL);
         this._lineL.touchable = false;
         _loc1_ = new Image(GV.assets.getTexture("UI_Icon0000"));
         _loc1_.x = 10;
         _loc1_.y = 10;
         addChild(_loc1_);
         _loc2_ = GV.assets.getTexture("HLineBack0000");
         this.back = new Image(_loc2_);
         this.back.x = 75;
         this.back.y = 15;
         addChild(this.back);
         this.back.touchable = false;
         this.back2 = new Image(_loc2_);
         this.back2.x = GV.scr_X - 75;
         this.back2.y = 15;
         this.back2.pivotX = 168;
         addChild(this.back2);
         this.back2.touchable = false;
         _loc2_ = GV.assets.getTexture("HLineLIfe0000");
         this.line = new Image(_loc2_);
         this.line.x = this.back.x;
         this.line.y = this.back.y;
         addChild(this.line);
         this.line.touchable = false;
         this.line2 = new Image(_loc2_);
         this.line2.x = this.back2.x;
         this.line2.y = this.back2.y;
         this.line2.pivotX = 168;
         addChild(this.line2);
         this.line2.touchable = false;
         _loc2_ = GV.assets.getTexture("HFrameLife0000");
         this.frame = new Image(_loc2_);
         this.frame.x = this.back.x - 2;
         this.frame.y = this.back.y - 2;
         addChild(this.frame);
         this.frame.touchable = false;
         this.frame2 = new Image(_loc2_);
         this.frame2.x = this.back2.x + 2;
         this.frame2.y = this.back2.y - 2;
         this.frame2.pivotX = 173;
         addChild(this.frame2);
         this.frame2.touchable = false;
         this.btnPause = new Button(GV.assets.getTexture("Btn_pause0000"));
         this.btnPause.x = GV.scr_X - 60;
         this.btnPause.y = 10;
         this.btnPause.useHandCursor = true;
         addChild(this.btnPause);
         this.btnPause.addEventListener(Event.TRIGGERED,this.touch_btns);
         this.btnSword = new Button(GV.assets.getTexture("SpelSword0000"));
         this.btnSword.x = GV.cent_X + 270;
         this.btnSword.y = 0;
         this.btnSword.useHandCursor = true;
         addChild(this.btnSword);
         this.btnSword.addEventListener(Event.TRIGGERED,this.touch_btns);
         this.btnSword.visible = false;
         this.btnClick = new Button(GV.assets.getTexture("BtnClick0000"));
         this.btnClick.x = GV.cent_X - 20;
         this.btnClick.y = 50;
         this.btnClick.width = GV.cent_X;
         this.btnClick.height = GV.groundY - 50;
         this.btnClick.visible = false;
         this.btnClick.alpha = 0;
         addChild(this.btnClick);
         this.btnClick.addEventListener(Event.TRIGGERED,this.ClickAttack);
         this.boostPY = GV.groundY + int(GV.scr_Y - GV.groundY) / 2 - 20;
         this.boost_0 = new BoostBtn();
         this.boost_0.init(GV.cent_X - 360,this.boostPY,0);
         addChild(this.boost_0);
         this.boost_0.visible = false;
         this.boost_1 = new BoostBtn();
         this.boost_1.init(this.boost_0.x + 70,this.boostPY,1);
         addChild(this.boost_1);
         this.boost_1.visible = false;
         this.boost_2 = new BoostBtn();
         this.boost_2.init(this.boost_1.x + 70,this.boostPY,2);
         addChild(this.boost_2);
         this.boost_2.visible = false;
         this.spellManager = new SpellManager();
         this.spellManager.InitButtons();
         this.hpTxt = new TextField(200,40,"141241/124124",new TextFormat("FontSilverExport",23,16442839,Align.CENTER));
         this.hpTxt.x = this.frame.x - 10;
         this.hpTxt.y = this.frame.y - 6;
         addChild(this.hpTxt);
         this.hpTxt.touchable = false;
         this.hpTxt2 = new TextField(200,40,"141241/124124",new TextFormat("FontSilverExport",23,16442839,Align.CENTER));
         this.hpTxt2.x = this.frame2.x - 173;
         this.hpTxt2.y = this.frame2.y - 6;
         addChild(this.hpTxt2);
         this.hpTxt2.touchable = false;
         this.hpTxt2.visible = false;
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this.btnSword)
         {
            this.ClickAttack();
         }
         if(_loc2_ as Button == this.btnPause)
         {
            if(GV.isPlay)
            {
               GV.isPlay = false;
               Tweener.pauseAllTweens();
               GV.game.SM.open_screen("Pause");
            }
         }
      }
      
      public function InitLevel() : *
      {
         this.AddCoins(0);
         this.spellManager.RefreshAll();
         this.boost_0.init_level();
         this.boost_1.init_level();
         this.boost_2.init_level();
         this.boost_0.y = this.boost_1.y = this.boost_2.y = this.boostPY;
         this.btnSword.y = GV.groundY + int(GV.scr_Y - GV.groundY) / 2 - 40;
         this.line.scaleX = 1;
         this.line2.scaleX = 0;
      }
      
      public function Tween_Life() : *
      {
         this.line2.scaleX = 0;
         Tweener.addTween(this.line2,{
            "scaleX":1,
            "time":0.7,
            "transition":"linear"
         });
      }
      
      public function Init_Line(param1:int) : *
      {
         var _loc6_:MovieClip = null;
         while(this._scullsArr.length > 0)
         {
            this._scullsArr[0].removeFromParent();
            this._scullsArr[0] = null;
            this._scullsArr.splice(0,1);
         }
         var _loc2_:* = GV.cent_X;
         var _loc3_:int = param1 * 30 / 2;
         var _loc4_:int = _loc2_ - _loc3_;
         this._lineCenter.width = _loc3_ * 2;
         this._lineCenter.x = _loc2_;
         this._lineR.x = _loc2_ + _loc3_ - 25;
         this._lineL.x = _loc2_ - this._lineR.width - _loc3_ + 35;
         this._scullsArr = [];
         var _loc5_:int = 0;
         while(_loc5_ < param1)
         {
            _loc6_ = new MovieClip(GV.assets.getTextures("BattleSkull"));
            _loc6_.x = _loc4_ + _loc5_ * 30 + 25 - _loc6_.width / 2;
            _loc6_.y = this._lineR.y - 9;
            addChild(_loc6_);
            _loc6_.touchable = false;
            this._scullsArr.push(_loc6_);
            _loc5_++;
         }
      }
      
      public function next_skull(param1:int) : *
      {
         var _loc2_:int = 0;
         while(_loc2_ < this._scullsArr.length)
         {
            if(param1 - 1 > _loc2_)
            {
               this._scullsArr[_loc2_].currentFrame = 2;
            }
            else if(param1 - 1 == _loc2_)
            {
               this._scullsArr[_loc2_].currentFrame = 1;
            }
            _loc2_++;
         }
      }
      
      public function ClickAttack(param1:Event = null) : *
      {
         var _loc2_:Effect = null;
         if(GV.LM.State == "Battle")
         {
            GV.numClick++;
            GV.hero.ClickAttack();
            GV.hero.Attack();
            GV.sound.playSFX("click_hit1");
            _loc2_ = new Effect();
            _loc2_.init(GV.touchX - GV.game._stage.x - 10,GV.touchY - 10,"ArrowEff",24);
         }
      }
      
      public function HeroLife(param1:Number) : *
      {
         this.line.scaleX = param1;
      }
      
      public function EnemyLife(param1:int) : *
      {
         this.enLife = this.enLife - param1;
         var _loc2_:Number = this.enLife / this.maxLife;
         if(this.enLife <= 0)
         {
            _loc2_ = 0;
            this.hpTxt2.visible = false;
         }
         this.line2.scaleX = _loc2_;
         this.hpTxt2.text = this.enLife + "/" + this.maxLife;
      }
      
      public function AddCoins(param1:int) : *
      {
      }
      
      public function HideBoost() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            Tweener.addTween(this["boost_" + _loc1_],{
               "y":GV.scr_Y + 100,
               "time":0.5,
               "transition":"linear"
            });
            _loc1_++;
         }
         Tweener.addTween(this.btnSword,{
            "y":GV.scr_Y + 100,
            "time":0.5,
            "transition":"linear"
         });
      }
   }
}
