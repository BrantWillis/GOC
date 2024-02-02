SpriteManager _SM;

void setup() {
    size(1024, 768);
    _SM = new SpriteManager();
    _SM.spawn(new Block(0, 700,1500, height));
    //_SM.spawn(new Block(500, 500, width - 500, 20));
    _SM.spawn(new Block(600, 300, 20, height));
    _SM.spawn(new Block(500, 300, 20, 300));
    _SM.spawn(new Block(2500, 700, 1000, height));
    _SM.spawn(new Invader(250, 500));
    _SM.spawn(new Invader(1550, 700));
    _SM.spawn(new Sitter(1700, 200));
    _SM.spawn(new Sitter(1900, 250));
    _SM.spawn(new Shooter(150, 100));
}

void draw() {
    background(0);
    _SM.manage();
}

void keyPressed() {
    _SM.player.keyDown();
}

void keyReleased() {
    _SM.player.keyUp();
}
