package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import com.general.Amath;
   import com.general.IGameObject;
   import com.mygame.effects.ChestParts;
   import starling.display.Button;
   import starling.display.Image;
   import starling.display.Sprite;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import starling.events.TouchPhase;
   
   public class ChestTreasury extends Sprite implements IGameObject
   {
       
      
      private var index:int;
      
      private var id:int;
      
      private var btn:Button;
      
      private var sun:Image;
      
      private var img:Image;
      
      public var _isFree:Boolean = false;
      
      public var _state:int = 0;
      
      public var speedY:Number = 0;
      
      public function ChestTreasury()
      {
         super();
      }
      
      public function init(param1:int) : void
      {
         this.index = param1;
         this.id = GV.treasury_chestsArr[this.index];
         var _loc2_:int = 0;
         while(_loc2_ < GV.treasury_openArr.length)
         {
            if(GV.treasury_openArr[_loc2_] == this.index)
            {
               this._state = 2;
               this.img = new Image(GV.assets.getTexture("Tr_item" + this.id + "_0000"));
               this.img.x = 40;
               this.img.y = 30;
               this.img.scale = 1;
               addChild(this.img);
            }
            _loc2_++;
         }
         if(this._state == 0)
         {
            this.btn = new Button(GV.assets.getTexture("Tr_chest0000"));
            addChild(this.btn);
            this.btn.addEventListener(TouchEvent.TOUCH,this.onTouch);
         }
         GV.game.effects.add(this);
      }
      
      public function free() : void
      {
         if(!this._isFree)
         {
            this._isFree = true;
            GV.game.effects.remove(this);
            if(this.btn)
            {
               this.btn.addEventListener(TouchEvent.TOUCH,this.onTouch);
               this.btn.removeFromParent(true);
            }
            if(this.sun)
            {
               Tweener.removeTweens(this.sun);
               this.sun.removeFromParent(true);
            }
            if(this.img)
            {
               Tweener.removeTweens(this.img);
               this.img.removeFromParent(true);
            }
            this.removeFromParent(true);
         }
      }
      
      public function update(param1:Number) : void
      {
         if(this._state == 1)
         {
            this.sun.rotation = this.sun.rotation + 0.2 * param1;
            if(this.sun.scale <= 0)
            {
               this._state = 2;
            }
         }
         if(this._state == 3)
         {
            y = y + this.speedY;
            if(y > GV.scr_Y)
            {
               this.free();
            }
         }
      }
      
      public function fall() : void
      {
         this._state = 3;
         this.speedY = Amath.random(60,80) / 10;
      }
      
      public function open() : void
      {
         if(this._state == 0)
         {
            this.btn.visible = false;
            this.img = new Image(GV.assets.getTexture("Tr_item" + this.id + "_0000"));
            this.img.x = 40;
            this.img.y = 30;
            this.img.alpha = 0.2;
            addChild(this.img);
            this.img.touchable = false;
         }
      }
      
      private function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:ChestParts = null;
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            if(_loc2_.phase == TouchPhase.BEGAN)
            {
               if(GV.treasury_keys > 0 || GV.treasury_keys == 0 && GV.treasury_openArr.length != 0)
               {
                  if(this._state == 0 && GV.game.SM.screen["_state"] != "stop")
                  {
                     this.btn.visible = false;
                     GV.sound.playSFX("chest");
                     _loc3_ = 0;
                     while(_loc3_ < 3)
                     {
                        _loc4_ = 1;
                        while(_loc4_ < 4)
                        {
                           _loc5_ = new ChestParts();
                           _loc5_.init(x + Amath.random(20,60),y + Amath.random(20,60),"Tr_part" + _loc4_ + "_0000");
                           _loc4_++;
                        }
                        _loc3_++;
                     }
                     _loc5_ = new ChestParts();
                     _loc5_.init(x + Amath.random(20,60),y + Amath.random(20,60),"Tr_part" + 5 + "_0000");
                     parent.setChildIndex(this,parent.numChildren - 1);
                     this.sun = new Image(GV.assets.getTexture("Sun0000"));
                     this.sun.x = 40;
                     this.sun.y = 30;
                     this.sun.scale = 0.2;
                     addChild(this.sun);
                     this.sun.touchable = false;
                     Tweener.addTween(this.sun,{
                        "scale":1,
                        "time":0.4,
                        "delay":0,
                        "transition":"linear"
                     });
                     Tweener.addTween(this.sun,{
                        "scale":0,
                        "time":0.4,
                        "delay":0.7,
                        "transition":"linear"
                     });
                     this.img = new Image(GV.assets.getTexture("Tr_item" + this.id + "_0000"));
                     this.img.x = 40;
                     this.img.y = 30;
                     this.img.scale = 0.2;
                     addChild(this.img);
                     this.img.touchable = false;
                     Tweener.addTween(this.img,{
                        "scale":1.2,
                        "time":0.2,
                        "delay":0,
                        "transition":"linear"
                     });
                     Tweener.addTween(this.img,{
                        "scale":1,
                        "time":0.1,
                        "delay":0.2,
                        "transition":"linear"
                     });
                     this._state = 1;
                     if(GV.treasury_openArr.length == 0)
                     {
                        GV.treasury_keys--;
                        GV.game.SM.screen["keyTxt"].text = "x" + GV.treasury_keys;
                     }
                     GV.treasury_openArr.push(this.index);
                     GV.game.SM.screen["add_item"](this.id);
                  }
                  GV.save.localSave();
               }
               else
               {
                  GV.sound.playSFX("lock");
               }
            }
         }
      }
   }
}
