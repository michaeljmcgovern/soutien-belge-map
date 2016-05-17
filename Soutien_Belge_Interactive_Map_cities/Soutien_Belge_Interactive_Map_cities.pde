color yel  = color(222, 194, 64);
color pin = color(195, 64, 145);
color blu = color(65, 109, 174);
color gre = color(158, 195, 77);
color cya = color(77, 181, 195);

PImage mainMap;
PImage logo;
PImage logoInner;

PFont backFont;
PFont cityFont;
PFont themeFont;
PFont titleFont;
PFont bodyFont;

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

Scene mainScene, belgiumScene, levantScene;
Scene currentScene;

ArrayList<Clickable> clickables = new ArrayList<Clickable>();

BackButton backButton = new BackButton();
ChangePageButton prevPB = new ChangePageButton(xc*1.5 - 20, -1);
ChangePageButton nextPB = new ChangePageButton(xc*1.5 + 20, 1);

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

Text womenText = new Text("Women's Centres", "General problems the war causes for women.", "What SB has done in 1 sentence, when, where.", 
  "Extent of the problem – suggesting what needs we have addressed, and what more needs to be done.", "Details about our programmes.");
Text youthText = new Text("Youth Education", "youthed1", "youthed2", "youthed3", "youthed4");
Text childrenText = new Text("Schools",  
  "For more than 5 years, a generation of Syrian schoolchildren has been denied access to education. The consequences of such a huge educational deficit are almost unthinkable. Not only is this a personal tragedy in the lives of thousands of young Syrians, but it is also a long-term threat to any vision of a fair, stable, and prosperous Syrian society.", 
  "Since 2013, SB Overseas has addressed this educational deficit by setting up four new schools: in Beirut and Arsal in Lebanon, and in Damascus and Aleppo in Syria.", 
  "Demand for education services is very high in these areas. In Lebanon, the government and aid agencies struggle to provide adequate services to the massive influx of refugees in the country. In Syria, many existing schools have been destroyed in since the beginning of the war – their students are forced to look elsewhere for an education.", 
  "In Syria, around 250 students are enrolled at each school, where they are taught the Syrian curriculum. In Lebanon classes are provided to 150 children at each school. We still see many 8- to 9-year-olds join us who have never spent a day at school before.");
Text aidText = new Text("Psychological Support Centres", "psych1", "psych2", "psych3", "psych4");

Text brusselsChildrenText = new Text("SB Weekend", "weekend1", "weekend2", "weekend3", "weekend4");
Text brusselsYouthText = new Text("S'engager Pour La Paix", "splp1", "splp2", "splp3", "splp4");
Text aleppoYouthText = new Text("Bakery", "bakery1", "null", "null", "null");
Text kilisText = new Text("Kilis - closed", "closed1", "null", "null", "null");
Text ammanText = new Text("Amman - TBD", "future1", "future2", "null", "null");

Text collectText = new Text("Collection Campaign", "collect1", "collect2", "collect3", "collect4");

Text nullText = new Text("null");

Text[] texts = new Text[10];

void setup() {
  size(1280, 800);
  //fullScreen();
  smooth(8);
  
  mainMap = loadImage("main-map.png");
  logo = loadImage("sblogo-400.png");
  logoInner = loadImage("sblogo-inner.png");

  backFont = createFont("Helvetica-Bold", 20);
  cityFont = createFont("Helvetica-Bold", 15);
  themeFont = createFont("Helvetica", 30);
  titleFont = createFont("Helvetica-Bold", 30);
  bodyFont = createFont("Helvetica", 20);
  
  mainScene = new Scene(mainMap);
  belgiumScene = new Scene(loadImage("belgium.png"));
  levantScene = new Scene(loadImage("middleeast.png"));
  
  belgium = new Country(belCities, belgiumScene, yel);
  levant = new Country(levCities, levantScene, gre, blu, pin, cya);
  
  brussels = new City("Brussels", belgiumScene, 610, 295, nullText, brusselsYouthText, brusselsChildrenText, nullText);
  beirut = new City("Beirut", levantScene, 285, 453, womenText, youthText, childrenText, aidText);
  arsal = new City("Arsal, Bekaa Valley", levantScene, 358, 424, womenText, youthText, childrenText, aidText);
  damascus = new City("Damascus", levantScene, 343, 484, womenText, youthText, childrenText, aidText);
  aleppo = new City("Aleppo", levantScene, 407, 235, womenText, aleppoYouthText, childrenText, aidText);
  kilis = new City("Kilis", levantScene, 406, 190, kilisText, kilisText, kilisText, kilisText);
  amman = new City("Amman", levantScene, 316, 625, ammanText, ammanText, ammanText, ammanText);
  
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
  
  women = new Theme("Women", yc - 150, loadImage("sblogo-yellow.png"), womenText);
  youth = new Theme("Youth", yc - 50, loadImage("sblogo-green.png"), youthText);
  children = new Theme("Children", yc + 50, loadImage("sblogo-blue.png"), childrenText);
  aid = new Theme("Aid", yc + 150, loadImage("sblogo-pink.png"), aidText);
  
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
  clickables.add(women);
  clickables.add(youth);
  clickables.add(children);
  clickables.add(aid);
  
  
  ellipseMode(CENTER);
  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  currentScene = mainScene;
  currentScene.display();
};



void draw() {
  backButtonResponsive();
  themeMenuResponsive();
  cursorImageResponsive();
}

void backButtonResponsive() {
  backButton.responsive();
}

void themeMenuResponsive() {
  if (isMenuScene && !isTextScene) {
    image(logo, 900, yc, 400, 400);
  }
  for (Theme theme : themes) {
    theme.responsive();
  }
}

void cursorImageResponsive() {
  for (Clickable clickable : clickables) {
    if (clickable.mouseOver()) {
      cursor(HAND);
      return;
    }
  }
  cursor(ARROW);
}

void mouseReleased() {
  for (Clickable clickable : clickables) {
    if (clickable.mouseOver()) {
      clickable.respond();
      return;
    }
  }
}

/////////////////////////////////
//////////// CLASSES ////////////
/////////////////////////////////

public class Scene {
  private PImage image;
  
  public Scene(PImage image) {
    this.image = image;
  }
  
  public void display() {
    background(image);
  }
}

public interface Clickable {
  public boolean mouseOver();
  public void respond();
}


public class BackButton implements Clickable {
  private color buttonColor;
  
  private final int w = 90;
  private final int h = 50;
  private final int m = 15;
  private final int x = w/2 + m;
  private final int y = height - h/2 - m;
  
  public BackButton() {
    buttonColor = color(200, 0, 50);
  }
  
  public void respond() {
    currentScene = mainScene;
    currentScene.display();
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
    if (currentScene != mainScene) {
      display();
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
    return (currentScene != mainScene) && (mouseX >= m) && (mouseX <= m + w) &&  (mouseY >= height - h - m) && (mouseY <= height - m);
  }
}


public class ChangePageButton implements Clickable {
  private final float x;
  private final float y = height - 20;
  private final float d = 40;
  private final int notDisplayed;
  private final int changeValue;

  public ChangePageButton(float x, int changeValue) {
    this.x = x;
    this.changeValue = changeValue;
    if (changeValue < 0) {
      notDisplayed = 1;
    } else {
      notDisplayed = 4;
    }
  }

  public void display() {
    fill(255,0,0);
    ellipse(x, y, d, d);
    strokeWeight(3);
    fill(0,0,0);
    
    line(x+changeValue*d/5, y, x-changeValue*d/10, y+3*d/10);
    line(x+changeValue*d/5, y, x-changeValue*d/10, y-3*d/10);
  }

  public void respond() {
    if (isTextScene) {
      for (Text text : texts) {
        if (text.isText) {
          currentPage += changeValue;
          text.display();
        }
      }
    }
  }

  public boolean mouseOver() {
    return (isTextScene) && (currentPage != notDisplayed) && ((mouseX - x)*(mouseX - x) + (mouseY - y)*(mouseY - y) < d*d/4);
  }
}


public class Country implements Clickable {
  private final City[] cities;
  private final Scene scene;
  private final color[] colors;
   
  public Country(City[] cities, Scene scene, color...colors) {
    this.cities = cities;
    this.scene = scene;
    this.colors = colors;
  }
  
  public void respond() {
    displayScene();
  }
 
  public boolean mouseOver() {
    if (currentScene != mainScene) return false;
    for (color col : colors) {
      if (get(mouseX,mouseY) == col) return true;
    }
    return false;
  }
   
  public void displayScene() {
    currentScene = scene;
    currentScene.display();
    for (int i = 0; i < cities.length; i++) {
      cities[i].display();
    }
  }
}


public class City implements Clickable {
  private final String name;
  public boolean isMenu;
  private final int x, y;
  private final int d = 50;
  private final Text womenText, youthText, childrenText, aidText;
  private final Scene location;
  
  public City(String name, Scene location, int x, int y, Text womenText, Text youthText, Text childrenText, Text aidText) {
    this.name = name;
    this.location = location;
    this.x = x;
    this.y = y;
    this.womenText = womenText;
    this.youthText = youthText;
    this.childrenText = childrenText;
    this.aidText = aidText;
    isMenu = false;  
  }
  
  public void respond() {
    for (City city : cities) {
      city.isMenu = false;
    }
    
    isMenuScene = true;
    isMenu = true;
    tintScene();
    image(logo, 900, yc, 400, 400);
    
    women.setText(womenText);
    youth.setText(youthText);
    children.setText(childrenText);
    aid.setText(aidText);
  }
  
  public boolean mouseOver() {
    return (currentScene == location) && ((mouseX-x)*(mouseX-x) + (mouseY-y)*(mouseY-y) < d*d/4);
  }
  
  public void display() {
    image(logoInner, x, y, d, d);
    fill(0,0,0);
    textFont(cityFont);
    textAlign(LEFT, CENTER);
    text(name, x + 3*d/4, y);
  }
}


public class Theme implements Clickable {
  private final String name;
  private boolean exists;
  private float y;
  private final PImage themeLogo;
  private Text text;
  
  public Theme(String name, float y, PImage themeLogo, Text text) {
    this.name = name;
    this.y = y;
    this.themeLogo = themeLogo;
    this.text = text;
    exists = false;
  }

  public void setText(Text text) {
    this.text = text;
    if (text.title == "null") {
      fill(180);
      button();
      exists = false;
    } else {
      fill(255);
      button();
      exists = true;
    } 
  }

  public void responsive() {
    if (mouseOver()) {
      logo();
      cursor(HAND);
    }
  }
  
  public void respond() {
      currentPage = 1;
      text.display();
  }
  
  public boolean mouseOver() {
    return (isMenuScene) && (exists) && (mouseWithinThemeArea());
  }
  
  private boolean mouseWithinThemeArea() {
    return (mouseX > themeX - themeW/2) && (mouseX < themeX + themeW/2) && (mouseY > y - themeH/2) && (mouseY < y + themeH/2);
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
  
  public Text(String title, String...text) {
    this.title = title;
    this.text = text;
    isText = false;
  }
  
  public void display() {
    isTextScene = true;
    
    for (Text text : texts) {
      text.isText = false;
    }
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
  if (currentScene == belgiumScene) {
    belgium.displayScene();
  } else if (currentScene == levantScene) {
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