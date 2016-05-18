final color yellow  = color(222, 194, 64);
final color pink = color(195, 64, 145);
final color blue = color(65, 109, 174);
final color green = color(158, 195, 77);
final color cyan = color(77, 181, 195);

Image logo;
PImage logoInner;

PFont backFont;
PFont cityFont;
PFont themeFont;
PFont titleFont;
PFont bodyFont;

boolean isMenuScene = false;
boolean isTextScene = false;
int currentPage = 1;

final int width = 1280;
final int height = 800;
final float xc = width/2;
final float yc = height/2;

Scene mainScene, belgiumScene, levantScene, currentScene;

ArrayList<Clickable> clickables = new ArrayList<Clickable>();

BackButton backButton = new BackButton();
ChangePageButton prevPB = new ChangePageButton(xc*1.5 - 20, -1);
ChangePageButton nextPB = new ChangePageButton(xc*1.5 + 20, 1);

Country belgium;
Country levant;

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
Text aleppoYouthText = new Text("Bakery", "bakery1");
Text kilisText = new Text("Kilis - closed", "closed1");
Text ammanText = new Text("Amman - TBD", "future1", "future2");
Text collectText = new Text("Collection Campaign", "collect1", "collect2", "collect3", "collect4");
Text nullText = new Text("null");

Text[] texts = new Text[10];

void setup() {
  //size(1280, 800);
  fullScreen();
  smooth(8);
  
  logo = new Image(loadImage("sblogo-400.png"));
  logoInner = loadImage("sblogo-inner.png");

  backFont = createFont("Helvetica-Bold", 20);
  cityFont = createFont("Helvetica-Bold", 15);
  themeFont = createFont("Helvetica", 30);
  titleFont = createFont("Helvetica-Bold", 30);
  bodyFont = createFont("Helvetica", 20);
  
  City brussels = new City("Brussels", 610, 295, nullText, brusselsYouthText, brusselsChildrenText, nullText);
  City beirut = new City("Beirut", 285, 453, womenText, youthText, childrenText, aidText);
  City arsal = new City("Arsal, Bekaa Valley", 358, 424, womenText, youthText, childrenText, aidText);
  City damascus = new City("Damascus", 343, 484, womenText, youthText, childrenText, aidText);
  City aleppo = new City("Aleppo", 407, 235, womenText, aleppoYouthText, childrenText, aidText);
  City kilis = new City("Kilis", 406, 190, kilisText, kilisText, kilisText, kilisText);
  City amman = new City("Amman", 316, 625, ammanText, ammanText, ammanText, ammanText);
  
  mainScene = new Scene("main", loadImage("main-map.png"));
  belgiumScene = new Scene("belgium", loadImage("belgium.png"), brussels, backButton);
  levantScene = new Scene("levant", loadImage("middleeast.png"), beirut, arsal, damascus, aleppo, kilis, amman, backButton);
  
  belgium = new Country(belgiumScene, yellow);
  levant = new Country(levantScene, green, blue, pink, cyan);
  
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

  setScene(mainScene);
};



void draw() {
  currentScene.responsive();
  themeMenuResponsive();
  cursorImageResponsive();
}

void themeMenuResponsive() {
  if (isMenuScene && !isTextScene) {
    logo.display();
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

void setScene(Scene scene) {
  currentScene = scene;
  currentScene.display();
}

/////////////////////////////////
//////////// CLASSES ////////////
/////////////////////////////////

public interface Feature {
  public void display();
  public void responsive();
}

public interface Clickable {
  public boolean mouseOver();
  public void respond();
}


public class Scene {
  private final String name;
  private final PImage image;
  private final ArrayList<Feature> features = new ArrayList<Feature>();
  
  public Scene(String name, PImage image, Feature...features) {
    this.name = name;
    this.image = image;
    add(features);
  }
  
  public Scene(String name, PImage image) {
    this.name = name;
    this.image = image;
  }
  
  public void add(Feature...features) {
    for (Feature feature : features) {
      this.features.add(feature);
    }
  }

  public void remove(Feature...features) {
    for (Feature feature : features) {
      this.features.remove(feature);
    }
  }

  public void responsive() {
    for (Feature feature : features) {
      feature.responsive();
    }
  }
  
  public boolean contains(Feature feature) {
    return features.contains(feature);
  }
  
  public boolean is(Scene other) {
    return name == other.name;
  }
  
  public void display() {
    background(image);
    for (Feature feature : features) {
      feature.display();
    }
  }
}

public class BackButton implements Clickable, Feature {
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
    belgiumScene.remove(women, youth, children, aid);
    levantScene.remove(women, youth, children, aid);
    setScene(mainScene);
    isMenuScene = false;
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
    if (mouseOver()) {
      buttonColor = color(0, 0, 50);
    } else {
      buttonColor = color(200, 0, 50);
    }
    display();
  }
  
  public boolean mouseOver() {
    return (!currentScene.is(mainScene)) && (mouseX >= m) && (mouseX <= m + w) &&  (mouseY >= height - h - m) && (mouseY <= height - m);
  }
}


public class ChangePageButton implements Clickable {
  private final float x;
  private final float y = height - 20;
  private final float d = 40;
  private int notDisplayed;
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
  
  public void setLimit(int pageNumber) {
    notDisplayed = pageNumber;
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
          text.changePage(changeValue);
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
  private final Scene scene;
  private final color[] colors;
   
  public Country(Scene scene, color...colors) {
    this.scene = scene;
    this.colors = colors;
  }
  
  public void respond() {
    displayScene();
  }
 
  public boolean mouseOver() {
    if (!currentScene.is(mainScene)) return false;
    for (color col : colors) {
      if (get(mouseX,mouseY) == col) return true;
    }
    return false;
  }
   
  public void displayScene() {
    setScene(scene);
  }
}


public class City implements Clickable, Feature {
  private final String name;
  private final int x, y;
  private final int d = 50;
  private final Text womenText, youthText, childrenText, aidText;
  
  public City(String name, int x, int y, Text womenText, Text youthText, Text childrenText, Text aidText) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.womenText = womenText;
    this.youthText = youthText;
    this.childrenText = childrenText;
    this.aidText = aidText;
  }
  
  public void responsive() {}
  
  public void respond() {
    isMenuScene = true;
    logo.display();
    
    women.setText(womenText);
    youth.setText(youthText);
    children.setText(childrenText);
    aid.setText(aidText);
    
    currentScene.add(women, youth, children, aid);
    currentScene.display();
    tintScene();
  }
  
  private void tintScene() {
    tint(155);
    if (currentScene.is(belgiumScene)) {
      belgium.displayScene();
    } else if (currentScene.is(levantScene)) {
      levant.displayScene();
    }    
    noTint();
  }
  
  public boolean mouseOver() {
    return (currentScene.contains(this)) && ((mouseX-x)*(mouseX-x) + (mouseY-y)*(mouseY-y) < d*d/4);
  }
  
  public void display() {
    image(logoInner, x, y, d, d);
    fill(0,0,0);
    textFont(cityFont);
    textAlign(LEFT, CENTER);
    text(name, x + 3*d/4, y);
  }
}

public class Image implements Feature {
  
  private final PImage image;
  
  public Image(PImage image) {
    this.image = image;
  }
  
  public void display() {
    image(image, 900, yc, 400, 400);
  }
  
  public void responsive() {}
}


public class Theme implements Clickable, Feature {
  private final String name;
  private boolean exists;
  private final float x = 200;
  private float y;
  private final float w = 200;
  private final float h = 100;  
  private final PImage themeLogo;
  private Text text;
  
  public Theme(String name, float y, PImage themeLogo, Text text) {
    this.name = name;
    this.y = y;
    this.themeLogo = themeLogo;
    this.text = text;
    exists = false;
  }
  
  public void display() {
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

  private void button() {
    rect(x, y, w, h);
    fill(0, 0, 0);
    textFont(themeFont);
    textAlign(CENTER, CENTER);
    text(name, x, y, w, h);
  }

  public void setText(Text text) {
    this.text = text;
  }

  public void responsive() {
    if (mouseOver()) {
      logo();
      cursor(HAND);
    }
  }
  
  private void logo() {
    if (!isTextScene) {
      image(themeLogo, 900, yc, 400, 400);
    }
  }
  
  public void respond() {
      currentPage = 1;
      text.setToFirstPage();
      text.display();
  }
  
  public boolean mouseOver() {
    return isMenuScene && exists && mouseWithinThemeArea();
  }
  
  private boolean mouseWithinThemeArea() {
    return (mouseX > x - w/2) && (mouseX < x + w/2) && (mouseY > y - h/2) && (mouseY < y + h/2);
  }
  
}


public class Text {
  public boolean isText;
  private final String title;
  private final String[] pages;
  private final int numPages;
  private int page;
  
  public Text(String title, String...pages) {
    this.title = title;
    this.pages = pages;
    numPages = pages.length;
    page = 0;
    isText = false;
  }
  
  public void setToFirstPage() {
    page = 0;
  }
  
  public int currentPage() {
    return page;
  }
  
  public void changePage(int value) {
    page += value;
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
    display(pages[page]);
    nextPB.setLimit(numPages);
    if (page > 0) {
      prevPB.display();
    }
    if (page < numPages-1) {
      nextPB.display();
    }
  }
  
  private void display(String text) {
    text(text, xc*1.5, yc*1.5 + 5, xc, yc - 20);
  }
}