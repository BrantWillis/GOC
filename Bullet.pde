class Bull extends Sprite {
    
    Bull(float x, float y, PVector velocity, int team) {
        super(x, y, 5, 5); // invoke parent constructor
        vel = velocity;
        this.team = team;
    }

    Bull(PVector pos, PVector vel, int team) {
        // constructor chaining
        this(pos.x, pos.y, vel, team); // invoke another own constructor
        // this refers to the above on line 3
    }
    
    @Override
    void update() {
        pos.add(vel);
        //vel.y *= .9;
        //if (vel.y == 0) vel.y = -.00001;
    }
}
