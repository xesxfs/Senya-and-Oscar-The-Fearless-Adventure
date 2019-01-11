package
{
   import com.Game;
   import com.Main;
   import com.general.MySaveGame;
   import com.general.MySound;
   import com.mygame.managers.LevelManager;
   import com.mygame.objects.Cat;
   import com.mygame.objects.Hero;
   import dragonBones.starling.StarlingFactory;
   import starling.animation.Juggler;
   import starling.assets.AssetManager;
   import starling.core.Starling;
   
   public class GV
   {
      
      public static var debug:Boolean = false;
      
      public static var isWEB:Boolean = true;
      
      public static var main:Main;
      
      public static var game:Game;
      
      public static var _width:int = 800;
      
      public static var _height:int = 500;
      
      public static var scr_X:int;
      
      public static var scr_Y:int;
      
      public static var cent_X:int;
      
      public static var cent_Y:int;
      
      public static var dX:int = 0;
      
      public static var dY:int = 0;
      
      public static var assets:AssetManager;
      
      public static var starling:Starling;
      
      public static var juggler:Juggler;
      
      public static var factory:StarlingFactory = new StarlingFactory();
      
      public static var real_time:int = 0;
      
      public static var start_time:int = 0;
      
      public static var delta:int = 0;
      
      public static var touchX:int = 0;
      
      public static var touchY:int = 0;
      
      public static var groundY:int = 0;
      
      public static var isPlay:Boolean = false;
      
      public static var isTouch:Boolean = false;
      
      public static var sound:MySound = MySound.getInstance();
      
      public static var save:MySaveGame = MySaveGame.getInstance();
      
      public static var LM:LevelManager;
      
      public static var settings = [6,6,1];
      
      public static var location:int = 1;
      
      public static var gameLevel:int = 0;
      
      public static var coins:int = 450;
      
      public static var crystals:int = 0;
      
      public static var hero:Hero;
      
      public static var cat:Cat;
      
      public static var posHero:int = 0;
      
      public static var posX:int = 0;
      
      public static var numClick:int = 0;
      
      public static var levelComplete:Boolean = true;
      
      public static var inventory:Array = [];
      
      public static var equipment:Array = [null,null,null,null,null];
      
      public static var shop:Array = [];
      
      public static var bag:Array = [null,null,null];
      
      public static var potions:Array = [];
      
      public static var treasury_openArr:Array = [];
      
      public static var treasury_chestsArr:Array = [];
      
      public static var treasury_keys:int = 0;
      
      public static var freeExp:Array = [0,0];
      
      public static var curExp:Array = [0,0];
      
      public static var levels:Array = [1,1];
      
      public static var multiExp:int;
      
      public static var multiCoins:int;
      
      public static var shopIndex:Array = [0,0,0,0,0];
      
      public static var freeCoins:int = 0;
      
      public static var loot:Array = [0,0,0,0,0,0,0];
      
      public static var chance = {
         "key":0.1,
         "crystal":0.1,
         "item":0.1,
         "uncomon":80,
         "rare":95,
         "legend":100
      };
      
      public static var godMode:Boolean = false;
      
      public static var isTreasure:Boolean = false;
      
      public static var isForge:Boolean = false;
       
      
      public function GV()
      {
         super();
      }
   }
}
