package com.mygame.screens
{
   import caurina.transitions.Tweener;
   import starling.display.Image;
   import starling.display.MovieClip;
   import starling.display.Sprite;
   import starling.text.TextField;
   import starling.text.TextFormat;
   import starling.textures.Texture;
   import starling.utils.Align;
   
   public class RewardPanel extends Sprite
   {
       
      
      private var id:int;
      
      private var mc1:Image;
      
      private var mc2:Image;
      
      private var mc3:Image;
      
      private var coin:Image;
      
      private var frame:MovieClip;
      
      private var awardTxt:TextField;
      
      private var award:int;
      
      private var col:int = 0;
      
      public function RewardPanel()
      {
         super();
      }
      
      public function Add() : void
      {
         this.col++;
         this["mc" + this.col].texture = GV.assets.getTexture("Tr_icon" + this.id + "_0001");
         Tweener.addTween(this["mc" + this.col],{
            "scale":1.3,
            "time":0.2,
            "delay":0,
            "transition":"linear"
         });
         Tweener.addTween(this["mc" + this.col],{
            "scale":1,
            "time":0.1,
            "delay":0.2,
            "transition":"linear"
         });
         if(this.col == 3)
         {
            GV.coins = GV.coins + this.award;
            GV.game.SM.screen["stop_open"](this.awardTxt.text);
            this.frame = new MovieClip(GV.assets.getTextures("Tr_frame"),6);
            this.frame.y = -2;
            addChild(this.frame);
            this.frame.play();
            GV.juggler.add(this.frame);
            GV.treasury_openArr = [];
         }
      }
      
      public function Init(param1:int) : void
      {
         var _loc2_:Texture = null;
         this.id = param1;
         _loc2_ = GV.assets.getTexture("Tr_icon" + this.id + "_0000");
         this.mc1 = new Image(_loc2_);
         this.mc1.x = 20;
         this.mc1.y = 15;
         addChild(this.mc1);
         this.mc2 = new Image(_loc2_);
         this.mc2.x = 20 + 35;
         this.mc2.y = 15;
         addChild(this.mc2);
         this.mc3 = new Image(_loc2_);
         this.mc3.x = 20 + 70;
         this.mc3.y = 15;
         addChild(this.mc3);
         this.coin = new Image(GV.assets.getTexture("Tr_coin0000"));
         this.coin.x = 20 + 95;
         this.coin.y = 10;
         addChild(this.coin);
         this.awardTxt = new TextField(100,40,"500,000",new TextFormat("FontGoldExport",28,16777215,Align.LEFT));
         this.awardTxt.x = 135;
         this.awardTxt.y = -5;
         this.awardTxt.touchable = false;
         addChild(this.awardTxt);
         var _loc3_:int = 0;
         while(_loc3_ < GV.treasury_openArr.length)
         {
            if(GV.treasury_chestsArr[GV.treasury_openArr[_loc3_]] == this.id)
            {
               this.col++;
               this["mc" + this.col].texture = GV.assets.getTexture("Tr_icon" + this.id + "_0001");
            }
            _loc3_++;
         }
         this.award = int(Math.pow(1.2,GV.gameLevel + 15) * 100);
         switch(this.id)
         {
            case 0:
               break;
            case 1:
               this.award = int(this.award / 2);
               break;
            case 2:
               this.award = int(this.award / 4);
               break;
            case 3:
               this.award = int(this.award / 10);
               break;
            case 4:
         }
         if(this.award > 100 && this.award < 10000)
         {
            this.award = Math.floor(this.award / 10) * 10;
         }
         if(this.award > 10000 && this.award < 100000)
         {
            this.award = Math.floor(this.award / 100) * 100;
         }
         if(this.award > 100000)
         {
            this.award = Math.floor(this.award / 1000) * 1000;
         }
         this.awardTxt.text = "" + this.award;
      }
   }
}
