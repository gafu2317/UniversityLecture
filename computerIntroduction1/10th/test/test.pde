void setup(){
  size(500,500);
}

void draw(){
  player(250,250,150,150);
}

void player (float x, float y, float Pwidth, float Pheight) {
  stroke(0);
  strokeWeight(3);
  fill(#bf65e8);
  rectMode(CORNER);
  rect(x-Pwidth/2, y-Pheight/2, Pwidth, Pheight, Pwidth/10);//身体
  line(x-Pwidth/3, y-Pheight/4, x-Pwidth/4, y-Pheight/9*4);//耳
  line(x-Pwidth/4, y-Pheight/9*4, x-Pwidth/6, y-Pheight/4);
  line(x+Pwidth/3, y-Pheight/4, x+Pwidth/4, y-Pheight/9*4);
  line(x+Pwidth/4, y-Pheight/9*4, x+Pwidth/6, y-Pheight/4);
  fill(#ffff00);
  ellipse(x-Pwidth/4, y-Pheight/10, Pwidth/5, Pheight/5);//目
  ellipse(x+Pwidth/4, y-Pheight/10, Pwidth/5, Pheight/5);
  fill(#000000);
  ellipse(x-Pwidth/4, y-Pheight/10, Pwidth/12, Pheight/12);//瞳孔
  ellipse(x+Pwidth/4, y-Pheight/10, Pwidth/12, Pheight/12);
  fill(#ffffff);
  line(x-Pwidth/6, y+Pheight/20*3, x-Pwidth/9*4, y+Pheight/20*3-Pheight/20);//ひげ
  line(x-Pwidth/6, y+Pheight/20*4, x-Pwidth/9*4, y+Pheight/20*4);
  line(x-Pwidth/6, y+Pheight/20*5, x-Pwidth/9*4, y+Pheight/20*5+Pheight/20);
  line(x+Pwidth/6, y+Pheight/20*3, x+Pwidth/9*4, y+Pheight/20*3-Pheight/20);
  line(x+Pwidth/6, y+Pheight/20*4, x+Pwidth/9*4, y+Pheight/20*4);
  line(x+Pwidth/6, y+Pheight/20*5, x+Pwidth/9*4, y+Pheight/20*5+Pheight/20);
  fill(#696969);
  ellipse(x, y+Pheight/20*4, Pwidth/12, Pheight/12);//鼻
  fill(#000000);
  line(x, y+Pheight/20*4+Pheight/24, x, y+Pheight/20*4+Pheight/24+Pheight/10);//口
  noFill();
  bezier(x-Pwidth/4, y+Pheight/20*4+Pheight/24+Pheight/10, x-Pwidth/8, y+Pheight/20*4+Pheight/24+Pheight/10+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10);
  bezier(x+Pwidth/4, y+Pheight/20*4+Pheight/24+Pheight/10, x+Pwidth/8, y+Pheight/20*4+Pheight/24+Pheight/10+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10, x, y+Pheight/20*4+Pheight/24+Pheight/10);
}
