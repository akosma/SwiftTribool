//
//  Tribool.swift
//  Tribool
//
//  Created by Adrian on 24/09/15.
//  Copyright © 2015 Adrian Kosmaczewski. All rights reserved.
//

public enum Tribool: Equatable, CustomStringConvertible {
    case True
    case False
    case Indeterminate
    
    public var boolValue: Bool? {
        switch self {
        case True:
            return true
        case False:
            return false
        default:
            return nil
        }
    }
    
    public var description: String {
        switch self {
        case .False:
            return "False"
            
        case .True:
            return "True"
            
        case .Indeterminate:
            return "Indeterminate"
        }
    }
    
    public init(_ value: Bool) {
        self = value.triboolValue
    }
    
    public init(_ value: Int) {
        if value == 0 {
            self = False
        }
        else if value == 1 {
            self = True
        }
        else {
            self = Indeterminate
        }
    }
    
    public init(_ value: String) {
        if value == "false" {
            self = False
        }
        else if value == "true" {
            self = True
        }
        else {
            self = Indeterminate
        }
    }
    
    public func equals(value: Tribool) -> Tribool {
        switch self {
        case .False:
            
            switch value {
            case .False:
                return .True
            case .True:
                return .False
            case .Indeterminate:
                return .Indeterminate
            }
            
        case True:

            switch value {
            case .False:
                return .False
            case .True:
                return .True
            case .Indeterminate:
                return .Indeterminate
            }
            
        case .Indeterminate:
            return .Indeterminate
        }
    }
    
    public func equals(value: Tribool) -> Bool {
        switch self {
        case .False:
            
            switch value {
            case .False:
                return true
            case .True, .Indeterminate:
                return false
            }

        case .True:
            
            switch value {
            case .True:
                return true
            case .False, .Indeterminate:
                return false
            }

        case .Indeterminate:
            
            switch value {
            case .True, .False:
                return false
            case .Indeterminate:
                return true
            }
        }
    }
    
    public func negate() -> Tribool {
        switch self {
        case .False:
            return .True
            
        case .True:
            return .False
            
        case .Indeterminate:
            return .Indeterminate
        }
    }
    
    public func and(value: Tribool) -> Tribool {
        switch self {
        case .False:
            // False is the absorbing element in this operation
            return .False
            
        case .True:
            // True is the identity element in this operation
            return value
            
        case .Indeterminate:

            switch value {
            case .False:
                return .False
            case .True, .Indeterminate:
                return .Indeterminate
            }
        }
    }
    
    public func or(value: Tribool) -> Tribool {
        switch self {
        case .False:
            // False is the identity element in this operation
            return value
            
        case .True:
            // True is the absorbing element in this operation
            return .True
            
        case .Indeterminate:
            
            switch value {
            case .True:
                return .True
            case .False, .Indeterminate:
                return .Indeterminate
            }
        }
    }
}

public extension Bool {
    public var triboolValue : Tribool {
        if self {
            return .True
        }
        else {
            return .False
        }
    }
}

// Negation operator

public prefix func ! (value: Tribool) -> Tribool {
    return value.negate()
}

// Equality operators, returning Bool

public func == (lhs: Tribool, rhs: Tribool) -> Bool {
    return lhs.equals(rhs)
}

public func == (lhs: Bool, rhs: Tribool) -> Bool {
    return Tribool(lhs).equals(rhs)
}

public func == (lhs: Tribool, rhs: Bool) -> Bool {
    return lhs.equals(Tribool(rhs))
}

public func == (lhs: String, rhs: Tribool) -> Bool {
    return Tribool(lhs).equals(rhs)
}

public func == (lhs: Tribool, rhs: String) -> Bool {
    return lhs.equals(Tribool(rhs))
}

// Equality operators, returning Tribool

public func == (lhs: Tribool, rhs: Tribool) -> Tribool {
    return lhs.equals(rhs)
}

public func == (lhs: Bool, rhs: Tribool) -> Tribool {
    return Tribool(lhs).equals(rhs)
}

public func == (lhs: Tribool, rhs: Bool) -> Tribool {
    return lhs.equals(Tribool(rhs))
}

public func == (lhs: String, rhs: Tribool) -> Tribool {
    return Tribool(lhs).equals(rhs)
}

public func == (lhs: Tribool, rhs: String) -> Tribool {
    return lhs.equals(Tribool(rhs))
}

// Inequality operators

public func != (lhs: Tribool, rhs: Tribool) -> Bool {
    return !lhs.equals(rhs)
}

public func != (lhs: Tribool, rhs: Tribool) -> Tribool {
    return !lhs.equals(rhs)
}

public func != (lhs: Bool, rhs: Tribool) -> Tribool {
    return !Tribool(lhs).equals(rhs)
}

public func != (lhs: Tribool, rhs: Bool) -> Tribool {
    return !lhs.equals(Tribool(rhs))
}

public func != (lhs: String, rhs: Tribool) -> Tribool {
    return !Tribool(lhs).equals(rhs)
}

public func != (lhs: Tribool, rhs: String) -> Tribool {
    return !lhs.equals(Tribool(rhs))
}

// Logical conjunction

public func && (lhs: Tribool, rhs: Tribool) -> Tribool {
    return lhs.and(rhs)
}

public func && (lhs: Bool, rhs: Tribool) -> Tribool {
    return Tribool(lhs).and(rhs)
}

public func && (lhs: Tribool, rhs: Bool) -> Tribool {
    return lhs.and(Tribool(rhs))
}

public func && (lhs: String, rhs: Tribool) -> Tribool {
    return Tribool(lhs).and(rhs)
}

public func && (lhs: Tribool, rhs: String) -> Tribool {
    return lhs.and(Tribool(rhs))
}

// Logical disjunction

public func || (lhs: Tribool, rhs: Tribool) -> Tribool {
    return lhs.or(rhs)
}

public func || (lhs: Bool, rhs: Tribool) -> Tribool {
    return Tribool(lhs).or(rhs)
}

public func || (lhs: Tribool, rhs: Bool) -> Tribool {
    return lhs.or(Tribool(rhs))
}

public func || (lhs: String, rhs: Tribool) -> Tribool {
    return Tribool(lhs).or(rhs)
}

public func || (lhs: Tribool, rhs: String) -> Tribool {
    return lhs.or(Tribool(rhs))
}
