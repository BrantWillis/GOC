class Invader extends Sprite {
  //team = 1;
  PImage img;
    
    // constructor
    Invader(float x, float y) {
        super(x, y, 150, 10);
        //team = 1;
        vel = new PVector(2, 0); // moving right
       
    }
    @Override
    void handleCollision(int type, String dir) {
      /*if(type == 0) {
        _SM.destroy(this);
      } else {*/
      pos.add(vel.x*-1, vel.y*-1);
        vel.mult(-1);
        
      //}
    }
    
    @Override
    void display(float scroll) {
      img = loadImage("data/spikes.png");
      image(img, pos.x - scroll, pos.y, size.x, size.y);
    }
    
    @Override // change directions left and right
    void update() {
        pos.add(vel);
        
        if (pos.x < 0) {
            vel.x *= -1;
        }
    }
}
