class Player extends Sprite {
    boolean left, right, up, down, shift;
    boolean onGround = true;
    boolean stuck = false;
    int lastDirection = 10;
    int jumps = 0;
    PImage img;
    
    Player(float x, float y) {
        // super refers to the parent
        // ... I use it here as a constructor
        super(x, y, 20, 40); // in this case, Sprite
        team = 1;
    }

    @Override
    void update() {
        float speed = 2;
        if (!shift) {
          if (left)  vel.add(new PVector( -speed, 0));
          if (right) vel.add(new PVector(speed, 0));
        }
        if(left) lastDirection = -10;
        if(right) lastDirection = 10;
        
        //if (up)    vel.add(new PVector(0, -speed));
        //if (down)  vel.add(new PVector(0, speed));
        // update the position by velocity
         vel.add(new PVector(0, 1));
         if(stuck) {
           vel.y = 0;
            
         }
         if(pos.y < 40) {
           _SM.destroy(this);
         }
         pos.add(vel);
          
          if(vel.y > 3) jumps = 1;
          rect(0,150,10,jumps*100);

        //fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        //if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height-size.y/2;

        // always try to decelerate
        vel.x *= .7;
        stuck = false;
    }

    @Override
    void display(float scroll) {
        fill(200, 0, 200);
        img = loadImage("data/player.png");
        //rect(pos.x - scroll, pos.y, size.x, size.y);
        image(img, pos.x - scroll, pos.y, size.x, size.y);
    }

    @Override
    void handleCollision(int type, String dir) {
       if(type == 1) {
          /*pos.y -= 3;
          vel.y = 0;
          jumps = 0;*/
          stuck = false;
          if(dir.contains("u")) { //wall is above
              //pos.add(0, vel.y*-1);
              pos.add(0, 1);
              vel.y = 0;
          }
          if(dir.contains("d")) { //wall is below
              pos.add(0, vel.y* -1.0001);
              if(abs(vel.y) <= 1) {
                //pos.add(0,-1);
              }
              
              vel.y = 0;
          }
          if(dir.contains("r") || dir.contains("l")) { //wall is on the right or left
              pos.add(vel.x * -1.42857, 0);
              vel.x = 0;
              if(!dir.contains("u") && !dir.contains("d")) {
                stuck = true;
              } else {stuck = false;}
          } else {stuck = false;}
          
          
          
          //pos.add(vel.mult(-2));
          vel.y = 0;
          jumps = 0;
          //vel = vel.mult(-1);
       } else {
         _SM.destroy(this);
         deathScreen();
       }
    }

    void keyUp() {
      if(key != CODED) {
          switch(key) { // key is a global value
              case 'a':
              case 'A': left = false; break;
              case 's':
              case 'S': down = false; break;
              case 'd':
              case 'D': right = false; break;
              case 'w':
              case 'W': up = false; break;
          }
      } else {
        if (keyCode == SHIFT) shift = false;
      }
    }
    void keyDown() {
      if(key!=CODED) {
          switch(keyCode) { // key is a global value
              case 'a':
              case ' ': if(jumps < 1) {vel.y = -15; jumps++;}break;
              case 'A': left = true; break;
              case 's':
              case 'S': down = true; break;
              case 'd':
              case 'D': right = true; break;
              case 'w':
              case 'W': up = true; break;
              case '8': fire(); break;
              
          }
      } else if(keyCode == SHIFT) shift = true;
    }

    void fire() {
        int xAngle = 0;
        int yAngle = 0;
        if(up) yAngle = -10;
        if(down) yAngle = 10;
        if(left) {xAngle = -10;}
        if(right) {xAngle = 10;}
        if(!down && !up && xAngle == 0) xAngle = lastDirection;
        PVector aim = new PVector(xAngle, yAngle); // up
        _SM.spawn(new Bull(pos.x, pos.y, aim, team));
    }
    
    void deathScreen() {}
      
}
