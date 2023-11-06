pageextension 50102 SalesShipmentLine extends "Sales Shipment Lines"
{
    layout
    {
        addafter("Appl.-to Item Entry")
        {
            field("WHT Business Posting Group"; rec."WHT Business Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Product Posting Group"; rec."WHT Product Posting Group")
            {
                ApplicationArea = all;
            }
            field("WHT Absorb Base"; rec."WHT Absorb Base")
            {
                ApplicationArea = all;
            }
        }
    }
}