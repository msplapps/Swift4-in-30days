import Foundation

// Some physical constants
public struct Constants {
  public struct Masses {
    public static let amu = 1.67377e-27 // Mass of a neutron/proton in kg
    
    // The remaining are in AMU
    public static let u235 = 235.043924
    public static let neutron = 1.008665
    public static let kr92 = 91.926156
    public static let ba141 = 140.914411
    
    // Products of U235 fission reaction
    public static var products = {
      kr92 + ba141 + 3 * neutron
    }()
  }
  
  public static let avagadro = 6.0221409e+23 // Number of molecules in a mole
  public static let c: Double = 299_792_458 // Speed of light in ms⁻¹
}
