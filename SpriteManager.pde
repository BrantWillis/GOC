class SpriteManager {
    Player player;
    
    ArrayList<Sprite> active = new ArrayList<Sprite>();
    ArrayList<Sprite> destroyed = new ArrayList<Sprite>();
    float scroll = width/2;
    
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
            if(active.get(i).size.x == 20 && active.get(i).size.y == 40 && scroll >= 0) { //is the player
              scroll = active.get(i).pos.x - (width/2);
            }
            if(scroll <= 0) {
              scroll = .00001;
            }
        }
    }
    
    void drawEverything() {
        for (Sprite s : active)
            s.display(scroll);
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
        
        
          //if(abs(p.vel.y) > 15) {            fill(255, 0, 0);}
          //rect(0,100,10,p.vel.y *5);
        
        //rect(px/2,py/2,pw/2,ph/2);
        if(xCollision && yCollision) {
          //rect(ox/2,oy/2,ow/2,oh/2);
          
          if(py < oy && py+ph > oy && py+ph < oy+oh && py < oh+oy) {fin += "d"; rect(0,0,40,40);} //platform below
          if(py < oy+oh && py+ph > oy && py+ph > oy+oh && py>oy) {
          if(p.vel.y > 0) {
              fin += "d"; 
          } else {
            fin += "u";
          }
            rect(40,0,40,40);
          } //platform above
          if(px < ox && px+pw > ox && px+pw < ox+ow && px < ox+ow) {fin += "r"; rect(40,50,40,40);} //platform right
          if(px < ox+ow && px+pw > ox+ow && px>ox && px+pw > ox) {fin += "l"; rect(0,50,40,40);} //platform left
          
        }
        
        
        return (fin);
    }
}
