/*
autopilot 0.0.1
[{"id":"Map","background-color":"#b8dee6"}]
*/
Map { buffer-size: 256; }

@font: "DejaVu Sans Condensed";
@osmColor: #0a0;
@opendataColor: #Fb0;
@cadastreColor: blue;

#addr {
    opacity: 0.5;
    marker-width: 0.75;
    marker-line-width: 0;
    marker-allow-overlap: true;

  /* couleur du point */ 
  [source='S'] /* OSM */ {
    	marker-fill: @osmColor;
        [fant=''] { marker-fill: purple; } /* pas de rapprochement FANTOIR */
    }
    [source='D'] /* opendata */ { marker-fill: @opendataColor; }
    [source='A'] /* CADASTRE */{
   	  marker-fill: @cadastreColor;
      [voie_o=''] { marker-fill: red; } /* pas de rapprochement OSM */
    }
  
  /* taille en fonction du zoom */
	[zoom>=12] {marker-width: 1; [source='A'][voie_o='']{marker-width: 1.5;}}
	[zoom>=13] {marker-width: 2; [source='A'][voie_o='']{marker-width: 3;}}
	[zoom>=14] {marker-width: 3; [source='A'][voie_o='']{marker-width: 4;}}
	[zoom>=15] { opacity: 1; marker-width: 5; [source='A'][voie_o='']{marker-width: 7;}}
    [zoom>=18] {
    marker-width: 4;
    /* rendu du numéro aux plus forts zooms */
  /* couleur du numéro */ 
  [source='S'] /* OSM */ {
    	text-fill: @osmColor;
        [fant=''] { text-fill: purple; } /* pas de rapprochement FANTOIR */
    }
    [source='D'] /* opendata */ { text-fill: @opendataColor; }
    [source='A'] /* CADASTRE */{
   	  text-fill: @cadastreColor;
      [voie_o=''] { text-fill: red; } /* pas de rapprochement OSM */
    }
	text-name: [numero];
    text-face-name: @font;
	text-size: 10;
    text-dy: -4;
    text-placement-type: simple;
    text-placements: "N,W,S,E,NW,NE,SE,SW";
    [zoom>=19] { text-size: 12; }
    }
}

#fantoir [zoom>=12]{
  [zoom>=10][format_cadastre='VECT'][zoom<13]
  {
    text-name: [nb];
    text-face-name:@font;
    text-size: 12;
    text-halo-radius: 2;
    text-allow-overlap:true;
    [min_fantoir = null][nb=1] { text-name: ''; }
    [nb>0] { text-fill: red; }
  }
  [zoom>=13]
  {
    line-color: white;
    line-dasharray: 4,8;
    line-width: 3;
    line-cap: round;
    line-join: round;
    line-opacity: 0.75;
    
    text-name: [insee]+" - "+[nom];
    text-face-name:@font;
    text-allow-overlap:true;
    text-halo-radius: 3;
    text-size: 14;
    [nom=null],[format_cadastre!='VECT'] {
       text-name: [insee]+" - "+[nom]+"\ncadastre non vectoriel";
       text-fill: grey;
    }
    ::fantoir [format_cadastre='VECT'][nb>0]{
	    text-name: [nb]+" voies d'écart";
        [nb=1] { text-name: [nb]+" voie d'écart"; }
        text-face-name:@font;
	    text-allow-overlap:true;
	    text-halo-radius: 3;
	    text-size: 14;
		text-dy: 10;
        text-fill: red;
	    [min_fantoir = null][nb=1] { text-name: "";}
    }
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
    line-color: white;
    line-dasharray: 4,8;
    line-width: 3;
    line-cap: round;
    line-join: round;
    line-opacity: 0.75;
    
    text-name: [insee]+" - "+[nom_com]+" "+[pourcent]+"%\n/";
    text-face-name:@font;
    text-allow-overlap:true;
    text-halo-radius: 3;
    text-size: 14;
    text-dy: -0.1;
    [nom_com=null],[format_cadastre!='VECT'] {
       text-name: [insee]+" - "+[nom_com]+"\ncadastre non vectoriel";
       text-fill: grey;
    }
    [cadastre=0][format_cadastre='VECT'] {
       text-name: [insee]+" - "+[nom_com]+"\npas encore traité";
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
  polygon-clip: false;
  polygon-opacity: 0;
  polygon-smooth: 0.5;
  line-color: red;
  line-width: 10;
  line-clip: false;
  line-join: round;
  line-cap: round;
  line-smooth: 0.5;
  line-offset: 10;
  line-opacity: 0.25;
  text-name: [voie_cadastre]+[voie_osm];
  text-face-name: @font;
  text-allow-overlap: false;
  text-placement: line;
  text-spacing: 100;
  text-fill: red;
  text-size: 12;
  text-dy: 20;

  b/text-name: [voie_cadastre];
  b/text-face-name: @font;
  b/text-allow-overlap: true;
  b/text-fill: red;
  b/text-size: 14;
  b/text-halo-radius: 3;
  b/text-halo-fill: fadeout(white,50%);
  b/text-dy: 10; // décallage si pas assez de points pour avoir une surface (pour voir les points)
  [zoom>=17] {
    b/text-name: [voie_cadastre]+"\n"+[fantoir]+" ("+[nb]+")";
    b/text-character-spacing: 1;
  }
  [zoom>=18] {
    b/text-size: 16;
  }

  [source='OSM'] /* OSM */ {
    text-fill: purple;
    line-color: purple;
    b/text-fill: purple;
    b/text-dy: 0;
    b/text-name: [voie_osm]+" ("+[nb]+")";
  }

}

#lieuxdits [zoom>=15] {
  text-name: [libelle_cadastre];
  [zoom>=17] {text-name: [libelle_cadastre]+"\n"+[fantoir]; }
  text-face-name: "DejaVu Sans Mono Oblique";
  text-fill: #666;
  text-size: 12;
  text-wrap-width: 40;
  text-allow-overlap: true;
  text-halo-radius: 1;
}
