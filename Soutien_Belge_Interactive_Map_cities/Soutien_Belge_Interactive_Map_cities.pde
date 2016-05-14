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
boolean prevPage_mouseOver = false;
boolean nextPage_mouseOver = false;

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

BackButton backButton = new BackButton();

Country belgium;
Country levant;

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
  
  
  belgium = new Country(loadImage("belgium.png"), false, false, belCities, yel);
  levant = new Country(loadImage("middleeast.png"), false, false, levCities, gre, blu, pin, cya);
  
  belCities[0] = new City("Brussels", belgium, false, false, 610, 295, "weekend", "splp", "null", "null");
  levCities[0] = new City("Beirut", levant, false, false, 285, 453, "school", "null", "psych", "women");
  levCities[1] = new City("Arsal, Bekaa Valley", levant, false, false, 358, 424, "school", "null", "psych", "women");
  levCities[2] = new City("Damascus", levant, false, false, 343, 484, "school", "null", "psych", "women");
  levCities[3] = new City("Aleppo", levant, false, false, 407, 235, "school", "bakery", "collect", "women");
  levCities[4] = new City("Kilis", levant, false, false, 406, 190, "closed", "null", "null", "null");
  levCities[5] = new City("Amman", levant, false, false, 316, 625, "future", "null", "null", "null");
  
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
  countriesResponsive();
  citiesResponsive();
  themeMenuResponsive();
  changePageResponsive();
  cursorImageResponsive();
}

void backButtonResponsive() {
  backButton.responsive();
}

void countriesResponsive() {
  levant.responsive();
  belgium.responsive();
}

void citiesResponsive() {
  belCities[0].responsive();
  for (City city : levCities) {
    city.responsive();
  }
}

void themeMenuResponsive() {
  women.responsive();
  youth.responsive();
  child.responsive();
  aid.responsive();
  
  if ((isMenuScene) && (!women.mouseOver()) && (!youth.mouseOver()) && (!child.mouseOver()) && (!aid.mouseOver())) {
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
    (levant.mouseOver())
    || (belgium.mouseOver())
    || (belCities[0].mouseOver())    
    || (levCities[0].mouseOver())    
    || (levCities[1].mouseOver())    
    || (levCities[2].mouseOver())    
    || (levCities[3].mouseOver())    
    || (levCities[4].mouseOver())    
    || (levCities[5].mouseOver())    
    || (backButton.mouseOver())
    || (women.mouseOver())
    || (youth.mouseOver())
    || (child.mouseOver())
    || (aid.mouseOver()) 
    || (prevPage_mouseOver) 
    || (nextPage_mouseOver)) 
        
      {cursor(HAND);}
  
  else  {cursor(ARROW);}

}

///////////////////////////////
//////// INTERACTIVITY ////////
///////////////////////////////

void mouseReleased() {
  if (backButton.mouseOver()) {
    showMainScene();
  } else if (levant.mouseOver()) {
    levant.displayScene();
  } else if (belgium.mouseOver()) {
    belgium.displayScene();
  } else if (belCities[0].mouseOver()) {
    belCities[0].menuScene();
  } else if (levCities[0].mouseOver()) {
    levCities[0].menuScene();
  } else if (levCities[1].mouseOver()) {
    levCities[1].menuScene();
  } else if (levCities[2].mouseOver()) {
    levCities[2].menuScene();
  } else if (levCities[3].mouseOver()) {
    levCities[3].menuScene();
  } else if (levCities[4].mouseOver()) {
    levCities[4].menuScene();
  } else if (levCities[5].mouseOver()) {
    levCities[5].menuScene();
  } 
  
  else if ((belgium.isScene) && (youth.mouseOver())) {
    splp.display();
  } else if ((belgium.isScene) && (child.mouseOver())) {
    weekend.display();
  } else if ((levCities[3].isMenu) && (youth.mouseOver())) {
    bakery.display();
  } else if ((levCities[4].isMenu) && ((women.mouseOver()) || (youth.mouseOver()) || (child.mouseOver()) || (aid.mouseOver()))) {
    closed.display();
  } else if ((levCities[5].isMenu) && ((women.mouseOver()) || (youth.mouseOver()) || (child.mouseOver()) || (aid.mouseOver()))) {
    future.display();
  } else if ((levant.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (women.mouseOver())) {
    //women.scene();
    womenCentre.display();
  } else if ((levant.isScene) && (!levCities[3].isMenu) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (youth.mouseOver())) {
    //women.scene();
    youthSchool.display();
  } else if ((levant.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (child.mouseOver())) {
    //women.scene();
    school.display();
  } else if ((levant.isScene) && (!levCities[4].isMenu) && (!levCities[5].isMenu) && (aid.mouseOver())) {
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
  public void responsive();
}

public class BackButton implements Clickable {
  private boolean mouseOver;
  private color buttonColor;
  
  public BackButton() {
    mouseOver = false;
    buttonColor = color(200, 0, 50);
  }
  
  public void display() {
    stroke(255);
    fill(buttonColor);
    rect(backX, backY, backW, backH, 7);
    fill(255, 255, 255);
    textFont(backFont);
    textAlign(CENTER, CENTER);
    text("Back", backX, backY, backW, backH);
  }
  
  public void responsive() {
    if (!isMainScene) {
      display();
    }
    
    if ((!isMainScene) && (mouseX >= backM) && (mouseX <= backM + backW) &&  (mouseY >= height - backH - backM) && (mouseY <= height - backM)) {
        mouseOver = true;
    } else {
        mouseOver = false;
    }
    
    colorResponsive();
  }
  
  private void colorResponsive() {
    if (backButton.mouseOver()) {
      buttonColor = color(0, 0, 50);
    } else {
      buttonColor = color(200, 0, 50);
    }
  }
  
  public boolean mouseOver() {
    return mouseOver;
  }
}

public class Country implements Clickable {
  private final PImage pic;
  private boolean mouseOver;
  public boolean isScene;
  private final City[] cities;
  private final color[] colors;
   
  public Country(PImage pic, boolean mouseOver, boolean isScene, City[] cities, color...colors) {
    this.pic = pic;
    this.mouseOver = mouseOver;
    this.isScene = isScene;
    this.cities = cities;
    this.colors = colors;
  }
 
  public void responsive() {
    if (isResponsive()) mouseOver = true;
    else mouseOver = false;
  }
 
  private boolean isResponsive() {
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

public class City implements Clickable {
  private final String name;
  private boolean mouseOver;
  public boolean isMenu;
  private final int x, y;
  private final String blue, green, pink, yellow;
  private final Country location;
  
  public City(String name, Country location, boolean mouseOver, boolean isMenu, int x, int y, String blue, String green, String pink, String yellow) {
    this.name = name;
    this.location = location;
    this.mouseOver = mouseOver;
    this.isMenu = isMenu;
    this.x = x;
    this.y = y;
    this.blue = blue;
    this.green = green;
    this.pink = pink;
    this.yellow = yellow;    
  }
  
  public void responsive() {
    if ((location.isScene) && ((mouseX-x)*(mouseX-x) + (mouseY-y)*(mouseY-y) < d*d/4)) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }
  
  public boolean mouseOver() {
    return mouseOver;
  }
  
  public void display() {
    image(logoInner, x, y, d, d);
    fill(0,0,0);
    textFont(cityFont);
    textAlign(LEFT, CENTER);
    text(name, x + 3*d/4, y);
  }
  
  public void menuScene() {
    isMenuScene = true;
    isMenu = true;
    tintScene();
    image(logo, 900, yc, 400, 400);
    chooseDrawMenuButtons();
    
    isMainScene = false;
  }
  
  public void chooseDrawMenuButtons() {
    if (yellow == "null") {
      fill(180);
      women.button();
      women.exists = false;
    } else {
      fill(255);
      women.button();
      women.exists = true;
    } 

    if (green == "null") {
      fill(180);
      youth.button();
      youth.exists = false;
    } else {
      fill(255);
      youth.button();
      youth.exists = true;
    } 
    
    if (blue == "null") {
      fill(180);
      child.button();
      child.exists = false;
    } else {
      fill(255); 
      child.button();
      child.exists = true;
    }
    
    if (pink == "null") {
      fill(180);
      aid.button();
      aid.exists = false;
    } else {
      fill(255);
      aid.button();
      aid.exists = true;
    }
  }
  
  
}

public class Theme implements Clickable {
  private final String name;
  private boolean mouseOver;
  public boolean exists;
  private float y;
  private final PImage themeLogo;
  
  public Theme(String name, float y, PImage themeLogo, boolean mouseOver, boolean exists) {
    this.name = name;
    this.y = y;
    this.themeLogo = themeLogo;
    this.mouseOver = mouseOver;
    this.exists = exists;
  }
  
  public void responsive() {
    if ((isMenuScene) && (exists) && (mouseWithinThemeArea())) {
      mouseOver = true;
      logo();
      cursor(HAND);
    } else {
      mouseOver = false;
    }
  }
  
  private boolean mouseWithinThemeArea() {
    return (mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > y - themeH/2) && (mouseY < y + themeH/2);
  }
  
  public boolean mouseOver() {
    return mouseOver;
  }
  
  public void button() {
    rect(themeX, y, themeW, themeH);
    fill(0, 0, 0);
    textFont(themeFont);
    textAlign(CENTER, CENTER);
    text(name, themeX, y, themeW, themeH);
  }

  public void logo() {
    image(themeLogo, 900, yc, 400, 400);
  }
}

public class Text {
  public boolean isText;
  private final String title, text1, text2, text3, text4;
  
  public Text(String title, boolean isText, String text1, String text2, String text3, String text4) {
    this.isText = isText;
    this.title = title;
    this.text1 = text1;
    this.text2 = text2;
    this.text3 = text3;
    this.text4 = text4;
  }
  
  public void display() {
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
  
  public void pageChanger() {
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
  belgium.isScene = false;
  levant.isScene = false;
  isMenuScene = false;
  for (int i = 0; i < levCities.length; i++) {
    levCities[i].isMenu = false;
  }
  belCities[0].isMenu = false;
  isTextScene = false;
  
}

void tintScene() {
  tint(155);
  if (belgium.isScene) {
    belgium.displayScene();
  } else if (levant.isScene) {
    levant.displayScene();
  }    
  noTint();
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