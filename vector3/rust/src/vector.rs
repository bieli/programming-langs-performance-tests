#[derive(Debug, Clone, Copy)]
pub struct Vector {
    pub x: f64,
    pub y: f64,
    pub z: f64,
}

impl Vector {
    pub fn new(x: f64, y: f64, z: f64) -> Self {
        Vector { x, y, z }
    }

    pub fn add(self, other: Vector) -> Vector {
        Vector::new(self.x + other.x, self.y + other.y, self.z + other.z)
    }

    pub fn sub(self, other: Vector) -> Vector {
        Vector::new(self.x - other.x, self.y - other.y, self.z - other.z)
    }

    pub fn cross(self, other: Vector) -> Vector {
        Vector::new(
            self.y * other.z - self.z * other.y,
            self.z * other.x - self.x * other.z,
            self.x * other.y - self.y * other.x,
        )
    }

    pub fn scale(self, scalar: f64) -> Vector {
        Vector::new(self.x * scalar, self.y * scalar, self.z * scalar)
    }

    pub fn div(self, scalar: f64) -> Vector {
        Vector::new(self.x / scalar, self.y / scalar, self.z / scalar)
    }

    pub fn magnitude(self) -> f64 {
        (self.x * self.x + self.y * self.y + self.z * self.z).sqrt()
    }

    pub fn normalize(self) -> Vector {
        let mag = self.magnitude();
        if mag != 0.0 {
            self.div(mag)
        } else {
            Vector::new(0.0, 0.0, 0.0)
        }
    }

    pub fn angle(self, other: Vector) -> f64 {
        let cross_mag = self.cross(other).magnitude();
        let prod_mag = self.magnitude() * other.magnitude();
        if prod_mag != 0.0 {
            cross_mag.asin() / prod_mag
        } else {
            0.0
        }
    }
}

