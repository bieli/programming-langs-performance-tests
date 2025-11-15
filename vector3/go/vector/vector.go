package vector

import "math"

type Vector struct {
    X, Y, Z float64
}

func New(x, y, z float64) Vector {
    return Vector{X: x, Y: y, Z: z}
}

func (a Vector) Add(b Vector) Vector {
    return Vector{a.X + b.X, a.Y + b.Y, a.Z + b.Z}
}

func (a Vector) Sub(b Vector) Vector {
    return Vector{a.X - b.X, a.Y - b.Y, a.Z - b.Z}
}

func (a Vector) Cross(b Vector) Vector {
    return Vector{
        a.Y*b.Z - a.Z*b.Y,
        a.Z*b.X - a.X*b.Z,
        a.X*b.Y - a.Y*b.X,
    }
}

func (a Vector) Scale(s float64) Vector {
    return Vector{a.X * s, a.Y * s, a.Z * s}
}

func (a Vector) Div(s float64) Vector {
    return Vector{a.X / s, a.Y / s, a.Z / s}
}

func (a Vector) Magnitude() float64 {
    return math.Sqrt(a.X*a.X + a.Y*a.Y + a.Z*a.Z)
}

func (a Vector) Normalize() Vector {
    mag := a.Magnitude()
    if mag != 0 {
        return a.Div(mag)
    }
    return Vector{}
}

func (a Vector) Angle(b Vector) float64 {
    crossMag := a.Cross(b).Magnitude()
    prodMag := a.Magnitude() * b.Magnitude()
    if prodMag != 0 {
        return math.Asin(crossMag / prodMag)
    }
    return 0
}

