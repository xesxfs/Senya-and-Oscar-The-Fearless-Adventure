package com.general
{
   import flash.events.Event;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.media.SoundTransform;
   
   public class MySound
   {
      
      public static var _instance:MySound;
      
      public static var _allowInstance:Boolean = false;
       
      
      public var allowSounds:Boolean;
      
      public var allowSFX:Boolean;
      
      var sound:Object;
      
      var musics:Object;
      
      private var mSoundChannels:Array;
      
      private var mMusicChannel:SoundChannel;
      
      private const MAX_SOUND_CHANNELS:int = 18;
      
      public var vol_sound:Number = 0.8;
      
      public var vol_music:Number = 0.6;
      
      private var curMusName:String;
      
      private var _rand:int = 0;
      
      private var t0:int = 0;
      
      private var t1:int = 0;
      
      private var t2:int = 0;
      
      private var t3:int = 0;
      
      private var t4:int = 0;
      
      private var t5:int = 0;
      
      private var t6:int = 0;
      
      private var t7:int = 0;
      
      private var t8:int = 0;
      
      private var t9:int = 0;
      
      private var t10:int = 0;
      
      private var t11:int = 0;
      
      public function MySound()
      {
         super();
         if(!_allowInstance)
         {
            throw new Error("Error: Use TurtleSounds.getInstance () instead of the new keyword.");
         }
         this.initSounds();
      }
      
      public static function getInstance() : MySound
      {
         if(_instance == null)
         {
            _allowInstance = true;
            _instance = new MySound();
            _allowInstance = false;
         }
         return _instance;
      }
      
      private function initSounds() : void
      {
         this.allowSounds = true;
         this.allowSFX = true;
         this.mSoundChannels = [];
         this.sound = new Object();
         this.sound["win"] = new sound_01();
         this.sound["fail"] = new sound_02();
         this.sound["arrow"] = new sound_07();
         this.sound["click"] = new sound_12();
         this.sound["sell"] = new sound_13();
         this.sound["splash_1"] = new sound_16();
         this.sound["splash_2"] = new sound_17();
         this.sound["splash_3"] = new sound_18();
         this.sound["splash_4"] = new sound_19();
         this.sound["explosion"] = new sound_33();
         this.sound["click_hit1"] = new sound_40();
         this.sound["attack_1"] = new sound_41();
         this.sound["attack_2"] = new sound_42();
         this.sound["attack_3"] = new sound_43();
         this.sound["electro"] = new sound_44();
         this.sound["paw"] = new sound_45();
         this.sound["flame"] = new sound_46();
         this.sound["cat"] = new sound_47();
         this.sound["levelUp"] = new sound_48();
         this.sound["loot"] = new sound_49();
         this.sound["buy"] = new sound_50();
         this.sound["coin1"] = new sound_51();
         this.sound["coin2"] = new sound_52();
         this.sound["coin3"] = new sound_53();
         this.sound["forge"] = new sound_54();
         this.sound["chest"] = new sound_55();
         this.sound["info"] = new sound_56();
         this.sound["equip"] = new sound_57();
         this.sound["reward"] = new sound_58();
         this.sound["sword_1"] = new sound_59();
         this.sound["sword_2"] = new sound_60();
         this.sound["lock"] = new sound_61();
         this.musics = new Object();
         this.musics["menu"] = new mus_1();
         this.musics["game"] = new mus_2();
      }
      
      public function playSFX(param1:String) : void
      {
         var _loc5_:SoundChannel = null;
         if(!this.allowSFX || this.vol_sound < 0.001)
         {
            return;
         }
         var _loc2_:Sound = this.sound[param1];
         if(!this.sound)
         {
            return;
         }
         if(this.mSoundChannels.length >= this.MAX_SOUND_CHANNELS)
         {
            _loc5_ = this.mSoundChannels.shift();
            _loc5_.stop();
         }
         var _loc3_:SoundTransform = new SoundTransform();
         _loc3_.volume = this.vol_sound;
         var _loc4_:SoundChannel = _loc2_.play(0,0,_loc3_);
         this.mSoundChannels.push(_loc4_);
         _loc4_.addEventListener(Event.SOUND_COMPLETE,this.OnSFXComplete);
      }
      
      private function OnSFXComplete(param1:Event) : void
      {
         var _loc2_:SoundChannel = param1.currentTarget as SoundChannel;
         _loc2_.removeEventListener(Event.SOUND_COMPLETE,this.OnSFXComplete);
         var _loc3_:int = this.mSoundChannels.indexOf(_loc2_);
         this.mSoundChannels.splice(_loc3_,1);
      }
      
      public function setVolumeMUS(param1:*) : void
      {
         this.vol_music = param1;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function setVolumeSOUND(param1:*) : void
      {
         this.vol_sound = param1;
      }
      
      public function musOFF() : void
      {
         this.allowSounds = false;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function musON() : void
      {
         this.allowSounds = true;
         if(this.curMusName)
         {
            this.playMusic(this.curMusName);
         }
      }
      
      public function soundOFF() : void
      {
         this.allowSFX = false;
      }
      
      public function soundON() : void
      {
         this.allowSFX = true;
      }
      
      public function playMusic(param1:String) : void
      {
         var _loc2_:SoundTransform = new SoundTransform(this.vol_music);
         if(!this.allowSounds)
         {
            _loc2_.volume = 0;
         }
         if(this.curMusName != param1)
         {
            if(this.mMusicChannel)
            {
               this.mMusicChannel.stop();
               this.mMusicChannel = null;
            }
            if(!this.mMusicChannel)
            {
               this.mMusicChannel = this.musics[param1].play(0,9999,_loc2_);
            }
            this.curMusName = param1;
         }
         else
         {
            this.mMusicChannel.soundTransform = _loc2_;
         }
      }
      
      public function stopMusic() : void
      {
         if(this.mMusicChannel)
         {
            this.mMusicChannel.stop();
            this.curMusName = "";
         }
      }
      
      public function free_time() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ <= 10)
         {
            this["t" + _loc1_] = 0;
            _loc1_++;
         }
      }
      
      public function coin() : void
      {
         if(this.t1 < GV.real_time)
         {
            this.t1 = GV.real_time + 50;
            this.playSFX("coin" + Amath.random(1,3));
         }
      }
      
      public function sword() : void
      {
         if(this.t2 < GV.real_time)
         {
            this.t2 = GV.real_time + 50;
            this.playSFX("sword_" + Amath.random(1,2));
         }
      }
   }
}
