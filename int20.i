/*
When your character has 20 Int, is running an analysis program meta-gaming?

When your character has 20 Int and 10 Wis, is the best way to calculate things through brute force methods?

*/
#include "/ycode/lab.i"
//needs fast_bin


//Details of your character
HPmax = 73;
ACmoi = 15;

INTb =  5;
CONb =  2;
DEXb =  2;
WISb = -1;
CHRb =  1;
STRb = -1;

PROFb = 4;

ATbon = INTb+PROFb;
DCspl = 8+PROFb+INTb;

//Details of model enemy
ACref = 18;
DEXref = 0;
CONref = 2;
WISref = 1;

//Iteration limit for brute force methods
num = 2^14;

func lightningGem(void,AC=,adv=,Abon=,Dbon=,qt=){
  adv = is_void(adv)?0:adv;
  AC = is_void(AC)?ACref:AC;
  Abon = is_void(Abon)?ATbon:Abon;
  Dbon = is_void(Dbon)?Dbon:INTb;

  //radiant weapon +1/+1
  //Dbon+=1;
  //Abon+=1;

  color=["green","red","black"](adv);

  xx = indgen(0:45);
  ff = xx*0;
  rolls = int(1+20*random([3,2,2,num]));
  if( adv==1 ) rolls = rolls(max,,);
  if( adv==-1) rolls = rolls(min,,);
  if( adv==0 ) rolls = rolls(1,,);
  qq = ( (rolls+Abon>AC)*(int(1+6*random([2,2,num]))+Dbon)+(int(1+6*random([2,2,num]))*(rolls==20)) )(sum,);
  qq+=(int(1+random(num)*6)*(!(!qq)) );
  bb=fast_bin(qq,xx,ff);
  ff*=1.; xx*=1.;
  expd = sum(xx*ff/sum(ff));
  sigd = sqrt( avg( (xx-expd)^2 * ff/sum(ff) ) );
  accy = 1. - ff(1)/sum(ff);
  

  plh,ff/num,xx-.5,color="yellow",width=6;
  plh,ff/num,xx-.5,color=color,width=2;
  plot,expd,ff(int(round(expd))+1)/num,color=color;
  if(is_void(qt)){
    fmt = "DMG: %4.3g +/- %4.2g | Acc: %.3g%%\n";
    if(adv==0) fmt = "Lightning Gem  "+fmt;
    if(adv!=0) fmt = "               "+fmt;
    write,format=fmt,expd,sigd,accy*100;
  }
  return expd;
}

func LightningBolt(void,DC=,adv=,sav=,qt=){
  adv = is_void(adv)?0:adv;
  DC = is_void(AC)?DCspl:DC;
  sav = is_void(sav)?DEXref:sav;

  color=["green","red","black"](adv);

  xx = indgen(0:50);
  ff = xx*0;
  rolls = int(1+20*random([2,2,num]));
  if( adv==1 ) rolls = rolls(max,);
  if( adv==-1) rolls = rolls(min,);
  if( adv==0 ) rolls = rolls(1,);
  
  qq = int(1+6*random([2,8,num]))(sum,)*( 1+(rolls+sav<=DC))*.5;
  bb=fast_bin(qq,xx,ff);
  ff*=1.; xx*=1.;
  expd = sum(xx*ff/sum(ff));
  sigd = sqrt( avg( (xx-expd)^2 * ff/sum(ff) ) );
  accy = 1. - ff(1)/sum(ff);

  if(is_void(qt)){
    plh,ff/num,xx-.5,color="blue",width=6;
    plh,ff/num,xx-.5,color=color,width=2;
    plot,expd,ff(int(round(expd))+1)/num,color=color;
    fmt = "DMG: %4.3g +/- %4.2g | Acc: %.3g%%\n";
    if(adv==0) fmt = "Lightning Bolt "+fmt;
    if(adv!=0) fmt = "               "+fmt;
    write,format=fmt,expd,sigd,accy*100;
  }
  return expd;
}

func thunderwave(void,DC=,adv=,sav=,qt=){
  adv = is_void(adv)?0:adv;
  DC = is_void(AC)?DCspl:DC;
  sav = is_void(sav)?CONref:sav;

  color=["green","red","black"](adv);

  xx = indgen(0:50);
  ff = xx*0;
  rolls = int(1+20*random([2,2,num]));
  if( adv==1 ) rolls = rolls(max,);
  if( adv==-1) rolls = rolls(min,);
  if( adv==0 ) rolls = rolls(1,);
  
  qq = int(1+2*random([2,8,num]))(sum,)*( 1+(rolls+sav<=DC))*.5;
  bb=fast_bin(qq,xx,ff);
  ff*=1.; xx*=1.;
  expd = sum(xx*ff/sum(ff));
  sigd = sqrt( avg( (xx-expd)^2 * ff/sum(ff) ) );
  accy = 1. - ff(1)/sum(ff);

  if(is_void(qt)){
    plh,ff/num,xx-.5,color=[255,165,0],width=6;
    plh,ff/num,xx-.5,color=color,width=2;
    plot,expd,ff(int(round(expd))+1)/num,color=color;
    fmt = "DMG: %4.3g +/- %4.2g | Acc: %.3g%%\n";
    if(adv==0) fmt = "Thunderwave    "+fmt;
    if(adv!=0) fmt = "               "+fmt;
    write,format=fmt,expd,sigd,accy*100;
  }
  return expd;
}

func shatter(void,DC=,adv=,sav=,qt=){
  adv = is_void(adv)?0:adv;
  DC = is_void(AC)?DCspl:DC;
  sav = is_void(sav)?CONref:sav;

  color=["green","red","black"](adv);

  xx = indgen(0:50);
  ff = xx*0;
  rolls = int(1+20*random([2,2,num]));
  if( adv==1 ) rolls = rolls(max,);
  if( adv==-1) rolls = rolls(min,);
  if( adv==0 ) rolls = rolls(1,);
  
  qq = int(1+3*random([2,8,num]))(sum,)*( 1+(rolls+sav<=DC))*.5;
  bb=fast_bin(qq,xx,ff);
  ff*=1.; xx*=1.;
  expd = sum(xx*ff/sum(ff));
  sigd = sqrt( avg( (xx-expd)^2 * ff/sum(ff) ) );
  accy = 1. - ff(1)/sum(ff);

  if(is_void(qt)){
    plh,ff/num,xx-.5,color=[255,165,0],width=6;
    plh,ff/num,xx-.5,color=color,width=2;
    plot,expd,ff(int(round(expd))+1)/num,color=color;
    fmt = "DMG: %4.3g +/- %4.2g | Acc: %.3g%%\n";
    if(adv==0) fmt = "Shatter        "+fmt;
    if(adv!=0) fmt = "               "+fmt;
    write,format=fmt,expd,sigd,accy*100;
  }
  return expd;
}


func catapult(void,DC=,adv=,sav=,qt=){
  adv = is_void(adv)?0:adv;
  DC = is_void(AC)?DCspl:DC;
  sav = is_void(sav)?DEXref:sav;

  color=["green","red","black"](adv);

  xx = indgen(0:25);
  ff = xx*0;
  rolls = int(1+20*random([2,2,num]));
  if( adv==1 ) rolls = rolls(max,);
  if( adv==-1) rolls = rolls(min,);
  if( adv==0 ) rolls = rolls(1,);
  
  qq = int(1+8*random([2,3,num]))(sum,)*(rolls+sav<=DC);
  bb=fast_bin(qq,xx,ff);
  ff*=1.; xx*=1.;
  expd = sum(xx*ff/sum(ff));
  sigd = sqrt( avg( (xx-expd)^2 * ff/sum(ff) ) );
  accy = 1. - ff(1)/sum(ff);

  if(is_void(qt)){
    plh,ff/num,xx-.5,color="grayc",width=6;
    plh,ff/num,xx-.5,color=color,width=2;
    plot,expd,ff(int(round(expd))+1)/num,color=color;
    fmt = "DMG: %4.3g +/- %4.2g | Acc: %.3g%%\n";
    if(adv==0) fmt = "Catapult       "+fmt;
    if(adv!=0) fmt = "               "+fmt;
    write,format=fmt,expd,sigd,accy*100;
  }
  return expd;
}


func blastin(void,AC=,Abon=,Dbon=,dexsav=,consav=,strsav=){
  fma;
  for(adv=1; adv>=-1; adv--) lightningGem,AC=AC,adv=adv,Abon=Abon,Dbon=Dbon;
  write,array("-",43)(sum);
  write,format="Magic Missile  DMG: %4.3g +/- %4.3g | Acc: 100%%\n",3.5*3,1.118*3;
  write,"";
  for(adv=-1; adv<=1; adv++) catapult,DC=DCspl,adv=adv,sav=dexsav;
  write,"";
  for(adv=-1; adv<=1; adv++) thunderwave,DC=DCspl,adv=adv,sav=consav;
  write,array("-",43)(sum);
  write,format="Magic Missile  DMG: %4.3g +/- %4.3g | Acc: 100%%\n",3.5*4,1.118*4;
  write,"";
  for(adv=-1; adv<=1; adv++) shatter, DC=DCspl,adv=adv,sav=consav
  write,array("-",43)(sum);
  write,format="Magic Missile  DMG: %4.3g +/- %4.3g | Acc: 100%%\n",3.5*5,1.118*5;
  write,"";
  for(adv=-1; adv<=1; adv++) LightningBolt,DC=DCspl,adv=adv,sav=dexsav;

}

func Focus(void,conb=,adv=,nop=){
  adv = is_void(adv)?0:adv;
  conb = is_void(conb)?CONb:conb;

  dmgarr = indgen(HPmax);
  concdc = max(10.,ceil(dmgarr*.5));

  num = 2^18;
  rolls = int(1+20*random([2,2,num]));
  if( adv==1 ) rolls = rolls(max,);
  if( adv==-1) rolls = rolls(min,);
  if( adv==0 ) rolls = rolls(1,);

  succss = dmgarr*0.;
  for(d=1; d<=numberof(dmgarr); d++){
    succss(d) = avg(rolls+conb+PROFb>=concdc(d));
  }

  color=["green","red","black"](adv);
  if(is_void(nop)){
    for(i=1; i<=3; i++) plh,succss^i,dmgarr-.5,color=color,width=2*(4-i);
    limits,e,e,0,1;
    gridxy,1,1;
  }
  return succss;
}
  

  


func guardx(void){
  blastin,AC=18,dexsav=0,consav=2,strsav=1;
  fma;
  lightningGem,AC=18,adv=1,qt=1;
  lightningGem,AC=18,adv=-1,qt=1;
  lightningGem,AC=18,adv=0,qt=1;
}

func killHvy(void){
  conp = Focus(nop=1);
  xhp = gdm = array(0,12);
  limits,0,12,0,100;

  hp = HPmax;
  dmg = 0;
  
  xhp(1) = hp;
  gdm(1) = 0;

  hm = 0;
  s3 = 2;
  s2 = 3;
  
  for(r=1; r<=11; r++){
    for(attack=1; attack<=3; attack++){
      if( int(1+20*min(random(1+hm)))+8 > ACmoi ){
        hit = int(1+10*random());
        if(attack<=2) hit+=4;
        hm*= random()<=conp(hit);
        hp-=hit;
      }
    }

    if(hm){
        dmg += int(1+8*random(hm))(sum);
        
        rolls = int(1+20*random(2,2,2));
        if(hm) rolls=rolls(max,);
        else rolls = rolls(1,);
        dmg += sum(int(1+6*random(2)+6)*(rolls>ACref));
        dmg += sum(int(1+6*random(2))*(rolls==20));
        if(anyof(rolls>ACref)) dmg+= int(1+6*random());
    }
    if(!hm){
      if(s3>0){
        hm=3;
        s3--;
        dmg += int(1+8*random(3))(sum);
        }
      else if(s2>0){
        hm=2;
        s2--;
        dmg += int(1+8*random(2))(sum);
      }
      else{
        rolls = int(1+20*random(2,2,2));
        if(hm) rolls=rolls(max,);
        else rolls = rolls(1,);
        dmg += sum(int(1+6*random(2)+6)*(rolls>ACref));
        dmg += sum(int(1+6*random(2))*(rolls==20));
        if(anyof(rolls>ACref)) dmg+= int(1+6*random());
      }
      
    }

    xhp(r+1) = hp;
    gdm(r+1) = dmg;
    plotl,,xhp(:r+1),color=["cyan","magenta","blue","black"](s2),width=s3*2+2;
    //plotl,,gdm(:r+1),color="red";
    if(dmg>100) return 1;
    if(hp<=0) return 0;
  }
  return 0;
}
      
      
      
  
