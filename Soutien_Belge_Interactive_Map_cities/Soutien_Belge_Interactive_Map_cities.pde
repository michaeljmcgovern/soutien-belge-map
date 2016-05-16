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
boolean isTextScene = false;
int currentPage = 1;

int width = 1280;
int height = 800;
float xc = width/2;
float yc = height/2;
float themeX = 200;
float themeW = 200;
float themeH = 100;

ArrayList<Clickable> clickables = new ArrayList<Clickable>();

BackButton backButton = new BackButton();
ChangePageButton prevPB = new ChangePageButton(xc*1.5 - 20, 1);
ChangePageButton nextPB = new ChangePageButton(xc*1.5 + 20, 4);

Country belgium;
Country levant;

City brussels;
City beirut;
City arsal;
City damascus;
City aleppo;
City kilis;
City amman;

City[] cities = new City[7];

City[] belCities = new City[1];
City[] levCities = new City[6];

Theme women;
Theme youth;
Theme children;
Theme aid;

Theme[] themes = new Theme[4];

Text womenText = new Text("Women's Centres", false, "General problems the war causes for women.", "What SB has done in 1 sentence, when, where.", 
  "Extent of the problem – suggesting what needs we have addressed, and what more needs to be done.", "Details about our programmes.");
Text youthText = new Text("Youth Education", false, "youthed1", "youthed2", "youthed3", "youthed4");
Text childrenText = new Text("Schools", false, 
  "For more than 5 years, a generation of Syrian schoolchildren has been denied access to education. The consequences of such a huge educational deficit are almost unthinkable. Not only is this a personal tragedy in the lives of thousands of young Syrians, but it is also a long-term threat to any vision of a fair, stable, and prosperous Syrian society.", 
  "Since 2013, SB Overseas has addressed this educational deficit by setting up four new schools: in Beirut and Arsal in Lebanon, and in Damascus and Aleppo in Syria.", 
  "Demand for education services is very high in these areas. In Lebanon, the government and aid agencies struggle to provide adequate services to the massive influx of refugees in the country. In Syria, many existing schools have been destroyed in since the beginning of the war – their students are forced to look elsewhere for an education.", 
  "In Syria, around 250 students are enrolled at each school, where they are taught the Syrian curriculum. In Lebanon classes are provided to 150 children at each school. We still see many 8- to 9-year-olds join us who have never spent a day at school before.");
Text aidText = new Text("Psychological Support Centres", false, "psych1", "psych2", "psych3", "psych4");

Text brusselsChildrenText = new Text("SB Weekend", false, "weekend1", "weekend2", "weekend3", "weekend4");
Text brusselsYouthText = new Text("S'engager Pour La Paix", false, "splp1", "splp2", "splp3", "splp4");
Text aleppoYouthText = new Text("Bakery", false, "bakery1", "null", "null", "null");
Text kilisText = new Text("Kilis - closed", false, "closed1", "null", "null", "null");
Text ammanText = new Text("Amman - TBD", false, "future1", "future2", "null", "null");

Text collectText = new Text("Collection Campaign", false, "collect1", "collect2", "collect3", "collect4");

Text[] texts = new Text[10];

void setup() {
  //size(1280, 800);
  fullScreen();
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
  
  brussels = new City("Brussels", belgium, false, false, 610, 295, "weekend", "splp", "null", "null");
  beirut = new City("Beirut", levant, false, false, 285, 453, "school", "null", "psych", "women");
  arsal = new City("Arsal, Bekaa Valley", levant, false, false, 358, 424, "school", "null", "psych", "women");
  damascus = new City("Damascus", levant, false, false, 343, 484, "school", "null", "psych", "women");
  aleppo = new City("Aleppo", levant, false, false, 407, 235, "school", "bakery", "collect", "women");
  kilis = new City("Kilis", levant, false, false, 406, 190, "closed", "null", "null", "null");
  amman = new City("Amman", levant, false, false, 316, 625, "future", "null", "null", "null");
  
  belCities[0] = brussels;
  levCities[0] = beirut;
  levCities[1] = arsal;
  levCities[2] = damascus;
  levCities[3] = aleppo;
  levCities[4] = kilis;
  levCities[5] = amman;
  
  cities[0] = brussels;
  cities[1] = beirut;
  cities[2] = arsal;
  cities[3] = damascus;
  cities[4] = aleppo;
  cities[5] = kilis;
  cities[6] = amman;
  
  women = new Theme("Women", yc - 150, loadImage("sblogo-yellow.png"), false, false);
  youth = new Theme("Youth", yc - 50, loadImage("sblogo-green.png"), false, false);
  children = new Theme("Children", yc + 50, loadImage("sblogo-blue.png"), false, false);
  aid = new Theme("Aid", yc + 150, loadImage("sblogo-pink.png"), false, false);
  
  themes[0] = women;
  themes[1] = youth;
  themes[2] = children;
  themes[3] = aid;
  
  texts[0] = womenText;
  texts[1] = youthText;
  texts[2] = childrenText;
  texts[3] = aidText;
  texts[4] = brusselsChildrenText;
  texts[5] = brusselsYouthText;
  texts[6] = aleppoYouthText;
  texts[7] = kilisText;
  texts[8] = ammanText;
  texts[9] = collectText;
  
  clickables.add(backButton);
  clickables.add(prevPB);
  clickables.add(nextPB);
  clickables.add(belgium);
  clickables.add(levant);
  clickables.add(brussels);
  clickables.add(beirut);
  clickables.add(arsal);
  clickables.add(damascus);
  clickables.add(aleppo);
  clickables.add(kilis);
  clickables.add(amman);
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  background(mainmap);
};



void draw() {
  backButtonResponsive();
  changePageButtonsResponsive();
  countriesResponsive();
  citiesResponsive();
  themeMenuResponsive();
  cursorImageResponsive();
}

void backButtonResponsive() {
  backButton.responsive();
}

void changePageButtonsResponsive() {
  prevPB.responsive();
  nextPB.responsive();
}


void countriesResponsive() {
  levant.responsive();
  belgium.responsive();
}

void citiesResponsive() {
  for (City city : cities) {
    city.responsive();
  }
}

void themeMenuResponsive() {
  for (Theme theme : themes) {
    theme.responsive();
  }
  
  if ((isMenuScene) && (!isTextScene) && (!women.mouseOver()) && (!youth.mouseOver()) && (!children.mouseOver()) && (!aid.mouseOver())) {
    image(logo, 900, yc, 400, 400);
  }
}

void cursorImageResponsive() {
  for (Clickable clickable : clickables) {
    if (clickable.mouseOver()) {
      cursor(HAND);
      return;
    }
  }
  
  if (
    (women.mouseOver())
    || (youth.mouseOver())
    || (children.mouseOver())
    || (aid.mouseOver()))
        
      {cursor(HAND);}
  
  else  {cursor(ARROW);}

}

///////////////////////////////
//////// INTERACTIVITY ////////
///////////////////////////////

void mouseReleased() {
  for (Clickable clickable : clickables) {
    if (clickable.mouseOver()) {
      clickable.respond();
      return;
    }
  }
  
  if (brussels.isMenu) {
    if (youth.mouseOver()) {
      brusselsYouthText.display();
    }
    else if (children.mouseOver()) {
      brusselsChildrenText.display();
    }
  }
  
  else if (aleppo.isMenu) {
    if (women.mouseOver()) {
      womenText.display();
    } else if (youth.mouseOver()) {
      aleppoYouthText.display();
    } else if (children.mouseOver()) {
      childrenText.display();
    } else if (aid.mouseOver()) {
      aidText.display();
    }
  }
  
  else if (kilis.isMenu) {
    if ((women.mouseOver()) || (youth.mouseOver()) || (children.mouseOver()) || (aid.mouseOver())) {
      kilisText.display();
    }
  }
  
  else if (amman.isMenu) {
    if ((women.mouseOver()) || (youth.mouseOver()) || (children.mouseOver()) || (aid.mouseOver())) {
      ammanText.display();
    }
  }
  
  else if (women.mouseOver()) {
    womenText.display();
  } else if (youth.mouseOver()) {
    youthText.display();
  } else if (children.mouseOver()) {
    childrenText.display();
  } else if (aid.mouseOver()) {
    aidText.display();
  }
}

/////////////////////////////////
//////////// CLASSES ////////////
/////////////////////////////////

public interface Clickable {
  public boolean mouseOver();
  public void responsive();
  public void respond();
}




public class BackButton implements Clickable {
  private boolean mouseOver;
  private color buttonColor;
  
  private final int w = 90;
  private final int h = 50;
  private final int m = 15;
  private final int x = w/2 + m;
  private final int y = height - h/2 - m;
  
  public BackButton() {
    mouseOver = false;
    buttonColor = color(200, 0, 50);
  }
  
  public void respond() {
    background(mainmap);
    isMainScene = true;
    belgium.isScene = false;
    levant.isScene = false;
    isMenuScene = false;
    for (int i = 0; i < cities.length; i++) {
      cities[i].isMenu = false;
    }
    isTextScene = false;
  }
  
  public void display() {
    stroke(255);
    strokeWeight(3);
    fill(buttonColor);
    rect(x, y, w, h, 7);
    fill(255, 255, 255);
    textFont(backFont);
    textAlign(CENTER, CENTER);
    text("Back", x, y, w, h);
  }
  
  public void responsive() {
    if (!isMainScene) {
      display();
    }
    
    if ((!isMainScene) && (mouseX >= m) && (mouseX <= m + w) &&  (mouseY >= height - h - m) && (mouseY <= height - m)) {
        mouseOver = true;
    } else {
        mouseOver = false;
    }
    
    colorResponsive();
  }
  
  private void colorResponsive() {
    if (mouseOver()) {
      buttonColor = color(0, 0, 50);
    } else {
      buttonColor = color(200, 0, 50);
    }
  }
  
  public boolean mouseOver() {
    return mouseOver;
  }
}






public class ChangePageButton implements Clickable {
  private boolean mouseOver;
  private float x;
  private int notDisplay;

  private final float y = height - 20;
  private final float d = 40;
  
  public ChangePageButton(float x, int notDisplay) {
    mouseOver = false;
    this.x = x;
    this.notDisplay = notDisplay;
  }
  
  public void display() {
    fill(255,0,0);
    ellipse(x, y, d, d);
    strokeWeight(3);
    fill(0,0,0);
    if (notDisplay == 1) {
      line(x-d/5, y, x+d/10, y+3*d/10);
      line(x-d/5, y, x+d/10, y-3*d/10);
    } else if (notDisplay == 4) {
      line(x+d/5, y, x-d/10, y+3*d/10);
      line(x+d/5, y, x-d/10, y-3*d/10);
    }
  }
  
  public void responsive() {
    if ((isTextScene) && (currentPage != notDisplay) && ((mouseX - x)*(mouseX - x) + (mouseY - y)*(mouseY - y) < d*d/4)) {
      mouseOver = true;
    } else {
      mouseOver = false;
    }
  }
  
  public void respond() {
    if (isTextScene) {
      for (Text text : texts) {
        if ((text.isText) && (prevPB.mouseOver)) {
          currentPage -= 1;
          text.display();
        } else if ((text.isText) && (nextPB.mouseOver)) {
          currentPage += 1;
          text.display();
        }
      }
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
  
  public void respond() {
    displayScene();
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
  private final int d = 50;
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
  
  public void respond() {
    isMenuScene = true;
    isMenu = true;
    tintScene();
    image(logo, 900, yc, 400, 400);
    chooseDrawMenuButtons();
    
    isMainScene = false;
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
      children.button();
      children.exists = false;
    } else {
      fill(255); 
      children.button();
      children.exists = true;
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
  
  public void respond() {
    // TODO
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
    if (!isTextScene) {
      image(themeLogo, 900, yc, 400, 400);
    }
  }
}

public class Text {
  public boolean isText;
  private final String title;
  private final String[] text;
  
  public Text(String title, boolean isText, String...text) {
    this.title = title;
    this.isText = isText;
    this.text = text;
  }
  
  public void display() {
    isTextScene = true;
    isText = true;
        
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
      text(text[0], xc*1.5, yc*1.5 + 5, xc, yc - 20);
      nextPB.display();
      //image(image1, xc/2, yc/2, xc, yc);
    } else if (currentPage == 2) {
      text(text[1], xc*1.5, yc*1.5 + 5, xc, yc - 20);
      prevPB.display();
      nextPB.display();
      //image(image2, xc/2, yc/2, xc, yc);
    } else if (currentPage == 3) {
      text(text[2], xc*1.5, yc*1.5 + 5, xc, yc - 20);
      prevPB.display();
      nextPB.display();
      //image(image3, xc/2, yc/2, xc, yc);
    } else if (currentPage == 4) {
      text(text[3], xc*1.5, yc*1.5 + 5, xc, yc - 20);
      prevPB.display();
      //image(image4, xc/2, yc/2, xc, yc);
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

void tintScene() {
  tint(155);
  if (belgium.isScene) {
    belgium.displayScene();
  } else if (levant.isScene) {
    levant.displayScene();
  }    
  noTint();
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