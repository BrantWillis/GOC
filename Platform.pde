class Block extends Sprite {
    Block(float x, float y, float w, float h) {
        super(x, y, w, h); // in this case, Sprite
        team = 1;
    }
    
    
    
    @Override
    void handleCollision(int type, String dir) {
      
    }
    
}
