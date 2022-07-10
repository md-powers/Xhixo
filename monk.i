#include "/ycode/lab.i"

func abl_bon(score){
  return int((score-10)/2);
}

write,format="Character: %s the %s %s\n","Tos","Kensei Monk","Kobold";

extern NAME; NAME = "Tos";

extern PBO; PBO=04;
extern LVL; LVL=10;

extern STR; STR= 8;
extern DEX; DEX=18;
extern CON; CON=14;
extern INT; INT=10;
extern WIS; WIS=16;
extern CHR; CHR= 8;

//mobile doesn't trigger opp attacks after targeting someone
extern SPEED; SPEED=30+20+10; //kobold + monk speed + mobile
extern HP; extern maxHP; extern tempHP;
maxHP = int(10*(5+abl_bon(CON))+3); tempHP=int(0);
HP = is_void(HP)?maxHP:HP;
extern NHITDI;
NHITDI = 10;

extern meAC;
meAC = 10 + abl_bon(WIS) + abl_bon(DEX);

extern meDC;
meDC = 8 + PBO + abl_bon(WIS);

extern meAT;
meAT = PBO + abl_bon(DEX);

extern KI; extern KImax;
KImax = 10;
KI = is_void(KI)?KImax:KI;

extern COND; extern SPEC_COND;
COND = "Healthy"; SPEC_COND="";

func sitrep(void){
  write,format=" HP: %2d / %2d  |",HP+tempHP,maxHP;
  update_cond;
  write,format=" %s",COND;
  if(KI){
    write,format="\n KI: %s",array("[*]",KI)(sum);
    if(KI<KImax){
      write,format="%s",array("[]",KI-KImax)(sum);
    }
    write,"";
  }
  write,format=" STR: %2d (%+2d) |",STR,abl_bon(STR);
  write,format=" INT: %2d (%+2d)\n",INT,abl_bon(INT);
  write,format=" DEX: %2d (%+2d) |",DEX,abl_bon(DEX);
  write,format=" WIS: %2d (%+2d)\n",WIS,abl_bon(WIS);
  write,format=" CON: %2d (%+2d) |",CON,abl_bon(CON);
  write,format=" CHR: %2d (%+2d)\n",CHR,abl_bon(CHR);

  list_gear;
  
}

/**************************************************************
 *
 *
 *            Monk H U D mode
 *
 *
 ***************************************************************/

func enter_HUD(void){
  winkill,0;
  window,0,style="dnd.gs",height=320,width=660;
  limits,-120,120,-60,60;
  gridxy,1;
  plotl,[-120,120,120,-120],[-60,-60,60,60];
  palette,"heat.gp";

  HUD_grid;
  update_vis;
  update_pos;

  
  gridxy,1;

  plotlc,0,0,sqrt(5.*5./pi),color="red",width=4;

  sitrep;  
}

func HUD_grid(void){
  extern hudx; extern hudy;
  hudx = span(-125,120,50)(-:1:50,)(zcen,zcen);
  hudy = span(-125,120,50)(,-:1:50)(zcen,zcen);
}

func update_vis(void,darkQ=){
  vis = (abs(hudx)+abs(hudy)<=SPEED);
  vis+= (abs(hudx)+abs(hudy)<=2*SPEED);
  
  darkQ = is_void(darkQ)?"n":darkQ;
  if(darkQ=="y"){
    vis+=(hudx^2+hudy^2<=60.^2);
  }
  plf,vis,hudy+2.5,hudx+2.5;
}
func update_pos(void){
  NME_POS -= ME_POS;
  chart_boom;
  chart_nme;
}
func update_cond(void){
  COND = "Healthy";
  if(HP<=maxHP/2) COND="LOW HP";
  if(HP<=15) COND="CRITICAL";
  if(HP<=0) COND="DIEING";
  COND = COND +" and "+ SPEC_COND;
}

func list_gear(void){
  //Whip
  name = "Kensei Whip";
  attk = PBO+abl_bon(DEX);
  dmgd = "1d6+"+totxt(abl_bon(DEX));
  write,format="  %s: %+2d to hit (%s)\n",name,attk,dmgd;
  name = "BareKnuckle";
  attk = PBO+abl_bon(DEX);
  dmgd = "1d6+"+totxt(abl_bon(DEX));
  write,format="  %s: %+2d to hit (%s)\n",name,attk,dmgd;

  boot_status;
}

extern BOOT_FLAG; BOOT_FLAG = 0;
extern BOOT_TIME; BOOT_TIME = 100;
func toggle_boots(void){
  if(BOOT_FLAG) SPEED/=2;
  else SPEED*=2;
  BOOT_FLAG = !BOOT_FLAG;
  return BOOT_FLAG;
}
func boot_status(void){
  write,format="  Boots of Speed are %s (%3d)\n",["on","off"](BOOT_FLAG),BOOT_TIME;
}
  
func short_rest(void,di=){
  KI = maxKI;
  if(!is_void(di)){
    rec = 0;
    read,prompt=" Recover how much HP? ",format="%d",rec;
    HP = min(maxHP,HP+rec);
  }
}

extern NME_WHO; NME_WHO=array("",10);
extern NME_POS; NME_POS=array(0.,[2,2,10]);
extern NME_SPD; NME_SPD=array(30,10);
extern NME_RNG; NME_RNG=array(5.,10);
extern NME_HIT; NME_HIT=array(0,10);
extern NME_CON; NME_CON=array(10,10);
extern NME_DEX; NME_DEX=array(10,10);
extern NME_AC; NME_AC=array(15,10);

extern ME_POS; ME_POS=[0.,0.];
extern ME_SPD; ME_SPD=SPEED;
extern ME_RNG; ME_RNG=10;

extern BOOM_POS; BOOM_POS=[-5.,0.];


func add_nme(name,pos,speed=,range=,con=,dex=,ac=){
  wnme = where( NME_WHO!="" );
  nnme = numberof(wnme)?numberof(wnme):0;

  NME_WHO(nnme+1) = name;
  NME_POS(,nnme+1) = pos;
  NME_SPD(nnme+1) = is_void(speed)?30:speed;
  NME_RNG(nnme+1) = is_void(range)?5:range;
  NME_HIT(nnme+1) = 0;
  NME_CON(nnme+1) = is_void(con)?10:con;
  NME_DEX(nnme+1) = is_void(dex)?10:dex;
  NME_AC(nnme+1) = is_void(ac)?15:ac;
}

func chart_nme(void){
  ME_SPD=SPEED;

  wnme = where( NME_WHO!="" );
  nnme = is_void(wnme)?0:numberof(wnme);
  for(n=1; n<=nnme; n++){
    plotlc,NME_POS(1,n),NME_POS(2,n),sqrt(5*5/pi),color="black",width=4;
    plotlc,NME_POS(1,n),NME_POS(2,n),ME_RNG,color="red";
    //plotlc,NME_POS(1,n),NME_POS(2,n),NME_SPD,color="red",width=2;
    //plotlc,NME_POS(1,n),NME_POS(2,n),NME_SPD+NME_RNG,color="red";
    write,format="   %2d| %3d ft away | %2g%% to hit | %2g%% to stun\n",n,int(abs(NME_POS(,n)-ME_POS)(sum))*5,100*phit(nme=n),100*pstun(nme=n);
  }
  if(nnme>0){
    while(!toggle_boots()){};
    nme_pos = NME_POS;
    hnme = min(3+(KI>=1),4);
    apx = sqrt(2*pi*nnme)*(nnme/exp(1))^nnme;
    route = indgen(nnme);
    COORDS = array(0.,[2,2,hnme+1]);
    COORDS(,1) = ME_POS;
    COORDS(,2:) = NME_POS(,:hnme);
    lens = norm(COORDS(,dif));
    hits = where(lens(cum)<SPEED-((NME_SPD+NME_RNG)(hnme)))(0) - 1;
    dist = lens(:hits)(sum);
    apx = min(1000,apx);
    for(t=1; t<=apx; t++){
      swapz = int(random(2)*nnme)+1;
      troute = route;
      troute(swapz(1)) = route(swapz(2));
      troute(swapz(2)) = route(swapz(1));
      if(random()>.8) troute = sort(random(nnme));
      COORDS(,2:) = NME_POS(,troute(:hnme));
      tlens = norm(COORDS(,dif));
      thits = where(tlens(cum)<SPEED-(NME_SPD+NME_RNG)(troute(hnme)))(0)-1;
      tdist = tlens(:thits)(sum);
      if( (thits>hits)+(thits==hits)*(tdist<dist)){
        hits = thits;
        dist = tdist;
        route = troute;
      }
    }
    write,format="Target nme %d (%s) : Pstun = %g\n",route(:hnme),NME_WHO(route(:hnme)),pstun(nme=route(:hnme));
    COORDS(,2:) = NME_POS(,:nnme)(,route(:hnme));
    safe = find_safety(stunlist=route(:hnme));
    dcx = (COORDS(1,0)-hudx)^2;
    dcy = (COORDS(2,0)-hudy)^2;
    drn = sqrt(dcx+dcy);

    dbb = sqrt( (BOOM_POS(1)-hudx)^2 + (BOOM_POS(2)-hudy)^2);
    flee = (drn<=SPEED-dist)*safe;
    if(anyof(flee)){
      flee2 = where(flee)(sort((dbb+drn)(where(flee))))(1);
      coord = [hudx(flee2),hudy(flee2)];
    }
    //plf,flee,hudy+2.5,hudx+2.5;
  
    plotl,COORDS(1,),COORDS(2,),color=greenish(),width=4;
    plotl,[COORDS(1,0),coord(1)],[COORDS(2,0),coord(2)],color="green",width=4;
    plotlc,coord(1),coord(2),sqrt(5*5/pi),color="grayc";
  }
    
      
    

  plotlc,ME_POS(1),ME_POS(2),ME_SPD,color="black",width=4;
  plotlc,ME_POS(1),ME_POS(2),ME_SPD,color="blue",width=2;
  plotlc,ME_POS(1),ME_POS(2),ME_RNG,color="red";
  plotlc,ME_POS(1),ME_POS(2),ME_SPD+ME_RNG,color="red";
  
}

func chart_boom(void){
  boom_og = BOOM_POS;
  ME_POS -= BOOM_POS;
  NME_POS-= BOOM_POS;
  BOOM_POS-=BOOM_POS;
  th = atan(ME_POS(2),ME_POS(1));
  rotm = [[cos(th),sin(th)],[-sin(th),cos(th)]];
  ME_POS = rotm(+,)*ME_POS(+) + BOOM_POS;
  NME_POS= rotm(+,)*NME_POS(+,)+BOOM_POS;
  BOOM_POS=rotm(+,)*BOOM_POS(+)-ME_POS;
  NME_POS-= ME_POS;
  ME_POS -= ME_POS;

  for(i=1; i<=2; i++) plotle,BOOM_POS(1),BOOM_POS(2),5,5,res=i*3,width=2*i,color="blue";
  plotl,[BOOM_POS(1),ME_POS(1)],[BOOM_POS(2),ME_POS(2)],color="blue";
  write,format=" Boom Boom is %d ft away\n",int(norm(BOOM_POS-ME_POS)(1));
}
  
  

func phit(void,nme=){
  wnme = where( NME_WHO!="" );
  nnme = is_void(wnme)?0:numberof(wnme);
  prob = ((indgen(20)+meAT)(,-:1:nnme) > NME_AC(-:1:20,:nnme))(avg,);
  if(is_void(nme)) return prob;
  return prob(nme);
}
func pstun(void,nme=){
  wnme = where( NME_WHO!="" );
  nnme = is_void(wnme)?0:numberof(wnme);
  prob = ( (indgen(20)(,-:1:nnme) + abl_bon(NME_CON)(-:1:20,:nnme)) < meDC)(avg,);
  if(is_void(nme)) return prob;
  return prob(nme);
}

func find_safety(void,stunlist=){
  if(is_void(hudy)) hud_grid;
  if(is_void(stunlist)) stunlist=0;
  safeQ = hudy*0;
  nnme = numberof(where(NME_WHO!=""));
  for(n=1; n<=nnme; n++){
    if(anyof(stunlist==n)) continue;
    dyn = hudy-NME_POS(2,n);
    dxn = hudx-NME_POS(1,n);
    drn = sqrt(dyn^2+dxn^2);
    safeQ+=(drn>NME_SPD(n)+NME_RNG(n));
  }
  //plf,safeQ,hudy+2.5,hudx+2.5;
  return safeQ;
}




func rnd_nmes(num){
  for(n=1; n<=num; n++){
    add_nme,"NPC",int((random(2)-.5)*100),con=9+int(random()*10),dex=9+int(random()*10),ac=10+int(random()*10);
    //func add_nme(name,pos,speed=,range=,con=,dex=,ac=){

  }
}
rnd_nmes,5;
