/**
Ce programme permet de simuler le jeu de la vie. Il est possible de poser ou de supprimer des cellules avec le clic gauche et de mettre en pause/marche avec le clic droit.
Il est aussi possible de changer la vitesse d'exécution du programme avec les fleches haut et bas. En appuyant sur la touche 'e' l'ensemble des cellules sont effacés et
en appuyant sur la touche 'a' une immense croix appparait au centre de la simulation. 
*/

//programme
boolean[][] tableau;
boolean[][] tableau_;
int vitesse=120;
boolean pause=false;
boolean place_en_pause=true;
int pos[];
char memoire;
boolean value(int x, int y) {
  int nb=0;
  for (int i=x>0?-1:0; i<(x<79?2:1); i++) {
    for (int i_=y>0?-1:0; i_<(y<79?2:1); i_++) {
      if (!(i==0 & i_==0) & tableau_[x+i][y+i_]) {
        nb++;
      }
    }
  }
  return tableau_[x][y]?nb==2 |nb==3:nb==3;
}
void application(int x, int y, boolean valeur) {
  tableau[x+5][y+5]=valeur;
  tableau_[x+5][y+5]=valeur;
  dessine(x, y);
}
void planeur(int x, int y) {
  application(x, y, false);
  application(x, y+1, true);
  application(x, y+2, false);
  application(x+1, y, false);
  application(x+1, y+1, false);
  application(x+1, y+2, true);
  application(x+2, y, true);
  application(x+2, y+1, true);
  application(x+2, y+2, true);
}
void croix(int x, int y) {
  for (int i=0; i<70; i++) {
    application(x, i, true);
  }
  for (int i=0; i<70; i++) {
    application(i, y, true);
  }
}
void effacer() {
  for (int i=0; i<80; i++) {
    for (int i_=0; i_<80; i_++) {
      tableau[i][i_]=false;
    }
  }
  for (int i=0; i<70; i++) {
    for (int i_=0; i_<70; i_++) {
      dessine(i, i_);
    }
  }
}
void grille() {
  background(240);
  stroke(0);
  for (int i=0; i<70; i++) {
    line(0, i*10, 700, i*10);
  }
  for (int i=0; i<70; i++) {
    line(i*10, 0, i*10, 700);
  }
}
void dessine(int x, int y) {
  if (tableau[x+5][y+5]) {
    stroke(0);
  } else {
    stroke(240);
  }
  rect(x*10+1, y*10+1, 9, 9);
}
void setup() {
  noSmooth();
  memoire =' ';
  size(700, 700);
  surface.setLocation(600, 0);
  pos= new int[2];
  pos[0]=-1;
  pos[1]=0;
  tableau=new boolean[80][80];
  tableau_=new boolean[80][80];
  frameRate(120);
  grille();
}
void draw() {
  if (pause) {
    for (int i=0; i<80; i++) {
      for (int i_=0; i_<80; i_++) {
        tableau_[i][i_]=tableau[i][i_];
      }
    }
    for (int i=0; i<80; i++) {
      for (int i_=0; i_<80; i_++) {
        tableau[i][i_]=value(i, i_);
      }
    }
    for (int i=0; i<70; i++) {
      for (int i_=0; i_<70; i_++) {
        dessine(i, i_);
      }
    }
  }
}
void souris() {
  if (mouseButton==LEFT ) {
    if (!pause & memoire!=' ') {
      if (memoire=='p') {
        planeur(mouseX/10, mouseY/10);
      } else if (memoire=='c') {
        croix(mouseX/10, mouseY/10);
      } else {
        memoire=' ';
      }
    } else if ((mouseX/10!=pos[0] | mouseY/10!=pos[1]) & (!pause | place_en_pause)) {
      pos[0]=mouseX/10;
      pos[1]=mouseY/10;
      tableau[pos[0]+5][pos[1]+5]=!tableau[pos[0]+5][pos[1]+5];
      tableau_[pos[0]+5][pos[1]+5]=tableau[pos[0]+5][pos[1]+5];
      dessine(pos[0], pos[1]);
    }
  } else {
    pause=!pause;
    if (pause) {
      frameRate(vitesse);
    } else {
      frameRate(60);
    }
  }
}
void mouseDragged() {
  souris();
}
void mousePressed() {
  pos[0]=-1;
  pos[1]=0;
  souris();
}
void keyPressed() {
  memoire =key;
  if (key==CODED) {
    if (keyCode==UP) {
      vitesse=vitesse>120?120:vitesse+1;
    } else if (keyCode==DOWN) {
      vitesse=vitesse<1?1:vitesse-1;
    }
    frameRate(vitesse+1);
    memoire=' ';
  }
  if (memoire=='e') {
    effacer();
    memoire=' ';
  } else if (memoire=='a') {
    croix(34, 34);
    croix(35, 35);
    memoire=' ';
  }
}
