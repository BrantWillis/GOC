class Invader extends Sprite {
    
    // constructor
    Invader(float x, float y) {
        super(x, y, 40, 40);
        vel = new PVector(5, 0); // moving right
       
    }
    
    @Override // change directions left and right
    void update() {
        pos.add(vel);
        
        if (pos.x < 0 || pos.x > width) {
            vel.x *= -1;
        }
    }
}
