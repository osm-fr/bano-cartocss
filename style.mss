/*
autopilot 0.0.1
[{"id":"Map","background-color":"#b8dee6"}]
*/
Map { buffer-size: 200; }

@font: "DejaVu Sans Condensed";
@osmColor: #0a0;
@cadastreColor: blue;

#addr {
    opacity: 0.5;
    marker-width: 0.5;
	[zoom>=12] {marker-width: 1;}
	[zoom>=13] {marker-width: 2;}
	[zoom>=15] { opacity: 1; marker-width: 6;}
    marker-line-width: 0;
    marker-allow-overlap: true;
    [source='OSM'] { marker-fill: @osmColor; }
    [source='CADASTRE'] {
   	  marker-fill: @cadastreColor;
      [voie_osm=''] { marker-fill: red; } 
    }
    [zoom>=18] {
    marker-width: 4;
	text-name: [numero];
    text-face-name: @font;
    [source='OSM'] { text-fill: @osmColor; }
    [source='CADASTRE'] {
      text-fill: @cadastreColor;
      [voie_osm=''] { text-fill: red; } 
    }
	text-size: 10;
    text-dy: -4;
    [zoom>=19] { text-size: 12; }
    text-placement-type: simple;
    text-placements: "N,W,S,E,NW,NE,SE,SW";

    }
}

#addr_lz [zoom>=12]{
  [zoom>=10][cadastre>0][zoom<13]
  {
    text-name: [pourcent]+"%";
    text-face-name:@font;
    text-size: 12;
    text-halo-radius: 2;
    text-allow-overlap:true;
  }
  [zoom>=13]
  {
    line-color: grey;
    text-name: [insee]+" - "+[nom_com]+" "+[pourcent]+"%\n/";
    text-face-name:@font;
    text-allow-overlap:true;
    text-halo-radius: 3;
    text-size: 14;
    text-dy: -0.1;
    [nom_com=null] {
       text-name: [insee]+"\ncadastre non vectoriel";
       text-fill: grey;
    }    
    [cadastre=0][nom_com!=''] {
       text-name: [insee]+" - "+[nom_com]+"\nnon importé";
       text-fill: red;
    }
    [cadastre>0]{
    ::cadastre {
    text-name: "cadastre: "+[cadastre];
    text-face-name:@font;
    text-allow-overlap:true;
    text-fill: @cadastreColor;
    text-dx: 4;
    text-dy: -0.1;
    text-halo-radius: 3;
    text-size: 12;
    text-horizontal-alignment: right;
    }
  
    ::osm {
    text-name: "osm: "+[osm];
    text-face-name:@font;
    text-allow-overlap:true;
    text-fill: @osmColor;
    text-halo-radius: 3;
    text-dx: -4;
    text-dy: -0.1;
    text-size: 12;
    text-horizontal-alignment: left;
    }
    }
  }
}

#manque [zoom>=16] {
  line-color: red;
  line-width: 10;
  line-clip: false;
  line-join: round;
  line-cap: round;
  line-offset: 10;
  line-opacity: 0.25;
  text-name: [voie_cadastre];
  text-face-name: @font;
  text-allow-overlap: true;
  text-placement: line;
  text-fill: red;
  text-size: 12;
  text-dy: 20;

  b/text-name: [voie_cadastre];
  b/text-face-name: @font;
  b/text-allow-overlap: true;
  b/text-fill: red;
  b/text-size: 12;
  b/text-halo-radius: 3;
  b/text-halo-fill: fadeout(white,50%);
}
