class Shooter extends Sprite {

    long mark, wait = 1200; // ms

    Shooter(float x, float y) {
        super(x, y, 40, 40);
        mark = millis();
        vel =  new PVector(5,0);
    }

    @Override
    void update() {
      
      if(abs(pos.x - width/2 - scroll) < 700) { 
          pos.add(vel);
          
          if (pos.x < 0 || pos.x > width) {
              vel.x *= -1;
          }
        
          super.update();
          PVector aim = new PVector(_SM.player.pos.x - this.pos.x, _SM.player.pos.y - this.pos.y);
          aim = aim.normalize().mult(8); // turn this into a single unit vector, then increase its magnitude
  
          if(millis() - mark > wait) {
              mark = millis();
              _SM.spawn(new Bull(pos, aim, team));
          }
      }
    }
}
