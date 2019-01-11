package
{
   public class EmbeddedAssets
   {
      
      public static const art:Class = EmbeddedAssets_art;
      
      public static const artXml:Class = EmbeddedAssets_artXml;
      
      public static const art2:Class = EmbeddedAssets_art2;
      
      public static const artXml2:Class = EmbeddedAssets_artXml2;
      
      public static const Wall:Class = EmbeddedAssets_Wall;
      
      public static const Map:Class = EmbeddedAssets_Map;
      
      public static const art3:Class = EmbeddedAssets_art3;
      
      public static const artXml3:Class = EmbeddedAssets_artXml3;
      
      public static const art4:Class = EmbeddedAssets_art4;
      
      public static const artXml4:Class = EmbeddedAssets_artXml4;
      
      public static const _PNG:Class = EmbeddedAssets__PNG;
      
      public static const _JS:Class = EmbeddedAssets__JS;
      
      public static const Hero:Class = EmbeddedAssets_Hero;
      
      public static const _PNG1:Class = EmbeddedAssets__PNG1;
      
      public static const _JS1:Class = EmbeddedAssets__JS1;
      
      public static const En_1_Loc:Class = EmbeddedAssets_En_1_Loc;
      
      public static const _PNG2:Class = EmbeddedAssets__PNG2;
      
      public static const _JS2:Class = EmbeddedAssets__JS2;
      
      public static const En_2_Loc:Class = EmbeddedAssets_En_2_Loc;
      
      public static const _PNG3:Class = EmbeddedAssets__PNG3;
      
      public static const _JS3:Class = EmbeddedAssets__JS3;
      
      public static const En_3_Loc:Class = EmbeddedAssets_En_3_Loc;
      
      public static const _PNG4:Class = EmbeddedAssets__PNG4;
      
      public static const _JS4:Class = EmbeddedAssets__JS4;
      
      public static const En_4_Loc:Class = EmbeddedAssets_En_4_Loc;
      
      public static const _PNG5:Class = EmbeddedAssets__PNG5;
      
      public static const _JS5:Class = EmbeddedAssets__JS5;
      
      public static const En_5_Loc:Class = EmbeddedAssets_En_5_Loc;
      
      public static var PUTIN:Class = EmbeddedAssets_PUTIN;
      
      public static const RNXml:Class = EmbeddedAssets_RNXml;
      
      public static const RedNum:Class = EmbeddedAssets_RedNum;
      
      public static const GoldXML:Class = EmbeddedAssets_GoldXML;
      
      public static const FontGoldExport:Class = EmbeddedAssets_FontGoldExport;
      
      public static const SilverXML:Class = EmbeddedAssets_SilverXML;
      
      public static const FontSilverExport:Class = EmbeddedAssets_FontSilverExport;
      
      public static const GoldMiniXml:Class = EmbeddedAssets_GoldMiniXml;
      
      public static const GoldMini:Class = EmbeddedAssets_GoldMini;
      
      {
         GV.factory.parseDragonBonesData(JSON.parse(new Hero()),"Hero");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS()),new _PNG());
         GV.factory.parseDragonBonesData(JSON.parse(new En_1_Loc()),"En_1_Loc");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS1()),new _PNG1());
         GV.factory.parseDragonBonesData(JSON.parse(new En_2_Loc()),"En_2_Loc");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS2()),new _PNG2());
         GV.factory.parseDragonBonesData(JSON.parse(new En_3_Loc()),"En_3_Loc");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS3()),new _PNG3());
         GV.factory.parseDragonBonesData(JSON.parse(new En_4_Loc()),"En_4_Loc");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS4()),new _PNG4());
         GV.factory.parseDragonBonesData(JSON.parse(new En_5_Loc()),"En_5_Loc");
         GV.factory.parseTextureAtlasData(JSON.parse(new _JS5()),new _PNG5());
      }
      
      public function EmbeddedAssets()
      {
         super();
      }
   }
}
