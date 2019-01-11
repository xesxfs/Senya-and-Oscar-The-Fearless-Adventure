package com.mygame.screens
{
   import com.general.Amath;
   import com.mygame.effects.GravityIscra;
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.animation.WorldClock;
   import dragonBones.events.EventObject;
   import dragonBones.starling.StarlingArmatureDisplay;
   import dragonBones.starling.StarlingEvent;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.EnterFrameEvent;
   import starling.events.Event;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.utils.Align;
   
   public class ScreenForge extends ScrBase
   {
       
      
      private var nameTxt:TextField;
      
      public var crystTxt:TextField;
      
      private var _btnQuit:Button;
      
      public var state:String = "wait";
      
      public var animation:String = "Forge_Idle";
      
      public var numKick:int;
      
      private var crystImg:Image;
      
      public var _armature:Armature = null;
      
      public var _armatureDisplay:StarlingArmatureDisplay = null;
      
      public var _button_1:ForgeButton;
      
      public var _button_2:ForgeButton;
      
      public var _button_3:ForgeButton;
      
      public var _icon:Cell_Forge;
      
      public var _type:int;
      
      public function ScreenForge()
      {
         super();
         this.draw();
         GV.game.addChildAt(this,0);
         this.activation();
      }
      
      override public function activation() : void
      {
         this._btnQuit.addEventListener(Event.TRIGGERED,this.touch_btns);
         addEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function deactivation() : void
      {
         this._btnQuit.removeEventListener(Event.TRIGGERED,this.touch_btns);
         removeEventListener(EnterFrameEvent.ENTER_FRAME,this.update);
      }
      
      override public function free() : void
      {
         this._button_1.Free();
         this._button_2.Free();
         this._armatureDisplay.removeFromParent(true);
         WorldClock.clock.remove(this._armature);
         this._armature = null;
         super.free();
      }
      
      public function touch_btns(param1:Event) : void
      {
         var _loc2_:Button = param1.target as Button;
         if(_loc2_ as Button == this._btnQuit)
         {
            GV.sound.playSFX("click");
            this.deactivation();
            GV.game.SM.transition_screen("Map",false);
         }
      }
      
      public function update(param1:EnterFrameEvent) : void
      {
         GV.juggler.advanceTime(param1.passedTime);
         WorldClock.clock.advanceTime(-1);
      }
      
      override public function draw() : void
      {
         var _loc1_:Image = null;
         var _loc2_:Image = null;
         _loc1_ = new Image(GV.assets.getTexture("Wall"));
         _loc1_.pivotY = 0;
         _loc1_.pivotX = 0;
         _loc1_.x = GV.cent_X - _loc1_.width / 2;
         _loc1_.y = GV.cent_Y - _loc1_.height / 2;
         addChild(_loc1_);
         this._btnQuit = new Button(GV.assets.getTexture("Btn_back" + "0000"));
         this._btnQuit.x = int(GV.scr_X - this._btnQuit.width - 15);
         this._btnQuit.y = 10;
         addChild(this._btnQuit);
         this._armature = GV.factory.buildArmature("HeroAnimation");
         this._armature.animation.timeScale = 1.2;
         this._armatureDisplay = this._armature.display as StarlingArmatureDisplay;
         this._armatureDisplay.addEventListener(EventObject.LOOP_COMPLETE,this._animationHandler);
         this._armature.animation.play("Forge_Idle",999999999);
         this._armatureDisplay.scale = 1.4;
         this._armatureDisplay.x = GV.cent_X - 280;
         this._armatureDisplay.y = GV.scr_Y - 105;
         addChild(this._armatureDisplay);
         WorldClock.clock.add(this._armature);
         this.ChangeImg("head","ForgeHead_0000");
         this.ChangeImg("sword","ForgeHamer_0000");
         this.ChangeImg("handL","ForgeMetall_0000");
         this.crystImg = new Image(GV.assets.getTexture("Tr_item2_0000"));
         this.crystImg.x = 50;
         this.crystImg.y = 40;
         addChild(this.crystImg);
         this.nameTxt = new TextField(300,40,"",new TextFormat("FontGoldExport",35,16777215,Align.CENTER));
         this.nameTxt.x = GV.cent_X - int(this.nameTxt.width / 2);
         this.nameTxt.y = 10;
         this.nameTxt.touchable = false;
         addChild(this.nameTxt);
         this.crystTxt = new TextField(300,40,"x" + GV.crystals,new TextFormat("FontSilverExport",35,16777215,Align.LEFT));
         this.crystTxt.x = this.crystImg.x + 33;
         this.crystTxt.y = this.crystImg.y - 25;
         this.crystTxt.touchable = false;
         addChild(this.crystTxt);
         _loc2_ = new Image(GV.assets.getTexture("Wood0000"));
         _loc2_.width = GV.scr_X + 10;
         _loc2_.x = 0;
         _loc2_.y = GV.scr_Y - 105;
         addChild(_loc2_);
         var _loc3_:int = GV.cent_X + 70;
         var _loc4_:int = GV.cent_Y - 100;
         var _loc6_:int = 1;
         while(_loc6_ <= 2)
         {
            this["_button_" + _loc6_] = new ForgeButton();
            this["_button_" + _loc6_].Init(_loc3_,_loc4_ + 90 * (_loc6_ - 1),_loc6_);
            addChild(this["_button_" + _loc6_]);
            _loc6_++;
         }
         this.translate();
      }
      
      public function _animationHandler(param1:StarlingEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:GravityIscra = null;
         switch(this.animation)
         {
            case "Forge_Kick":
               _loc2_ = this._armatureDisplay.x + 90 * this._armatureDisplay.scale;
               _loc3_ = this._armatureDisplay.y - 83 * this._armatureDisplay.scale;
               GV.sound.playSFX("forge");
               _loc4_ = 0;
               while(_loc4_ <= 15)
               {
                  _loc5_ = new GravityIscra();
                  _loc5_.init(_loc2_,_loc3_,"Iscra0000",Amath.random(2,10) / 10);
                  addChildAt(_loc5_,1);
                  _loc4_++;
               }
               this.animation = "ForgeReturn";
               this._armature.animation.play(this.animation,1);
               if(this.numKick == 1)
               {
                  GV.sound.playSFX("loot");
                  this._icon = new Cell_Forge();
                  this._icon.x = _loc2_;
                  this._icon.y = _loc3_;
                  this._icon.Init(this._type);
                  addChild(this._icon);
               }
               GV.save.localSave();
               break;
            case "ForgeReturn":
               this.numKick--;
               if(this.numKick > 0)
               {
                  this.animation = "Forge_Kick";
                  this._armature.animation.play(this.animation,1);
                  break;
               }
               this.animation = "Forge_Idle";
               this._armature.animation.play(this.animation,999999999);
               break;
         }
      }
      
      override public function translate() : void
      {
         if(GV.settings[2] == 1)
         {
            this.nameTxt.text = "Forge";
         }
         if(GV.settings[2] == 2)
         {
            this.nameTxt.text = "Кузница";
         }
      }
      
      public function ChangeImg(param1:String, param2:String) : void
      {
         var _loc3_:Slot = this._armature.getSlot(param1);
         _loc3_.display = new Sprite();
         var _loc4_:Image = new Image(GV.assets.getTexture(param2));
         _loc3_.display.addChild(_loc4_);
      }
      
      public function Craft(param1:int) : void
      {
         if(this._icon)
         {
            this._icon.Free();
            this._icon = null;
         }
         this.crystTxt.text = "x" + GV.crystals;
         this.state = "kick";
         this.animation = "Forge_Kick";
         this._armature.animation.play("Forge_Kick",1);
         this.numKick = 3;
         this._type = param1;
      }
   }
}
