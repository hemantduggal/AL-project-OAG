pageextension 50013 PostedSalesShipmentExt extends "Posted Sales Shipments"
{
    layout
    {
        addafter("Shipping Agent Code")//changed
        {
            field("WHT Business Posting Group"; Rec."WHT Business Posting Group")
            {
                ApplicationArea = All;
            }
        }
    }

    trigger OnOpenPage()
    begin


    end;

    var

        UserSetup: Record 91;
}
