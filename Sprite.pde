class Sprite {
    PVector pos, vel, size;
    int team = 2;
    
    Sprite(float x, float y, float w, float h) {
        pos = new PVector(x, y);
        vel = new PVector(0, 0);
        size = new PVector(w, h);
    }
    
    Sprite(){
        team = -100000;
    }
    
    void update() {
        
    }
    
    void display(float scroll) {
        fill(255);
        rect(pos.x - scroll, pos.y, size.x, size.y);
    }
    
    void handleCollision(int type, String dir) { //type 0: bullet, type 1: platform (only applies to player)
        if(type == 0) {
          _SM.destroy(this);
        }
    }
}
