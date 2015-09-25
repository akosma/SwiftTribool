import Tribool

// Tribool values have three states
let f = Tribool.False
let t = Tribool.True
let i = Tribool.Indeterminate

// You can also use numbers and strings to create them
let f2 = Tribool(0)
let t2 = Tribool(1)
let i2 = Tribool(2)

// Or strings
let f3 = Tribool("false")
let t3 = Tribool("true")
let i3 = Tribool("indeterminate")

// Actually any string or number will give you indeterminates
let i4 = Tribool(234)
let i5 = Tribool("wat")

// Or booleans
let f4 = false.triboolValue
let f5 = Tribool(false)
let t4 = true.triboolValue
let t5 = Tribool(true)

// All of the values above are equivalent
let b1 : Bool = (f == f3)
let b2 : Bool = (t == t4)
let b3 : Bool = (t == true)
let b4 : Bool = (t == "true")
let b5 : Bool = (i == i5)
let b6 : Bool = (i == "indeterminate")

// This is False
f && t

// This is True
f || t

// This is False
!t

// This is True
!f

// Complex operations follow the usual priority rules
// and accept strings or boolean representations alike
print("false" || !true && i)

// Indeterminate values have weird properties
!i
i && t
i || f
let equal1 : Tribool = (i != f)
let equal2 : Tribool = (t == i)
