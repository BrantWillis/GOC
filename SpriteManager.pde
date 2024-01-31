class SpriteManager {
    Player player;
    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    
    SpriteManager() {
        player = new Player(width / 2, height - 100);
        spawn(player);
    }
    
    void destroy(Sprite target) {
        destroyed.add(target);
    }
    
    void spawn(Sprite obj) {
        active.add(obj);
    }
    
    void manage() {
        moveEverything();
        checkCollisions();    
        bringOutTheDead();
        drawEverything();
    }
    
    void moveEverything() {
        for(int i = active.size() - 1; i >= 0; i--) {
            active.get(i).update();           
        }
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display();
    }
    
    void checkCollisions() {
        for (int i = 0; i < active.size(); i++) {
            for (int j = i + 1; j < active.size(); j++) {
                Sprite a = active.get(i);
                Sprite b = active.get(j);
                if (a.team != b.team && collision(a, b) == "e") {
                    a.handleCollision(0, "e");
                    b.handleCollision(0, "e");
                }
                else if (a.team == b.team && (collision(a,b).contains("r") || collision(a,b).contains("l") || collision(a,b).contains("u") || collision(a,b).contains("d")) && a.size.x > 5 && b.size.x > 5) {
                  a.handleCollision(1, collision(a,b));
                  b.handleCollision(1, collision(a,b));
                }
            }
        }
    }
    
    void bringOutTheDead() {
        for (int i = 0; i < destroyed.size(); i++) {
            Sprite target = destroyed.get(i);
            active.remove(target);
            destroyed.remove(target);
        }
    }
    
    String collision(Sprite a, Sprite b) {
        // assumes equal w and h
        /*float r1 = a.size.x / 2.0;
        float r2 = b.size.x / 2.0;
        return r1 + r2 > dist(a.pos.x, a.pos.y, b.pos.x, b.pos.y);*/
        
        /*
        e - true (used when player is not in the collision)
        a - false (used when player is not in collision)
        r - wall on right
        l - wall on left
        d - wall below
        u - wall above
          */
           
        
        float w1 = a.size.x;
        float h1 = a.size.y;
        float x1 = a.pos.x;
        float y1 = a.pos.y;
        float w2 = b.size.x;
        float h2 = b.size.y;
        float x2 = b.pos.x;
        float y2 = b.pos.y;
        boolean yCollision = false;
        boolean xCollision = false;
        
        

        String fin = "";
        Sprite p = new Sprite();
        Sprite o = new Sprite();
        
        if(w1 == 20 && h1 == 40) {
          p = a;
          o = b;
        } else if (w2 == 20 && h2 == 40) {
          p = b; //player
          o = a;//platform
        }
        
        
  
        if(w1 > w2) {
          if( (x2>=x1 && x2<=(x1+w1)) || ((x2+w2)>=x1&&(x2+w2)<=(x1+w1))) {
            xCollision = true;
          }
        } else {
          if( (x1>=x2 && x1<=(x2+w2)) || ((x1+w1)>=x2&&(x1+w1)<=(x2+w2))) {
            xCollision = true;
          }
        }
        if(h1 > h2) {
          if( (y2>=y1 && y2<=(y1+h1)) || ((y2+h2)>=y1&&(y2+h2)<=(y1+h1))) {
            yCollision = true;
          }
        } else {
          if( (y1>=y2 && y1<=(y2+h2)) || ((y1+h1)>=y2&&(h1+y1)<=(y2+h2))) {
            yCollision = true;
          }
        }
        
        
        
        if (xCollision && yCollision && p.team == -100000) { //no player, but collision
          return "e";
        } else if (p.team == -100000) return "a";
        float pw = p.size.x;
        float ph = p.size.y;
        float px = p.pos.x;
        float py = p.pos.y;
        float ow = o.size.x;
        float oh = o.size.y;
        float ox = o.pos.x;
        float oy = o.pos.y;
        
        if(xCollision && yCollision) {
          if(py < oy && py+ph > oy) fin += "d"; //platform below
          if(py < oy+oh && py+ph > oy) fin += "u"; //platform above
          if(px < ox && px+pw > ox) fin += "r"; //platform right
          if(px > ox && px+pw < ox) fin += "l"; //platform left
          
        }
        
        
        return (fin);
    }
}
