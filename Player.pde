class Player extends Sprite {
    boolean left, right, up, down, shift;
    boolean onGround = true;
    int lastDirection = 10;
    int jumps = 0;
    
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
          pos.add(vel);

        //fix bounds
        if(pos.x < 0 + size.x/2) pos.x = size.x/2;
        if(pos.x > width - size.x/2) pos.x = width - size.x/2;
        if(pos.y < 0 + size.y/2) pos.y = size.y/2;
        if(pos.y > height - size.y/2) pos.y = height-size.y/2;

        // always try to decelerate
        vel.x *= .7;
    }

    @Override
    void display() {
        fill(200, 0, 200);
        rect(pos.x, pos.y, size.x, size.y);
    }

    @Override
    void handleCollision(int type, String dir) {
       if(type == 1) {
          /*pos.y -= 3;
          vel.y = 0;
          jumps = 0;*/
          if(dir.contains("r") || dir == "l") { //wall is on the right or left
              pos.add(vel.x * -1, 0);
          }
          if(dir.contains("u")) { //wall is above
              pos.add(0, vel.y*-1);
              pos.add(0, 1);
              vel.y = 0;
          }
          if(dir.contains("d")) { //wall is below
              pos.add(0, -1);
              vel.y = 0;
          }
          
          
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
              case ' ': if(jumps < 2) {vel.y = -15; jumps++;}break;
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
        if(left) {xAngle = -10;}
        if(right) {xAngle = 10;}
        if(!up && xAngle == 0) xAngle = lastDirection;
        PVector aim = new PVector(xAngle, yAngle); // up
        _SM.spawn(new Bullet(pos.x, pos.y, aim, team));
    }
    
    void deathScreen() {}
      
}
