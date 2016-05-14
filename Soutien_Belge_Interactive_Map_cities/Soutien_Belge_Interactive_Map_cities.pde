/* @pjs preload="main-map.png"; */
/* @pjs preload="middleeast.png"; */
/* @pjs preload="belgium.png"; */
/* @pjs preload="sblogo-400.png"; */
/* @pjs preload="sblogo-inner.png"; */
/* @pjs preload="sblogo-blue.png"; */
/* @pjs preload="sblogo-green.png"; */
/* @pjs preload="sblogo-pink.png"; */
/* @pjs preload="sblogo-yellow.png"; */


color yel  = color(222, 194, 64);
color pin = color(195, 64, 145);
color blu = color(65, 109, 174);
color gre = color(158, 195, 77);
color cya = color(77, 181, 195);


PImage mainmap;
PImage logo;
PImage logoInner;

PFont backFont;
PFont cityFont;
PFont themeFont;
PFont titleFont;
PFont bodyFont;


boolean isMainScene = true;
boolean isMenuScene = false;
boolean back_mouseOver = false;
boolean prevPage_mouseOver = false;
boolean nextPage_mouseOver = false;


color buttonColor;

int d = 50;

int width = 1280;
int height = 800;
float xc = width/2;
float yc = height/2;
float themeX = 200;
float themeW = 200;
float themeH = 100;

int backW = 90;
int backH = 50;
int backM = 15;
int backX = backW/2 + backM;
int backY = height - backH/2 - backM;

float ppbX = xc*1.5 - 20;
float npbX = xc*1.5 + 20;
float cpbY = height - 20;
float cpbD = 25;
boolean isTextScene;
int currentPage = 1;
/*boolean isText1;
boolean isText2;
boolean isText3;
*/

Country bel;
Country lev;

City[] belCities = new City[1];
City[] levCities = new City[6];

Theme women;
Theme youth;
Theme child;
Theme aid;

Text weekend; //brussels
Text splp; //brussels
Text school;
Text womenCentre;
Text youthSchool;
Text psych;
Text bakery; //aleppo
Text closed; //kilis
Text future; //amman

Text collect; //brussels & syria

void setup() {
  size(1280, 800);
  //fullScreen();
  smooth(8);
  
  mainmap = loadImage("main-map.png");
  logo = loadImage("sblogo-400.png");
  logoInner = loadImage("sblogo-inner.png");

  backFont = createFont("Helvetica-Bold", 20);
  cityFont = createFont("Helvetica-Bold", 15);
  themeFont = createFont("Helvetica", 30);
  titleFont = createFont("Helvetica-Bold", 30);
  bodyFont = createFont("Helvetica", 20);
  
  
  bel = new Country(loadImage("belgium.png"), false, false, belCities, yel);
  lev = new Country(loadImage("middleeast.png"), false, false, levCities, gre, blu, pin, cya);
  
  belCities[0] = new City("Brussels", false, false, 610, 295, 2, "weekend", "splp", "null", "null");
  levCities[0] = new City("Beirut", false, false, 285, 453, 3, "school", "null", "psych", "women");
  levCities[1] = new City("Arsal, Bekaa Valley", false, false, 358, 424, 3, "school", "null", "psych", "women");
  levCities[2] = new City("Damascus", false, false, 343, 484, 4, "school", "null", "psych", "women");
  levCities[3] = new City("Aleppo", false, false, 407, 235, 4, "school", "bakery", "collect", "women");
  levCities[4] = new City("Kilis", false, false, 406, 190, 1, "closed", "null", "null", "null");
  levCities[5] = new City("Amman", false, false, 316, 625, 1, "future", "null", "null", "null");
  
  women = new Theme("Women", yc - 150, loadImage("sblogo-yellow.png"), false, false);
  youth = new Theme("Youth", yc - 50, loadImage("sblogo-green.png"), false, false);
  child = new Theme("Children", yc + 50, loadImage("sblogo-blue.png"), false, false);
  aid = new Theme("Aid", yc + 150, loadImage("sblogo-pink.png"), false, false);
  
  weekend = new Text("SB Weekend", false, "weekend1", "weekend2", "weekend3", "weekend4");
  splp = new Text("S'engager Pour La Paix", false, "splp1", "splp2", "splp3", "splp4");
  school = new Text("Schools", false, "For more than 5 years, a generation of Syrian schoolchildren has been denied access to education. The consequences of such a huge educational deficit are almost unthinkable. Not only is this a personal tragedy in the lives of thousands of young Syrians, but it is also a long-term threat to any vision of a fair, stable, and prosperous Syrian society.", "Since 2013, SB Overseas has addressed this educational deficit by setting up four new schools: in Beirut and Arsal in Lebanon, and in Damascus and Aleppo in Syria.", "Demand for education services is very high in these areas. In Lebanon, the government and aid agencies struggle to provide adequate services to the massive influx of refugees in the country. In Syria, many existing schools have been destroyed in since the beginning of the war – their students are forced to look elsewhere for an education.", "In Syria, around 250 students are enrolled at each school, where they are taught the Syrian curriculum. In Lebanon classes are provided to 150 children at each school. We still see many 8- to 9-year-olds join us who have never spent a day at school before.");
  womenCentre = new Text("Women's Centres", false, "General problems the war causes for women.", "What SB has done in 1 sentence, when, where.", "Extent of the problem – suggesting what needs we have addressed, and what more needs to be done.", "Details about our programmes.");
  youthSchool = new Text("Youth Education", false, "youthed1", "youthed2", "youthed3", "youthed4");
  psych = new Text("Psychological Support Centres", false, "psych1", "psych2", "psych3", "psych4");
  bakery = new Text("Bakery", false, "bakery1", "null", "null", "null");
  closed = new Text("Kilis - closed", false, "closed1", "null", "null", "null");
  future = new Text("Amman - TBD", false, "future1", "future2", "null", "null");
  collect = new Text("Collection Campaign", false, "collect1", "collect2", "collect3", "collect4");
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  background(mainmap);
};



void draw() {
  backButtonResponsive();
  backButtonColorResponsive();
  countriesResponsive();
  citiesResponsive();
  themeMenuResponsive();
  changePageResponsive();
  cursorImageResponsive();
}

void backButtonResponsive() {
  if ((!isMainScene) && (mouseX >= backM) && (mouseX <= backM + backW) &&  (mouseY >= height - backH - backM) && (mouseY <= height - backM)) {
      back_mouseOver = true;
  } else {
      back_mouseOver = false;
  }
}

void backButtonColorResponsive() {
  if (!isMainScene) {
    showBackButton();
  }
  
  if (back_mouseOver) {
    buttonColor = color(0, 0, 50);
  } else {
    buttonColor = color(200, 0, 50);
  }
}

void countriesResponsive() {
  if (lev.responsive()) {
      lev.mouseOver = true;
  } else {
      lev.mouseOver = false;
  }
  
  if (bel.responsive()) {
      bel.mouseOver = true;
  } else {
      bel.mouseOver = false;
  }
}

void citiesResponsive() {
  if ((bel.isScene) && ((mouseX-belCities[0].x)*(mouseX-belCities[0].x) + (mouseY-belCities[0].y)*(mouseY-belCities[0].y) < d*d/4)) {
      belCities[0].mouseOver = true;
  } else {
      belCities[0].mouseOver = false;
  }
  
  if ((lev.isScene) && ((mouseX-levCities[0].x)*(mouseX-levCities[0].x) + (mouseY-levCities[0].y)*(mouseY-levCities[0].y) < d*d/4)) {
      levCities[0].mouseOver = true;
  } else {
      levCities[0].mouseOver = false;
  } 
  
  if ((lev.isScene) && ((mouseX-levCities[1].x)*(mouseX-levCities[1].x) + (mouseY-levCities[1].y)*(mouseY-levCities[1].y) < d*d/4)) {
      levCities[1].mouseOver = true;
  } else {
      levCities[1].mouseOver = false;
  }
  
  if ((lev.isScene) && ((mouseX-levCities[2].x)*(mouseX-levCities[2].x) + (mouseY-levCities[2].y)*(mouseY-levCities[2].y) < d*d/4)) {
      levCities[2].mouseOver = true;
  } else {
      levCities[2].mouseOver = false;
  }
  
  if ((lev.isScene) && ((mouseX-levCities[3].x)*(mouseX-levCities[3].x) + (mouseY-levCities[3].y)*(mouseY-levCities[3].y) < d*d/4)) {
      levCities[3].mouseOver = true;
  } else {
      levCities[3].mouseOver = false;
  }
  
  if ((lev.isScene) && ((mouseX-levCities[4].x)*(mouseX-levCities[4].x) + (mouseY-levCities[4].y)*(mouseY-levCities[4].y) < d*d/4)) {
      levCities[4].mouseOver = true;
  } else {
      levCities[4].mouseOver = false;
  }
  
  if ((lev.isScene) && ((mouseX-levCities[5].x)*(mouseX-levCities[5].x) + (mouseY-levCities[5].y)*(mouseY-levCities[5].y) < d*d/4)) {
      levCities[5].mouseOver = true;
  } else {
      levCities[5].mouseOver = false;
  }
}

void themeMenuResponsive() {
  if ((isMenuScene) && (women.exist) && ((mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > women.y - themeH/2) && (mouseY < women.y + themeH/2))) {
      women.mouseOver = true;
      women.logo();
      cursor(HAND);
  } else {
      women.mouseOver = false;
  }
  
  if ((isMenuScene) && (youth.exist) && ((mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > youth.y - themeH/2) && (mouseY < youth.y + themeH/2))) {
      youth.mouseOver = true;
      youth.logo();
  } else {
      youth.mouseOver = false;
  }
  
  if ((isMenuScene) && (child.exist) && ((mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > child.y - themeH/2) && (mouseY < child.y + themeH/2))) {
      child.mouseOver = true;
      child.logo();
  } else {
      child.mouseOver = false;
  }
  
  if ((isMenuScene) && (aid.exist) && ((mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > aid.y - themeH/2) && (mouseY < aid.y + themeH/2))) {
      aid.mouseOver = true;
      aid.logo();
  } else {
      aid.mouseOver = false;
  }
  
  if ((isMenuScene) && (!women.mouseOver) && (!youth.mouseOver) && (!child.mouseOver) && (!aid.mouseOver)) {
      image(logo, 900, yc, 400, 400);
  }
}

void changePageResponsive() {
  if ((isTextScene) && (currentPage > 1) && ((mouseX - ppbX)*(mouseX - ppbX) + (mouseY - cpbY)*(mouseY - cpbY) < cpbD*cpbD/4)) {
    prevPage_mouseOver = true;
  } else {
    prevPage_mouseOver = false;
  }

  if ((isTextScene) && (currentPage < 4) && ((mouseX - npbX)*(mouseX - npbX) + (mouseY - cpbY)*(mouseY - cpbY) < cpbD*cpbD/4)) {
    nextPage_mouseOver = true;
  } else {
    nextPage_mouseOver = false;
  }
}

void cursorImageResponsive() {
  if (
    (lev.mouseOver())
    || (bel.mouseOver())
    || (belCities[0].mouseOver)    
    || (levCities[0].mouseOver)    
    || (levCities[1].mouseOver)    
    || (levCities[2].mouseOver)    
    || (levCities[3].mouseOver)    
    || (levCities[4].mouseOver)    
    || (levCities[5].mouseOver)    
    || (back_mouseOver)
    || (women.mouseOver)
    || (youth.mouseOver)
    || (child.mouseOver)
    || (aid.mouseOver) 
    || (prevPage_mouseOver) 
    || (nextPage_mouseOver)) 
        
      {cursor(HAND);}
  
  else  {cursor(ARROW);}

}

///////////////////////////////
//////// INTERACTIVITY ////////
///////////////////////////////

void mouseReleased() {
  if (back_mouseOver) {
    showMainScene();
  } else if (lev.mouseOver()) {
    lev.displayScene();
  } else if (bel.mouseOver()) {
    bel.displayScene();
  } else if (belCities[0].mouseOver) {
    belCities[0].menuScene();
  } else if (levCities[0].mouseOver) {
    levCities[0].menuScene();
  } else if (levCities[1].mouseOver) {
    levCities[1].menuScene();
  } else if (levCities[2].mouseOver) {
    levCities[2].menuScene();
  } else if (levCities[3].mouseOver) {
    levCities[3].menuScene();
  } else if (levCities[4].mouseOver) {
    levCities[4].menuScene();
  } else if (levCities[5].mouseOver) {
    levCities[5].menuScene();
  } 
  
  else if ((bel.isScene) && (youth.mouseOver)) {
    splp.display();
  } else if ((bel.isScene) && (child.mouseOver)) {
    weekend.display();
  } else if ((levCities[3].isMenu) && (youth.mouseOver)) {
    bakery.display();
  } else if ((levCities[4].isMenu) && ((women.mouseOver) || (youth.mouseOver) || (child.mouseOver) || (aid.mouseOver))) {
    closed.display();
  } else if ((levCities[5].isMenu) && ((women.mouseOver) || (youth.mouseOver) || (child.mouseOver) || (aid.mouseOver))) {
    future.display();
  } else if ((lev.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (women.mouseOver)) {
    //women.scene();
    womenCentre.display();
  } else if ((lev.isScene) && (!levCities[3].isMenu) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (youth.mouseOver)) {
    //women.scene();
    youthSchool.display();
  } else if ((lev.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (child.mouseOver)) {
    //women.scene();
    school.display();
  } else if ((lev.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (aid.mouseOver)) {
    //women.scene();
    psych.display();
  }     
  
  if (isTextScene) {
    if ((splp.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      splp.display();
    } else if ((splp.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      splp.display();
    } else if ((weekend.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      weekend.display();
    } else if ((weekend.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      weekend.display();
    } else if ((bakery.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      bakery.display();
    } else if ((bakery.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      bakery.display();
    } else if ((closed.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      closed.display();
    } else if ((closed.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      closed.display();
    } else if ((future.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      future.display();
    } else if ((future.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      future.display();
    } else if ((womenCentre.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      womenCentre.display();
    } else if ((womenCentre.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      womenCentre.display();
    } else if ((youthSchool.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      youthSchool.display();
    } else if ((youthSchool.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      youthSchool.display();
    } else if ((school.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      school.display();
    } else if ((school.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      school.display();
    } else if ((psych.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      psych.display();
    } else if ((psych.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      psych.display();
    } else if ((collect.isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      collect.display();
    } else if ((collect.isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      collect.display();
    } 
  }
}

/////////////////////////////////
//////////// CLASSES ////////////
/////////////////////////////////

public interface Clickable {
  public boolean mouseOver();
}

public class Country implements Clickable {
  public PImage pic;
  public boolean mouseOver;
  public boolean isScene;
  public City[] cities;
  private color[] colors;
   
  public Country(PImage tempPic, boolean tempmouseOver, boolean tempIsScene, City[] tempCities, color...colors) {
    pic = tempPic;
    mouseOver = tempmouseOver;
    isScene = tempIsScene;
    cities = tempCities;
    this.colors = colors;
  }
 
  public Country(PImage tempPic, boolean tempmouseOver, boolean tempIsScene, City[] tempCities) {
    pic = tempPic;
    mouseOver = tempmouseOver;
    isScene = tempIsScene;
    cities = tempCities;
  }
 
  public boolean responsive() {
    if (! isMainScene) return false;
    for (color col : colors) {
      if (get(mouseX,mouseY) == col) return true;
    }
    return false;
  }
 
  public boolean mouseOver() {
    return mouseOver;
  }
   
  public void displayScene() {
    image(pic, xc, yc);
    for (int i = 0; i < cities.length; i++) {
      cities[i].display();
    }
    isMainScene = false;
    isScene = true;
  }
}

public class City {
  String name;
  boolean mouseOver, isMenu;
  int x, y;
  int numberColors;
  String blue, green, pink, yellow;
  
  City(String tempName, boolean tempMouseOver, boolean tempIsMenu, int tempX, int tempY, int tempNumberColors, String tempBlue, String tempGreen, String tempPink, String tempYellow) {
    name = tempName;
    mouseOver = tempMouseOver;
    isMenu = tempIsMenu;
    x = tempX;
    y = tempY;
    numberColors = tempNumberColors;
    blue = tempBlue;
    green = tempGreen;
    pink = tempPink;
    yellow = tempYellow;    
  }
  
  void display() {
    image(logoInner, x, y, d, d);
    fill(0,0,0);
    textFont(cityFont);
    textAlign(LEFT, CENTER);
    text(name, x + 3*d/4, y);
  }
  
  void menuScene() {
    isMenuScene = true;
    isMenu = true;
    tintScene();
    image(logo, 900, yc, 400, 400);
    chooseDrawMenuButtons();
    
    isMainScene = false;
  }
  
  void chooseDrawMenuButtons() {
    if (yellow == "null") {
      fill(180);
      women.button();
      women.exist = false;
    } else {
      fill(255);
      women.button();
      women.exist = true;
    } 

    if (green == "null") {
      fill(180);
      youth.button();
      youth.exist = false;
    } else {
      fill(255);
      youth.button();
      youth.exist = true;
    } 
    
    if (blue == "null") {
      fill(180);
      child.button();
      child.exist = false;
    } else {
      fill(255); 
      child.button();
      child.exist = true;
    }
    
    if (pink == "null") {
      fill(180);
      aid.button();
      aid.exist = false;
    } else {
      fill(255);
      aid.button();
      aid.exist = true;
    }
  }
  
  
}

public class Theme {
  String name;
  boolean mouseOver, exist;
  float y;
  PImage themeLogo;
  
  Theme(String tempName, float tempY, PImage tempThemeLogo, boolean tempMouseOver, boolean tempExist) {
    name = tempName;
    y = tempY;
    themeLogo = tempThemeLogo;
    mouseOver = tempMouseOver;
    exist = tempExist;
  }
  
  void button() {
    //fill(255, 255, 255);
    rect(themeX, y, themeW, themeH);
    fill(0, 0, 0);
    textFont(themeFont);
    textAlign(CENTER, CENTER);
    text(name, themeX, y, themeW, themeH);
  }

  void logo() {
    image(themeLogo, 900, yc, 400, 400);
  }
}

public class Text {
  boolean isText;
  String title, text, text1, text2, text3, text4;
  PImage image1, image2, image3, image4;
  
  Text(String tempTitle, boolean tempIsText, String tempText1, String tempText2, String tempText3, String tempText4/*, PImage tempImage1, PImage tempImage2, PImage tempImage3, PImage tempImage3*/) {
    isText = tempIsText;
    title = tempTitle;
    text1 = tempText1;
    text2 = tempText2;
    text3 = tempText3;
    text4 = tempText4;
  }
  
  void display() {
    isTextScene = true;
    isText = true;
    
    pageChanger();
    
    //textbox
    fill(255,255,255);
    rect(xc*1.5, yc*1.5, xc, yc);    
    
    //title
    fill(0, 0, 0);
    textAlign(CENTER, CENTER);
    textFont(titleFont);
    text(title, xc*1.5, yc + 50, xc, 100);
    
    //body text
    textFont(bodyFont);
    if (currentPage == 1) {
      text(text1, xc*1.5, yc*1.5 + 5, xc, yc - 20);
      nextPageButton();
      //image(image1, xc/2, yc/2, xc, yc);
    } else if (currentPage == 2) {
      text(text2, xc*1.5, yc*1.5 + 5, xc, yc - 20);
      nextPageButton();
      prevPageButton();
      //image(image2, xc/2, yc/2, xc, yc);
    } else if (currentPage == 3) {
      text(text3, xc*1.5, yc*1.5 + 5, xc, yc - 20);
      nextPageButton();
      prevPageButton();
      //image(image3, xc/2, yc/2, xc, yc);
    } else if (currentPage == 4) {
      text(text4, xc*1.5, yc*1.5 + 5, xc, yc - 20);
      prevPageButton();
      //image(image4, xc/2, yc/2, xc, yc);
    }
  }
  
  void pageChanger() {
    if ((isText) && (nextPage_mouseOver)) {
      currentPage += 1;
      display();
    } else if ((isText) && (prevPage_mouseOver)) {
      currentPage -= 1;
      display();
    }
  }
}



////////////////////////////////
//////// TEXT BOX STUFF ////////
////////////////////////////////

void text_box() {
  fill(255,255,255);
  rect(xc*1.5, yc*1.5, xc, yc);
}


void showMainScene() {
  background(mainmap);
  isMainScene = true;
  bel.isScene = false;
  lev.isScene = false;
  isMenuScene = false;
  for (int i = 0; i < levCities.length; i++) {
    levCities[i].isMenu = false;
  }
  belCities[0].isMenu = false;
  isTextScene = false;
  
}

void tintScene() {
  tint(155);
  if (bel.isScene) {
    bel.displayScene();
  } else if (lev.isScene) {
    lev.displayScene();
  }    
  noTint();
}


void showBackButton() {
  stroke(255);
  fill(buttonColor);
  rect(backX, backY, backW, backH, 7);
  fill(255, 255, 255);
  textFont(backFont);
  textAlign(CENTER, CENTER);
  text("Back", backX, backY, backW, backH);
}

void prevPageButton() {
  fill(255,0,0);
  ellipse(ppbX, cpbY, cpbD, cpbD);
}

void nextPageButton() {
  fill(255,0,0);
  ellipse(npbX, cpbY, cpbD, cpbD);
}

//////////////////////////////
//////// TEST CIRCLES ////////
//////////////////////////////

void test_circle() {
  fill(255, 0, 0);
  ellipse(25, 25, 50, 50);
}

void test_circle1() {
  fill(255, 0, 0);
  ellipse(width - 25, 25, 50, 50);
}

void test_circle2() {
  fill(255, 0, 0);
  ellipse(width - 25, height - 25, 50, 50);
}

void test_circle3() {
  fill(255, 0, 0);
  ellipse(25, height - 25, 50, 50);
}