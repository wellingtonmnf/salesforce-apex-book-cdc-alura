public with sharing class ShippingAddress {
    
    String zipCode;
    String street;
    
    public ShippingAddress(String zipCode, String street) {
        this.zipCode = zipCode;
        this.street = street;
    }

    public String getZipCode () {
        return this.zipCode;
    }
}