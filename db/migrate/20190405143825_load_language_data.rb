class LoadLanguageData < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('aa','aar','aar','Afar');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ab','abk','abk','Abkhaz');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ae','ave','ave','Avestan');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('af','afr','afr','Afrikaans');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ak','aka','aka','Akan');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('am','amh','amh','Amharic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('an','arg','arg','Aragonese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ar','ara','ara','Arabic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('as','asm','asm','Assamese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('av','ava','ava','Avaric');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ay','aym','aym','Aymara');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('az','aze','aze','Azerbaijani');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('az','azb','azb','South Azerbaijani');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ba','bak','bak','Bashkir');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('be','bel','bel','Belarusian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bg','bul','bul','Bulgarian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bh','bih','bih','Bihari');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bi','bis','bis','Bislama');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bm','bam','bam','Bambara');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bn','ben','ben','Bengali');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bo','bod','tib','Tibetan Standard, Tibetan, Central');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('br','bre','bre','Breton');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('bs','bos','bos','Bosnian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ca','cat','cat','Catalan');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ce','che','che','Chechen');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ch','cha','cha','Chamorro');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('co','cos','cos','Corsican');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('cr','cre','cre','Cree');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('cs','ces','cze','Czech');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('cu','chu','chu','Old Church Slavonic, Church Slavonic, Old Bulgarian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('cv','chv','chv','Chuvash');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('cy','cym','wel','Welsh');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('da','dan','dan','Danish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('de','deu','ger','German');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('dv','div','div','Divehi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('dz','dzo','dzo','Dzongkha');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ee','ewe','ewe','Ewe');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('el','ell','gre','Greek, Modern');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('en','eng','eng','English');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('eo','epo','epo','Esperanto');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('es','spa','spa','Spanish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('et','est','est','Estonian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('eu','eus','baq','Basque');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fa','fas','per','Persian (Farsi)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ff','ful','ful','Fula');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fi','fin','fin','Finnish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fj','fij','fij','Fijian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fo','fao','fao','Faroese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fr','fra','fre','French');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('fy','fry','fry','Western Frisian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ga','gle','gle','Irish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('gd','gla','gla','Scottish Gaelic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('gl','glg','glg','Galician');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('gn','grn','grn','Guaraní');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('gu','guj','guj','Gujarati');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('gv','glv','glv','Manx');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ha','hau','hau','Hausa');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('he','heb','heb','Hebrew (modern)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('hi','hin','hin','Hindi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ho','hmo','hmo','Hiri Motu');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('hr','hrv','hrv','Croatian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ht','hat','hat','Haitian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('hu','hun','hun','Hungarian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('hy','hye','arm','Armenian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('hz','her','her','Herero');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ia','ina','ina','Interlingua');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('id','ind','ind','Indonesian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ie','ile','ile','Interlingue');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ig','ibo','ibo','Igbo');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ii','iii','iii','Nuosu');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ik','ipk','ipk','Inupiaq');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('io','ido','ido','Ido');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('is','isl','ice','Icelandic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('it','ita','ita','Italian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('iu','iku','iku','Inuktitut');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ja','jpn','jpn','Japanese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('jv','jav','jav','Javanese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ka','kat','geo','Georgian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kg','kon','kon','Kongo');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ki','kik','kik','Kikuyu, Gikuyu');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kj','kua','kua','Kwanyama, Kuanyama');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kk','kaz','kaz','Kazakh');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kl','kal','kal','Kalaallisut, Greenlandic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('km','khm','khm','Khmer');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kn','kan','kan','Kannada');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ko','kor','kor','Korean');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kr','kau','kau','Kanuri');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ks','kas','kas','Kashmiri');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ku','kur','kur','Kurdish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kv','kom','kom','Komi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('kw','cor','cor','Cornish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ky','kir','kir','Kyrgyz');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('la','lat','lat','Latin');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lb','ltz','ltz','Luxembourgish, Letzeburgesch');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lg','lug','lug','Ganda');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('li','lim','lim','Limburgish, Limburgan, Limburger');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ln','lin','lin','Lingala');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lo','lao','lao','Lao');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lt','lit','lit','Lithuanian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lu','lub','lub','Luba-Katanga');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('lv','lav','lav','Latvian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mg','mlg','mlg','Malagasy');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mh','mah','mah','Marshallese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mi','mri','mao','Māori');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mk','mkd','mac','Macedonian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ml','mal','mal','Malayalam');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mn','mon','mon','Mongolian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mr','mar','mar','Marathi (Marāṭhī)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ms','msa','may','Malay');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('mt','mlt','mlt','Maltese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('my','mya','bur','Burmese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('na','nau','nau','Nauru');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nb','nob','nob','Norwegian Bokmål');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nd','nde','nde','North Ndebele');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ne','nep','nep','Nepali');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ng','ndo','ndo','Ndonga');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nl','nld','dut','Dutch');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nn','nno','nno','Norwegian Nynorsk');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('no','nor','nor','Norwegian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nr','nbl','nbl','South Ndebele');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('nv','nav','nav','Navajo, Navaho');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ny','nya','nya','Chichewa');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('oc','oci','oci','Occitan');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('oj','oji','oji','Ojibwe, Ojibwa');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('om','orm','orm','Oromo');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('or','ori','ori','Oriya');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('os','oss','oss','Ossetian, Ossetic');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('pa','pan','pan','Panjabi, Punjabi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('pi','pli','pli','Pāli');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('pl','pol','pol','Polish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ps','pus','pus','Pashto, Pushto');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('pt','por','por','Portuguese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('pt-BR','pt-BR','pt-BR','Portuguese (Brazil)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('qu','que','que','Quechua');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('rm','roh','roh','Romansh');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('rn','run','run','Kirundi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ro','ron','rum','Romanian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ru','rus','rus','Russian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('rw','kin','kin','Kinyarwanda');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sa','san','san','Sanskrit (Saṁskṛta)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sc','srd','srd','Sardinian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sd','snd','snd','Sindhi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('se','sme','sme','Northern Sami');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sg','sag','sag','Sango');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('si','sin','sin','Sinhala, Sinhalese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sk','slk','slo','Slovak');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sl','slv','slv','Slovene');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sm','smo','smo','Samoan');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sn','sna','sna','Shona');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('so','som','som','Somali');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sq','sqi','alb','Albanian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sr','srp','srp','Serbian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ss','ssw','ssw','Swati');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('st','sot','sot','Southern Sotho');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('su','sun','sun','Sundanese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sv','swe','swe','Swedish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('sw','swa','swa','Swahili');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ta','tam','tam','Tamil');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('te','tel','tel','Telugu');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tg','tgk','tgk','Tajik');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('th','tha','tha','Thai');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ti','tir','tir','Tigrinya');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tk','tuk','tuk','Turkmen');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tl','tgl','tgl','Tagalog');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tn','tsn','tsn','Tswana');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('to','ton','ton','Tonga (Tonga Islands)');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tr','tur','tur','Turkish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ts','tso','tso','Tsonga');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tt','tat','tat','Tatar');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('tw','twi','twi','Twi');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ty','tah','tah','Tahitian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ug','uig','uig','Uyghur, Uighur');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('uk','ukr','ukr','Ukrainian');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ur','urd','urd','Urdu');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('uz','uzb','uzb','Uzbek');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('ve','ven','ven','Venda');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('vi','vie','vie','Vietnamese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('vo','vol','vol','Volapük');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('wa','wln','wln','Walloon');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('wo','wol','wol','Wolof');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('xh','xho','xho','Xhosa');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('yi','yid','yid','Yiddish');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('yo','yor','yor','Yoruba');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('za','zha','zha','Zhuang, Chuang');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('zh','zho','chi','Chinese');
      insert into languages (iso_639_1,iso_639_2t,iso_639_2b,description) values('zu','zul','zul','Zulu');
    SQL
  end

  def down
    execute <<-SQL
      delete from languages
    SQL
  end
end
