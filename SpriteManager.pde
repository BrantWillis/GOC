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
                if (a.team != b.team && collision(a, b)) {
                    active.get(i).handleCollision(0);
                    active.get(j).handleCollision(0);
                }
                else if (a.team == b.team && collision(a,b) && a.size.x > 5 && b.size.x > 5) {
                  active.get(i).handleCollision(1);
                  active.get(j).handleCollision(1);
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
    
    boolean collision(Sprite a, Sprite b) {
        // assumes equal w and h
        /*float r1 = a.size.x / 2.0;
        float r2 = b.size.x / 2.0;
        return r1 + r2 > dist(a.pos.x, a.pos.y, b.pos.x, b.pos.y);*/
        
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
        return (xCollision && yCollision);
    }
}
